import 'dart:math';

/**
 * @ClassName 学生评估
 * @Author wushaohang
 * @Date 2019-06-06
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';

class StudentAssessment extends StatefulWidget {
  @override
  StudentAssessmentState createState() => StudentAssessmentState();
}

class StudentAssessmentState extends State<StudentAssessment> {
  TextStyle fontCenter = TextStyle(fontSize: ScreenUtil().setSp(32), color: Color(0xff6D7993));

  num degToRad(num deg) => deg * (pi / 180.0);
  List<String> colorItems = [
    'lib/assets/img_blue.png',
    'lib/assets/img_red.png',
    'lib/assets/img_yellow.png',
    'lib/assets/img_blue.png',
    'lib/assets/img_red.png',
    'lib/assets/img_blue.png',
    'lib/assets/img_yellow.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(450),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, -ScreenUtil().setWidth(92)),
            child: Text('QI Skills', style: fontCenter)
          ),
          itemList(),
        ],
      ),
    );
  }

  Widget itemList() {
    List<Widget> tiles = new List();
    int score = 2;

    for (int i = 0; i < 7; i++) {
      tiles.add(
        Positioned(
          child: Transform.rotate(
            origin: Offset(0, -ScreenUtil().setWidth(174)),
            angle: degToRad((360 / 7) * i),
            child: Container(
              width: ScreenUtil().setWidth(180),
              height: ScreenUtil().setWidth(128),
              child: Stack(
                children: <Widget>[
                  Image.asset(colorItems[i]),
                  Positioned(
                    top: ScreenUtil().setWidth(28),
                    left: ScreenUtil().setWidth(42),
                    child: Row(
                      children: <Widget>[
                        for ( int i = 0; i < score; i++ ) Container(
                          child: Image.asset(
                              'lib/assets/icon_star_fill.png',
                              width: ScreenUtil().setWidth(28),
                              height: ScreenUtil().setWidth(28)
                          ),
                          margin: EdgeInsets.only(right: ScreenUtil().setWidth(4)),
                        ),
                        for ( int i = 0; i < 3 - score; i++ ) Container(
                          child: Image.asset(
                              'lib/assets/icon_star.png',
                              width: ScreenUtil().setWidth(28),
                              height: ScreenUtil().setWidth(28)
                          ),
                          margin: EdgeInsets.only(right: ScreenUtil().setWidth(4)),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: ScreenUtil().setWidth(4),
                    left: ScreenUtil().setWidth(82),
                    child: Text('${i + 1}', style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.white),),
                  )
                ],
              ),
            ),
          ),
        )
      );
    }

    return Stack(
      children: tiles,
    );
  }
}