/**
 * @ClassName 学生分数
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';

import 'bar_chart.dart';

class BarChart extends StatefulWidget {
  @override
  BarChartState createState() => BarChartState();
}

class BarChartState extends State<BarChart> {
  List<String> iconStar = ["lib/assets/icon_star3.png", "lib/assets/icon_star2.png", "lib/assets/icon_star1.png"];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: ScreenUtil().setWidth(418),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              for (String item in iconStar) Container(
                width: ScreenUtil().setWidth(34),
                child: Image.asset(item, fit: BoxFit.contain,),
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(82),),
              )
            ],
          ),
          margin: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
        ),
        Column(
          children: <Widget>[
            CustomPaint(
              size:  Size(ScreenUtil().setWidth(567), ScreenUtil().setWidth(360)), //指定画布大小
              painter: MyPainter(),
            ),
            Container(
              width: ScreenUtil().setWidth(567),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (int i = 0; i < 7; i++) Container(
                    child: Text('data${i + 1}', style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Color(0xff6D7993)), softWrap: false),
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(6),),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}


class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 5;
    double eHeight = size.height / 6;
    double bWidth = size.width / 7;

    //画棋盘背景
    var paint = new Paint();

    //  画背景
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Color(0xffEBEEF2)
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 6; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 5; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    Offset point (int index) {
      return Offset((bWidth * index) + ScreenUtil().setWidth(40), (index / 10) * ScreenUtil().setWidth(288));
    }

    double borderSide = ScreenUtil().setWidth(20);

    //  画柱状图
    for (int i = 0; i < 7; ++i) {
      var rrect = RRect.fromLTRBAndCorners(
          point(i).dx - borderSide / 2.0, //  left
          size.height,  //  top
          point(i).dx + borderSide / 2.0,  //  right
          point(i).dy,  //  bottom
          topLeft: Radius.circular(64.0),
          topRight: Radius.circular(64.0),
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(0));
      canvas.drawRRect(
          rrect,
          Paint()
            ..color = Color(0xff29D9D6)
            ..style = PaintingStyle.fill
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}