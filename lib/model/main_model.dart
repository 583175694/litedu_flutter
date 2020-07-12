import 'dart:io';

import 'package:flutter_module/main.dart';
import 'package:flutter_module/model/school_model.dart';
import 'package:flutter_module/model/student_model.dart';
import 'package:flutter_module/plugins/http.dart';
import 'package:dio/dio.dart';

/**
 * @ClassName main_model
 * @Author wushaohang
 * @Date 2020/6/2
 **/
import 'package:scoped_model/scoped_model.dart';

import 'calendar_model.dart';

class MainModel extends Model with CalendarModel, StudentModel, SchoolModel {

  Map<String, dynamic> HEADER = {
    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTU5NDU3MDA2NywiaWF0IjoxNTk0NDgzNjY3LCJuYmYiOjE1OTQ0ODM2NjcsImp0aSI6ImE5OGU2Njc2LWMzOTAtMTFlYS1iYWQ0LTAyNDJhYzE0MDAwNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJpc3MiOiJodHRwczovL2FwaS1kZXYubGl0LWVkdS5jb20vYXBpL2Zyb250ZW5kL2F1dGgvbG9naW4ifQ.aIIpMsHzvgejjUqsAAPuQLWzuwRLaaJTxkNDDRIPmAU",
//    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIsImV4cCI6MTYyMzE1MzE1NywiaWF0IjoxNTkxNjE3MTU3LCJuYmYiOjE1OTE2MTcxNTcsImp0aSI6IjhjM2IyZDljLWE5N2UtMTFlYS05OTg0LTAyNDJhYzEzMDAwNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJpc3MiOiJodHRwczovL2FwaS5saXQtZWR1LmNvbS9hcGkvZnJvbnRlbmQvYXV0aC9sb2dpbiJ9.wqOH7ofcZhaK9kTBagCUGZPABSfZvxc0TCoRX8yDrhY"
  };

  //  学生档案详情
  getStudentArchive() async {
    var response = await HttpUtils.request(
      '/api/frontend/student_archive/',
      method: HttpUtils.POST,
      headers: HEADER,
      data: {
        "student_id": 69,
        "str_date": "2020-06-01",
        "end_date": "2020-07-07"
      });

    mainModel.studentArchive = response["data"];
  }

  //  学生评价列表
  getStudentEvaluation() async {
    var response = await HttpUtils.request(
      '/api/frontend/student_evaluation/?school_course_schedule_id=144',
      method: HttpUtils.GET,
      headers: HEADER
    );

    mainModel.studentEvaluation = response["data"];
  }

  //  学生评价更新
  submitStudentEvaluation(int id) async {
    var response = await HttpUtils.request(
      '/api/frontend/student_evaluation/$id/',
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

  //  获取课程
  getSchoolCourseSchedules() async {
    String endDate = '2100-12-31';
    String startDate = '1970-01-01';
    int id = 20;
    var response = await HttpUtils.request(
        '/api/frontend/classTeam/schoolCourseSchedules?end_date=${endDate}&id=${id}&start_date=${startDate}',
        method: HttpUtils.GET,
        headers: HEADER
    );

    mainModel.schoolCourseSchedules = response["data"];
  }

  //  调课
  reschedule() async {
    var response = await HttpUtils.request(
      '/api/frontend/schoolCourseSchedule/reschedule/',
      method: HttpUtils.POST,
      headers: HEADER,
      data: {
        "end_date": "2019-10-04",
        "start_date": "2019-09-12",
        "class_team_id": 1,
        "course_schedules": [{
          "to_date": "2019-09-12",
          "end_time": "00:30",
          "id": 1,
          "start_time": "00:00"
        }, {
          "id": 2,
          "end_time": "16:30",
          "start_time": "16:00",
          "to_date": "2019-09-12"
        }]
      });
  }

  MainModel of(context) => ScopedModel.of(context);
}
