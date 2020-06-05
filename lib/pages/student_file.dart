/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/components/pie_chart.dart';
import 'package:flutter_module/components/student_attendance.dart';
import 'package:flutter_module/components/student_data.dart';
import 'package:flutter_module/components/student_portraits.dart';
import 'package:flutter_module/components/student_score.dart';

class StudentFile extends StatefulWidget {
  @override
  StudentFileState createState() => StudentFileState();
}

class StudentFileState extends State<StudentFile> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            //  学生数据
            StudentData(),

            //  学生画像
            StudentPortraits(),

            //  学生考勤
            StudentAttendance(),

            //  学生分数
            StudentScore()
          ],
        ),
      ),
    );
  }
}