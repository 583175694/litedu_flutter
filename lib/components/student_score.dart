/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';

import 'bar_chart.dart';

class StudentScore extends StatefulWidget {
  @override
  StudentScoreState createState() => StudentScoreState();
}

class StudentScoreState extends State<StudentScore> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(568),
          height: ScreenUtil().setWidth(400),
          child: BarChart.withSampleData(),
        ),
      ],
    );
  }
}