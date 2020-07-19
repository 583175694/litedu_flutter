/**
 * @ClassName 下拉课程列表
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/school_course.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';


class StudentCourse extends StatefulWidget {
  @override
  StudentCourseState createState() => StudentCourseState();
}

class StudentCourseState extends State<StudentCourse> {
  TextStyle nameFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(32));

  List<Data> schoolCourse = new List();
  List<School_course_schedules> course = new List();
  //  切换课程
  void switchCourse(Data item) {
    course = item.schoolCourseSchedules;
    setState(() {});
  }

  Widget courseItem() {
    List<Widget> tiles = [];
    Widget content;
    for(var item in schoolCourse) {
      tiles.add(
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: ScreenUtil().setWidth(100),
              child: Center(child: Text(item.name, style: nameFont)),
            ),
            onTap: () => switchCourse(item),
          )
      );
    }
    content = new ListView(
        children: tiles
    );
    return content;
  }

  Widget courseList() {
    List<Widget> tiles = [];
    Widget content;
    for(var item in course) {
      tiles.add(
          Container(
            padding: EdgeInsets.all(12.0),
            child: Center(child: Text(item.name, style: nameFont)),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xffF0F1F4)))
            ),
          )
      );
    }
    content = new ListView(
        children: tiles
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);

    schoolCourse = mainModel.schoolCourse.data;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: ScreenUtil().setHeight(960),
          child: courseItem(),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.56,
          height: ScreenUtil().setHeight(960),
          child: courseList(),
          decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Color(0xffF0F1F4)))
          ),
        ),
      ],
    );
  }
}