/**
 * @ClassName line_chart
 * @Author wushaohang
 * @Date 2020/6/7
 **/
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_module/components/screen_fit.dart';

class LineChart extends StatelessWidget {
  TextStyle fontItem = TextStyle(fontSize: ScreenUtil().setSp(22), color: Color(0xffD3D6DE));
  List<String> months = ['一月', '二月', '三月', '四月', '五月'];

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
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 4;
    double eHeight = size.height / 5;

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
      return Offset(eWidth * index, (index / 10) * ScreenUtil().setWidth(288));
    }

    //  画线
    for (int i = 0; i < 4; ++i) {
      canvas.drawLine(point(i), point(i + 1), paint
        ..strokeWidth = ScreenUtil().setWidth(6)
        ..color = Color(0xff29D9D6));
    }

    //  画点
    for (int i = 0; i <= 4; i++) {
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
          point(index).dy + ScreenUtil().setWidth(10),
          point(index).dx,
          size.height)
      );
    };

    //  画柱状图
    for (int i = 0; i <= 4; ++i) {
      canvas.drawLine(
        Offset(point(i).dx, size.height),
        Offset(point(i).dx, point(i).dy + ScreenUtil().setWidth(10)),
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