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

class StudentPortraits extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StudentPortraitsState();
}

class StudentPortraitsState extends State<StudentPortraits> {
  int edge = 6;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(500),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: ScreenUtil().setWidth(70),
            width: MediaQuery.of(context).size.width,
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
              painter: SpiderView(edge),
              size: Size(ScreenUtil().setWidth(360), ScreenUtil().setWidth(360)),
            ),
          ),
        ],
      ),
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

  List<String> item = [ '思维', '艺术', '语言', '体能', '社交', '认知'];

  final double CIRCLE_ANGLE = 360;

  // 整个绘制区域的中点坐标
  double mCenterX = 0;
  double mCenterY = 0;

  SpiderView(this.mEdgeSize) {
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
//    drawSpiderEdge(canvas);
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
      double value = (random.nextInt(10) + 1) / 10;  // 满分为1
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
      double x = mCenterX + radius * 1.32 * cos(degToRad(angle * i)) - ScreenUtil().setWidth(12);
      double y = mCenterY + radius * 1.32 * sin(degToRad(angle * i)) - ScreenUtil().setWidth(16);

      ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: ScreenUtil().setSp(22)
      ))
        ..pushStyle(ui.TextStyle(color: Color(0xff6D7993)))
        ..addText(item[i]);
      ParagraphConstraints pc = ParagraphConstraints(width: ScreenUtil().setWidth(48));
      Paragraph paragraph = pb.build()..layout(pc);

      canvas.drawCircle(
          Offset(x - ScreenUtil().setWidth(18), y + ScreenUtil().setWidth(18)),
          ScreenUtil().setWidth(6),
          mPaint
            ..color = Color(0xffFFA938)
            ..style = PaintingStyle.fill
      );
      canvas.drawParagraph(paragraph, Offset(x, y));
    }
  }
}
