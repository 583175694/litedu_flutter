/**
 * @ClassName 学生考勤
 * @Author wushaohang
 * @Date 2020-06-05
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/pie_chart.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/student_archive.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';


class StudentAttendance extends StatefulWidget {
  @override
  StudentAttendanceState createState() => StudentAttendanceState();
}

class StudentAttendanceState extends State<StudentAttendance> {
  TextStyle fontDefault = TextStyle(fontSize: ScreenUtil().setSp(22), color: Color(0xff6D7993));
  TextStyle activeDefault = TextStyle(fontSize: ScreenUtil().setSp(56), color: Color(0xff29D9D6));
  final List<Color> colors = [
    Color(0xff29D9D6),
    Color(0xffFFA938),
    Color(0xffFC4F4D)
  ];

  Attendances attendances;

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);

    attendances = mainModel.studentArchive == null ? null : mainModel.studentArchive.attendances;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(364),
              height: ScreenUtil().setWidth(364),
              child: PieChart.withSampleData(),
            ),
            Positioned(
              width: ScreenUtil().setWidth(364),
              height: ScreenUtil().setWidth(364),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('丁丁上学', style: fontDefault),
                  Text.rich(
                    TextSpan(
                      text: '${attendances.total}',
                      style: activeDefault,
                      children: <TextSpan>[
                        TextSpan(text: '天', style: fontDefault),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              attendanceValue(0, attendances.total == 0 ? '0%' : "${attendances.presence / attendances.total}%", '考勤正常'),
              attendanceValue(1, attendances.total == 0 ? '0%' : "${attendances.leave / attendances.total}%", '请假'),
              attendanceValue(2, attendances.total == 0 ? '0%' : "${attendances.absence / attendances.total}%", '考勤异常'),
            ],
          ),
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
        )
      ],
    );
  }

  Container attendanceValue(int index, String percent, String value) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(12),
            height: ScreenUtil().setWidth(12),
            decoration: BoxDecoration(
                color: colors[index],
                borderRadius: BorderRadius.all(
                    Radius.circular(12)
                )
            ),
          ),
          Container(
            child: Text(percent, style: fontDefault),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(14)),
          ),
          Container(
            child: Text(value, style: fontDefault),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(24)),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(24)),
    );
  }
}