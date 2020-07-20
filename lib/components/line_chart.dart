/**
 * @ClassName line_chart
 * @Author wushaohang
 * @Date 2020/6/7
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/entity/qis.dart';
import 'dart:math';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_module/components/screen_fit.dart';

import '../main.dart';

class LineChart extends StatelessWidget {
  TextStyle fontItem = TextStyle(fontSize: ScreenUtil().setSp(22), color: Color(0xffD3D6DE));
  List<String> months = ['一月', '二月', '三月', '四月', '五月'];

  Qis studentEvaluationQis;

  List<int> results = new List();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < 6; i++) Container(
                child: Text('${(5 - i) * 20}', style: fontItem,),
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(28)),
              )
            ],
          ),
          margin: EdgeInsets.only(right: ScreenUtil().setWidth(4)),
        ),
        Container(
          child: Column(
            children: <Widget>[
              CustomPaint(
                size:  Size(ScreenUtil().setWidth(588), ScreenUtil().setWidth(288)), //指定画布大小
                painter: MyPainter(),
              ),
              Container(
                width: ScreenUtil().setWidth(588),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    for ( String item in months) Container(
                      width: 0,
                      child: Text(item, style: fontItem),
                    )
                  ],
                ),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(24), top: ScreenUtil().setWidth(14)),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  Qis studentEvaluationQis;
  List<int> results;

  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 7;
    double eHeight = size.height / 5;

    studentEvaluationQis = mainModel.studentEvaluationQis;
    results = [
      studentEvaluationQis.results[0].abilityTest1Score,
      studentEvaluationQis.results[0].abilityTest2Score,
      studentEvaluationQis.results[0].abilityTest3Score,
      studentEvaluationQis.results[0].abilityTest4Score,
      studentEvaluationQis.results[0].abilityTest5Score,
      studentEvaluationQis.results[0].abilityTest6Score,
      studentEvaluationQis.results[0].abilityTest7Score
    ];

    //画棋盘背景
    var paint = new Paint();

    //  画背景
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Color(0xffEBEEF2)
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 5; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 4; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    Offset point (int index) {
      if (results[index] > 10) {
        results[index] = 10;
      }
      return Offset(eWidth * index, (results[index] / 10) * ScreenUtil().setWidth(288));
    }

    print(results.length);

    //  画线
    for (int i = 0; i < results.length - 1; ++i) {
      canvas.drawLine(point(i), point(i + 1), paint
        ..strokeWidth = ScreenUtil().setWidth(6)
        ..color = Color(0xff29D9D6));
    }

    //  画点
    for (int i = 0; i <= results.length - 1; i++) {
      canvas.drawCircle(point(i), ScreenUtil().setWidth(8), paint
        ..style = PaintingStyle.fill
        ..color = Color(0xff29D9D6));

      canvas.drawCircle(point(i), ScreenUtil().setWidth(3), paint
        ..style = PaintingStyle.fill
        ..color = Colors.white);
    }

    //  渐变色
    Shader shader(int index) {
      return  LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.clamp,
          colors: [Colors.white, Color(0xff29D9D6)])
          .createShader(Rect.fromLTRB(
          point(index).dx,
          point(index).dy + ScreenUtil().setWidth(30),
          point(index).dx,
          size.height)
      );
    };

    //  画柱状图
    for (int i = 0; i <= results.length - 1; ++i) {
      canvas.drawLine(
        Offset(point(i).dx, size.height),
        Offset(point(i).dx, point(i).dy + ScreenUtil().setWidth(30)),
        paint
          ..style = PaintingStyle.fill
          ..strokeWidth = ScreenUtil().setWidth(16)
          ..shader = shader(i)
          ..color = Color(0xff29D9D6))
      ;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}