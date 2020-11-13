/**
 * @ClassName 学生画像
 * @Author wushaohang
 * @Date 2020/6/3
 **/

import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/student_archive.dart';
import 'package:flutter_module/entity/student_evaluation_stages.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_module/model/main_model.dart';

import '../main.dart';

class StudentPortraits extends StatefulWidget {
  StudentPortraits({Key key, this.origin}) : super(key: key);
  final String origin;

  @override
  State<StatefulWidget> createState() => StudentPortraitsState();
}

class StudentPortraitsState extends State<StudentPortraits> {
  int edge = 6;
  Six_skills sixSkills;

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);

    return LayoutBuilder(
        builder: (context, constraints){
          return Container(
            height: ScreenUtil().setWidth(600),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: ScreenUtil().setWidth(120),
                  width: constraints.maxWidth,
                  height: ScreenUtil().setWidth(360),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('lib/assets/img_hexagon.png'),
                    ],
                  ),
                ),
                Center(
                  child: CustomPaint(
                    painter: SpiderView(edge, widget.origin),
                    size: Size(ScreenUtil().setWidth(360), ScreenUtil().setWidth(360)),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}

class SpiderView extends CustomPainter {
  Paint mPaint;

  // 覆盖物画笔
  Paint mCoverPaint;

  // 文本画笔
  Paint mTextPaint;

  //  路径
  Path mPath;

  // 绘制边数默认为6
  int mEdgeSize = 6;

  String origin;

  List<String> item = ['语言发展', '身心健康', '社交与情感', '思维逻辑', '环境与世界', '文化与艺术'];

  final double CIRCLE_ANGLE = 360;

  // 整个绘制区域的中点坐标
  double mCenterX = 0;
  double mCenterY = 0;

  Six_skills sixSkills;
  StudentEvaluationStages stages;

  List skillList = new List();

  SpiderView(this.mEdgeSize, this.origin) {

    if (mainModel.studentArchive == null) {
      sixSkills = null;
    } else if (origin == 'archive') {
      sixSkills = mainModel.studentArchive.sixSkills;

      skillList = [
        sixSkills.abilityTest1, sixSkills.abilityTest2,
        sixSkills.abilityTest3, sixSkills.abilityTest4,
        sixSkills.abilityTest5, sixSkills.abilityTest6
      ];
    }

    if (mainModel.studentEvaluationStages == null) {
      stages = null;
    } else if (origin == 'evaluationReport') {
      stages = mainModel.studentEvaluationStages;

      if (stages.results.isEmpty) {
        skillList = List(6);
      } else {
        skillList = [
          stages.results[0].abilityTest1, stages.results[0].abilityTest2,
          stages.results[0].abilityTest3, stages.results[0].abilityTest4,
          stages.results[0].abilityTest5, stages.results[0].abilityTest6
        ];
      }
    }

    // 初始化画笔
    mPaint = Paint();

    // 样式为描边
    mPaint
      ..style = PaintingStyle.stroke
      ..color = Color(0xffA8F2EC)
      ..isAntiAlias = true
      ..strokeWidth = 1.0
    ;

    mPath = Path();

    mCoverPaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color.fromRGBO(50, 218, 215, 0.5)
    ;

    mTextPaint = Paint();
    mTextPaint.isAntiAlias = true;
    mTextPaint.style = PaintingStyle.fill;
    mTextPaint.color = Colors.blue;
  }

  @override
  void paint(Canvas canvas, Size size) {
    mCenterX = size.width / 2;
    mCenterY = size.height / 2;

    // 图层 防止刷新属性结构
    canvas.save();
    drawText(canvas);
    drawCover(canvas);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  /**
   * 绘制边线
   */
  void drawSpiderEdge(Canvas canvas) {
    double angle = CIRCLE_ANGLE / mEdgeSize;
    double radius = 0;
    double radiusMaxLimit = mCenterX > mCenterY ? mCenterX : mCenterY;
    for (int i = 0; i < mEdgeSize; i++) {
      mPath.reset();
      radius = radiusMaxLimit / mEdgeSize * (i + 1);
      for (int j = 0; j < mEdgeSize + 1; j++) {
        // 移动
        if (j == 0) {
          mPath.moveTo(mCenterX, mCenterY + radius);
        } else {
          double x = mCenterX + radius * cos(degToRad(angle * j));
          double y = mCenterY + radius * sin(degToRad(angle * j));
          mPath.lineTo(x, y);
        }
      }
      mPath.close();
      if (i == mEdgeSize - 1) {
        mPaint
          ..strokeWidth = 2.0
          ..color = Color.fromRGBO(63, 221, 219, 1)
        ;
      } else {
        mPaint
          ..strokeWidth = 1.0
          ..color = Color.fromRGBO(41, 217, 214, 0.2)
        ;
      }
      canvas.drawPath(mPath, mPaint);
    }
    drawText(canvas);
  }

  num degToRad(num deg) => (deg + 90) * (pi / 180.0);

  num radToDeg(num rad) => rad * (180.0 / pi);

  /**
   * 绘制覆盖区域
   */
  void drawCover(Canvas canvas) {
    mPath.reset();
    Random random = Random();

    double angle = CIRCLE_ANGLE / mEdgeSize;
    double radiusMaxLimit = min(mCenterY, mCenterY);
    for (int i = 0; i < mEdgeSize; i++) {
      double value = skillList.isEmpty ? 0 : skillList[i].percent > 1.0 ? 1.0 : skillList[i].percent;  // 满分为1
      double x = mCenterX + radiusMaxLimit * cos(degToRad(angle * i)) * value;
      double y = mCenterY + radiusMaxLimit * sin(degToRad(angle * i)) * value;
      if (i == 0) {
        mPath.moveTo(x, y);
      } else {
        mPath.lineTo(x, y);
      }
    }
    mPath.close();
    canvas.drawPath(mPath, mCoverPaint);
  }

  /***
   * 绘制文本
   */
  void drawText(Canvas canvas) {
    double angle = CIRCLE_ANGLE / mEdgeSize;
    double radius = mCenterX > mCenterY ? mCenterX : mCenterY;
    //  描述
    for (int i = 0; i < mEdgeSize; i++) {
      double x = mCenterX + radius * 1.48 * cos(degToRad(angle * i)) - ScreenUtil().setWidth(42);
      double y = mCenterY + radius * 1.22 * sin(degToRad(angle * i)) - ScreenUtil().setWidth(16);

      ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: ScreenUtil().setSp(22)
      ))
        ..pushStyle(ui.TextStyle(color: Color(0xff6D7993)))
        ..addText(item[i]);
      ParagraphConstraints pc = ParagraphConstraints(width: ScreenUtil().setWidth(118));
      Paragraph paragraph = pb.build()..layout(pc);

      canvas.drawCircle(
          Offset(x - ScreenUtil().setWidth(14), y + ScreenUtil().setWidth(16)),
          ScreenUtil().setWidth(6),
          mPaint
            ..color = Color(0xffFFA938)
            ..style = PaintingStyle.fill
      );
      canvas.drawParagraph(paragraph, Offset(x, y));
    }
  }
}
