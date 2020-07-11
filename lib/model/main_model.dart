import 'dart:io';

import 'package:flutter_module/main.dart';
import 'package:flutter_module/model/student_model.dart';
import 'package:flutter_module/plugins/http.dart';
/**
 * @ClassName main_model
 * @Author wushaohang
 * @Date 2020/6/2
 **/
import 'package:scoped_model/scoped_model.dart';

import 'calendar_model.dart';

class MainModel extends Model with CalendarModel, StudentModel {

  Map<String, dynamic> HEADER = {
    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIsImV4cCI6MTYyMzE1MzE1NywiaWF0IjoxNTkxNjE3MTU3LCJuYmYiOjE1OTE2MTcxNTcsImp0aSI6IjhjM2IyZDljLWE5N2UtMTFlYS05OTg0LTAyNDJhYzEzMDAwNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJpc3MiOiJodHRwczovL2FwaS5saXQtZWR1LmNvbS9hcGkvZnJvbnRlbmQvYXV0aC9sb2dpbiJ9.wqOH7ofcZhaK9kTBagCUGZPABSfZvxc0TCoRX8yDrhY"
  };

  //  获取我的学生
  getMyStudents() async {
    var response = await HttpUtils.request(
        '/api/frontend/guardian/myStudents',
        headers: HEADER,
        method: HttpUtils.GET,
        data: {});
    mainModel.myStudents = response["data"];
    print(mainModel.myStudents);
  }

  //  获取时间(学期)
  getSemester() async {
    var response = await HttpUtils.request(
      '/papi/api/frontend/semester',
      method: HttpUtils.GET,
      data: {
        "school_id": 1
      });
    mainModel.semester = response["data"];
  }

  //  学生的教学反馈
  getTeachFeedbackList() async {
    var response = await HttpUtils.request(
      '/api/frontend/student/teachFeedbackList',
      method: HttpUtils.POST,
      data: {
        "id": 172, // 学生id
        "start_date":"2019-01-01",
        "end_date":"2022-01-01",
        "page": 1
      });
    mainModel.teachFeedbackList = response["data"];
  }

  //  课后反馈
  getStudentAfterTeachFeedbackList() async {
    var response = await HttpUtils.request(
        '/api/frontend/student/studentAfterTeachFeedbackList',
        method: HttpUtils.POST,
        data: {
          "id": 172, // 学生id
          "start_date":"2019-01-01",
          "end_date":"2022-01-01"
        });
    mainModel.teachFeedbackList = response["data"];
  }


  //  学生档案详情
  getStudentArchive() async {
    var response = await HttpUtils.request(
      '/api/frontend/student/archive',
      method: HttpUtils.POST,
      data: {
        "id": 179, // 学生id
        "start_date":"2019-01-01",
        "end_date":"2022-01-01"
      });
    mainModel.studentArchive = response["data"];
  }

  //  课程安排对应的学生表现列表
  getStudentManifests() async {
    var response = await HttpUtils.request(
      '/api/frontend/schoolCourseSchedule/studentManifests',
      method: HttpUtils.POST,
      data: {
        "id": 1 // 课程安排
      });
    mainModel.studentManifests = response["data"];
  }

  //  课程安排对应的学生表现列表
  studentEvaluate() async {
    var response = await HttpUtils.request(
      '/api/frontend/studentManifest/evaluate',
      method: HttpUtils.POST,
      data: {
        "id": 1,
        "student_id": 1,
        "school_course_schedule_id": 1,
        "drafts": [],// 图片视频混合数组
        "created_at": null,
        "updated_at": null,
        "content": "内容",
        "ability_test1_score": 60,
        "ability_test2_score": 60,
        "ability_test3_score": 0,
        "ability_test4_score": 0,
        "ability_test5_score": 0,
        "ability_test6_score": 0,
        "attribute_labels": [
          {
            "id": 1,
            "label": "乖巧可爱",
            "label_color": "666666",
            "background_color": "446666",
            "created_at": null,
            "updated_at": null
          }
        ]
      });
  }

  //  课程安排时间修改
  updateCourseDateTime() async {
    var response = await HttpUtils.request('/api/frontend/schoolCourseSchedule/updateCourseDateTime', method: HttpUtils.POST, data: {
      "id": 1, // 课程安排的id
      "to_date": "2018-01-03",
      "start_time": "12:00:00"
    });
  }

  //  课程安排时间交换
  exchangeCourse() async {
    var response = await HttpUtils.request('/api/frontend/schoolCourseSchedule/updateCourseDateTime', method: HttpUtils.POST, data: {
      "original_school_course_schedule_id": 1, // 课程安排的id
      "second_school_course_schedule_id": 1,// 被交换课程安排的id
    });
  }








  // GET 请求
  // 返回的结果直接就是 json 格式
  handleGetShelf() async {
    var response = await HttpUtils.request('sell/buyer/product/list', method: HttpUtils.GET, data: {
      'id': 2,
    });
  }

// POST 请求
  handleAddShelf() async {
    var response = await HttpUtils.request('/gysw/shelf', method: HttpUtils.POST, data: {
      'id': 1,
    });
  }

// PUT 请求
  handleEditShelf() async {
    var response = await HttpUtils.request('/gysw/shelf/:id', method: HttpUtils.PUT, data: {
      'id': 1,
    });
  }

  MainModel of(context) => ScopedModel.of(context);
}
