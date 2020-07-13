import 'dart:io';

import 'package:flutter_module/entity/student_evaluation.dart';
import 'package:flutter_module/main.dart';
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

class MainModel extends Model with CalendarModel, StudentModel, SchoolModel {

  Map<String, dynamic> HEADER = {
    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTYyNjEwODg4MywiaWF0IjoxNTk0NTcyODgzLCJuYmYiOjE1OTQ1NzI4ODMsImp0aSI6IjYyMjUzZDM0LWM0NjAtMTFlYS05ODUwLTAyNDJhYzE0MDAwNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJpc3MiOiJodHRwczovL2FwaS1kZXYubGl0LWVkdS5jb20vYXBpL2Zyb250ZW5kL2F1dGgvbG9naW4ifQ.GS-kairdnvZLFUAEiZljG2Z0IW3G7L1IEm4pjpBuAuI"
  };

  //  学生档案详情
  getStudentArchive() async {
    var response = await HttpUtils.request(
      '/papi/api/frontend/student_archive/',
      method: HttpUtils.POST,
      headers: HEADER,
      data: {
        "student_id": 70,
        "str_date": "2020-06-01",
        "end_date": "2020-07-07"
      });

    mainModel.studentArchive = response["data"];
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
  submitStudentEvaluation(int id) async {
    var response = await HttpUtils.request(
      '/papi/api/frontend/student_evaluation/$id/',
      method: HttpUtils.PATCH,
      headers: HEADER,
      data: {
        "content": "备注一下课堂要点",
        "attribute_labels": [1, 4, 7],
        "question_scores": [1, 5, 9, 9, 5]
      }
    );

    mainModel.studentEvaluation = response["data"];
  }

  //  获取班级
  getClassTeam() async {
    var response = await HttpUtils.request(
        '/api/frontend/classTeam/index/',
        method: HttpUtils.GET,
        headers: HEADER
    );

    mainModel.classTeam = response["data"];
  }

  //  获取课程
  getSchoolCourseSchedules() async {
    String endDate = '${mainModel.currentDateModel.year}-${mainModel.currentDateModel.month}-${mainModel.currentDateModel.day}';
    String startDate = '${mainModel.currentDateModel.year}-${mainModel.currentDateModel.month}-${mainModel.currentDateModel.day}';
    int id = mainModel.classTeam[0]["id"];
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
        "class_team_id": mainModel.classTeam[0]["id"],
        "course_schedules": courseList
      });
  }


  //  初始化请求
  void initializeRequest() async {
    Common common = new Common();
    //  请求班级
    await mainModel.getClassTeam();

    //  请求课程
    await mainModel.getSchoolCourseSchedules();

    //  判断有第几节课
    List<dynamic> schedules = mainModel.schoolCourseSchedules[0]["school_course_schedules"];

    List titleItems = new List(11);

    if (schedules.isEmpty) {
      mainModel.currentCourse = titleItems;
      return;
    }

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
