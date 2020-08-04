/**
 * @ClassName 学生分数
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/student_archive.dart';

import '../main.dart';

class BarChart extends StatefulWidget {
  @override
  BarChartState createState() => BarChartState();
}

class BarChartState extends State<BarChart> {
  List<String> iconStar = ["lib/assets/icon_star3.png", "lib/assets/icon_star2.png", "lib/assets/icon_star1.png"];
  Qi_skills qiSkills;
  List<String> skills = ["自主力", "共感力", "探索力", "内驱力", "折腾力", "耐挫力", "创造力"];

  Offset clickOffset; //  点击位置
  List<Map> listBar = new List();

  int clickIndex;  //  当前选中索引

  @override
  Widget build(BuildContext context) {
    List<int> qiSkillsList = new List();

    if (mainModel.studentArchive == null) {
      qiSkills = null;
    } else {
      qiSkills = mainModel.studentArchive.qiSkills;
      qiSkillsList.addAll([
        qiSkills.qiAbility1, qiSkills.qiAbility2,
        qiSkills.qiAbility3, qiSkills.qiAbility4,
        qiSkills.qiAbility5, qiSkills.qiAbility6,
        qiSkills.qiAbility7
      ]);

      for (int index = 0; index < 7; index++) {
        Offset barOffset = Offset((ScreenUtil().setWidth(567) / 7 * index) + ScreenUtil().setWidth(40), (index / 10) * ScreenUtil().setWidth(288));
        listBar.add({
          "offset": barOffset,
          "key": index
        });
      }
    }

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
            GestureDetector(
              child: CustomPaint(
                size:  Size(ScreenUtil().setWidth(567), ScreenUtil().setWidth(360)), //指定画布大小
                painter: MyPainter(qiSkillsList, clickIndex),
              ),
              onTapUp: (TapUpDetails details) => switchBar(details),
            ),
            Container(
              width: ScreenUtil().setWidth(567),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (int i = 0; i < 7; i++) Container(
                    child: Text(skills[i], style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Color(0xff6D7993)), softWrap: false),
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

  switchBar(TapUpDetails details) {
    clickOffset = Offset(details.localPosition.dx, details.localPosition.dy);

    listBar.sort((a, b) {
      var distanceA = (clickOffset.dx - a["offset"].dx).abs();
      var distanceB = (clickOffset.dx - b["offset"].dx).abs();
      return (distanceA - distanceB).floor();
    });

    var distance = (clickOffset.dx - listBar.first["offset"].dx).abs();
    clickIndex = listBar.first["key"];
    mainModel.currentQis = clickIndex;
    setState(() {});
  }
}


class MyPainter extends CustomPainter {
  MyPainter(List<int> qiSkillsList, int clickIndex)
      : _qiSkillsList = qiSkillsList,
        _clickIndex = clickIndex
  ;

  List<int> _qiSkillsList;
  int _clickIndex; //  点击位置

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
    for (int i = 0; i < _qiSkillsList.length; ++i) {
      var rrect = RRect.fromLTRBAndCorners(
          point(i).dx - borderSide / 2.0, //  left
          size.height,  //  top
          point(i).dx + borderSide / 2.0,  //  right
          150.0 - ((_qiSkillsList[i] > 10 ? 10 : _qiSkillsList[i]) * 15),  //  bottom
          topLeft: Radius.circular(64.0),
          topRight: Radius.circular(64.0),
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(0));
      canvas.drawRRect(
          rrect,
          Paint()
            ..color = _clickIndex == i ? Color(0xff29D9D6) : Colors.black12
            ..style = PaintingStyle.fill
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}