/**
 * @ClassName 下拉学期列表
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/school_course.dart';
import 'package:flutter_module/entity/semester.dart';
import 'package:flutter_module/main.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class StudentSemester extends StatefulWidget {
  @override
  StudentSemesterState createState() => StudentSemesterState();
}

class StudentSemesterState extends State<StudentSemester> {
  TextStyle nameFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(32));

  Semester schoolSemester;
  Results currentSemester;
  //  切换课程
  void onChooseSemester(Results item) {
    currentSemester = item;
    mainModel.currentSemester = currentSemester;
    mainModel.getStages();
    setState(() {});

    Navigator.pop(context);
  }

  Widget courseItem() {
    if (schoolSemester.results == null) return Container();

    List<Widget> tiles = [];
    Widget content;
    for(var item in schoolSemester.results) {
      tiles.add(
          GestureDetector(
            child: Container(
              height: ScreenUtil().setWidth(100),
              child: Center(child: Text(item.name, style: nameFont)),
            ),
            onTap: () => onChooseSemester(item),
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

    schoolSemester = mainModel.semester;

    return Container(
      width: ScreenUtil().setWidth(738),
      height: ScreenUtil().setHeight(560),
      child: courseItem(),
    );
  }
}