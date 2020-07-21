import 'dart:io';

import 'package:flutter_module/entity/class_team.dart';
import 'package:flutter_module/entity/qis.dart';
import 'package:flutter_module/entity/school_course.dart';
import 'package:flutter_module/entity/semester.dart';
import 'package:flutter_module/entity/student_archive.dart';
import 'package:flutter_module/entity/student_evaluation.dart';
import 'package:flutter_module/entity/student_evaluation_stages.dart';
import 'package:flutter_module/main.dart';
import 'package:flutter_module/model/home_model.dart';
import 'package:flutter_module/model/school_model.dart';
import 'package:flutter_module/model/student_model.dart';
import 'package:flutter_module/plugins/common.dart';
import 'package:flutter_module/plugins/http.dart';

/**
 * @ClassName main_model
 * @Author wushaohang
 * @Date 2020/6/2
 **/
import 'package:scoped_model/scoped_model.dart';

import 'calendar_model.dart';

class MainModel extends Model with HomeModel, CalendarModel, StudentModel, SchoolModel {

  Map<String, dynamic> HEADER = {
    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTYyNjEwODg4MywiaWF0IjoxNTk0NTcyODgzLCJuYmYiOjE1OTQ1NzI4ODMsImp0aSI6IjYyMjUzZDM0LWM0NjAtMTFlYS05ODUwLTAyNDJhYzE0MDAwNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJpc3MiOiJodHRwczovL2FwaS1kZXYubGl0LWVkdS5jb20vYXBpL2Zyb250ZW5kL2F1dGgvbG9naW4ifQ.GS-kairdnvZLFUAEiZljG2Z0IW3G7L1IEm4pjpBuAuI"
  };

  //  学生档案详情
  getStudentArchive(String studentId, [String strDate, String endDate]) async {
    var response = await HttpUtils.request(
      '/papi/api/frontend/student_archive/',
      method: HttpUtils.POST,
      headers: HEADER,
      data: {
        "student_id": studentId,
        "str_date": strDate,
        "end_date": endDate
      });
    StudentArchive data = StudentArchive.fromJson(response["data"]);

    mainModel.studentArchive = data;
  }

  //  学生评价列表
  getStudentEvaluation(int id) async {
    var response = await HttpUtils.request(
      '/papi/api/frontend/student_evaluation/?school_course_schedule_id=$id',
      method: HttpUtils.GET,
      headers: HEADER,
    );
    StudentEvaluation data = StudentEvaluation.fromJson(response["data"]);

    mainModel.studentEvaluation = data;
  }

  //  学生评价更新
  submitStudentEvaluation(int id, String content, List<int> questionScores, List<int> attributeLabels) async {
    var response = await HttpUtils.request(
      '/papi/api/frontend/student_evaluation/$id/',
      method: HttpUtils.PATCH,
      headers: HEADER,
      data: {
        "drafts": [],
        "content": content,
        "attribute_labels": attributeLabels,
        "question_scores": questionScores
      }
    );
  }

  //  获取班级
  Future getClassTeam() async {
    var response = await HttpUtils.request(
        '/api/frontend/classTeam/index/',
        method: HttpUtils.GET,
        headers: HEADER
    );

    ClassTeam data = ClassTeam.fromJson(response);

    mainModel.classTeam = data.data;

    return data;
  }

  //  获取课程
  getSchoolCourseSchedules() async {
    String endDate = '${mainModel.currentDateModel.year}-${mainModel.currentDateModel.month}-${mainModel.currentDateModel.day}';
    String startDate = '${mainModel.currentDateModel.year}-${mainModel.currentDateModel.month}-${mainModel.currentDateModel.day}';
    int id = mainModel.classTeam[0].id;
    var response = await HttpUtils.request(
        '/api/frontend/classTeam/schoolCourseSchedules?end_date=${endDate}&id=${id}&start_date=${startDate}',
        method: HttpUtils.GET,
        headers: HEADER
    );

    mainModel.schoolCourseSchedules = response["data"];
  }

  //  调课
  reschedule(List courseList) async {
    String date = '${mainModel.currentDateModel.year}-${mainModel.currentDateModel.month}-${mainModel.currentDateModel.day}';

    var response = await HttpUtils.request(
      '/api/frontend/schoolCourseSchedule/reschedule/',
      method: HttpUtils.POST,
      headers: HEADER,
      data: {
        "end_date": date,
        "start_date": date,
        "class_team_id": mainModel.classTeam[0].id,
        "course_schedules": courseList
      });
  }

  //  学期课程列表
  getSchoolCourse() async {
    String endDate = mainModel.currentSemester.endDate;
    String startDate = mainModel.currentSemester.strDate;
    int id = mainModel.studentId;
    var response = await HttpUtils.request(
        '/papi/api/frontend/semester/school_course?end_date=${endDate}&student_id=${id}&str_date=${startDate}',
        method: HttpUtils.GET,
        headers: HEADER
    );

    SchoolCourse data = SchoolCourse.fromJson(response);

    mainModel.schoolCourse = data;
  }

  //  学期列表
  getSemester() async {
    int schoolId = mainModel.schoolId;
    var response = await HttpUtils.request(
        '/papi/api/frontend/semester?school_id=${schoolId}',
        method: HttpUtils.GET,
        headers: HEADER
    );

    Semester data = Semester.fromJson(response["data"]);

    mainModel.semester = data;
    mainModel.currentSemester = data.results[0];
  }

  //  学生阶段评价详情(六边形)
  getStages() async {
    int sid = mainModel.studentId;
    String endDate = mainModel.currentSemester.endDate;
    String startDate = mainModel.currentSemester.strDate;
    var response = await HttpUtils.request(
        '/papi/api/frontend/student_evaluation/${sid}/stages?end_date=${endDate}&str_date=${startDate}',
        method: HttpUtils.GET,
        headers: HEADER
    );

    StudentEvaluationStages data = StudentEvaluationStages.fromJson(response["data"]);

    mainModel.studentEvaluationStages = data;
  }

  //  学生阶段评价详情(七边形)
  getQis(String studentId, [String strDate, String endDate]) async {
//    int sid = mainModel.studentId;
//    String endDate = mainModel.currentSemester.endDate;
//    String startDate = mainModel.currentSemester.strDate;
    var response = await HttpUtils.request(
        '/papi/api/frontend/student_evaluation/${studentId}/qis?end_date=${endDate}&str_date=${strDate}',
        method: HttpUtils.GET,
        headers: HEADER
    );

    Qis data = Qis.fromJson(response["data"]);

    mainModel.studentEvaluationQis = data;
  }


  //  初始化请求
  void initializeRequest() async {
    Common common = new Common();
    //  请求课程
    await mainModel.getSchoolCourseSchedules();

    List titleItems = new List(11);

    if (mainModel.schoolCourseSchedules.isEmpty) {
      mainModel.currentCourse = titleItems;
      return;
    }

    //  判断有第几节课
    List<dynamic> schedules = mainModel.schoolCourseSchedules[0]["school_course_schedules"];

    List courseList = new List();
    schedules.forEach((res) {
      courseList.add(common.getDuration(res["start_time"]));
    });

    courseList.forEach((res) {
      titleItems[res];
    });

    for (int i =0; i < courseList.length; i++) {
      titleItems[courseList[i]] = schedules[i];
    }

    mainModel.currentCourse = titleItems;
  }

  MainModel of(context) => ScopedModel.of(context);
}
