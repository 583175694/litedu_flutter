/**
 * @ClassName alert_dialog
 * @Author wushaohang
 * @Date 2020/7/14
 **/
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/school_course.dart';

YYDialog YYAlertDialogWithGravity({width, gravity, doubleButtonGravity, context, schoolCourse, setState}) {
  TextStyle nameFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(32));
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
            height: ScreenUtil().setWidth(100),
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

  return YYDialog().build()
    ..gravity = gravity
    ..gravityAnimationEnable = true
    ..borderRadius = 16.0
    ..height = ScreenUtil().setHeight(1000)
    ..widgetList = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: width * 0.4,
            height: ScreenUtil().setHeight(960),
            child: courseItem(),
          ),
          Container(
            width: width * 0.56,
            height: ScreenUtil().setHeight(960),
            child: courseList(),
            decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Color(0xffF0F1F4)))
            ),
          ),
        ],
      )
    ]
    ..show();
}