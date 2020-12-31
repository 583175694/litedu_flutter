/**
 * @ClassName line_chart
 * @Author wushaohang
 * @Date 2020/6/7
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/entity/qis.dart';
import 'package:flutter_module/entity/student_evaluation_trends.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_module/components/screen_fit.dart';

import '../main.dart';
class LineChart extends StatefulWidget {
  @override
  LineChartState createState() => LineChartState();
}

class LineChartState extends State<LineChart> {
  TextStyle fontItem = TextStyle(fontSize: ScreenUtil().setSp(22), color: Color(0xffD3D6DE));
  List<String> months = new List();
  List<Trends> trends = new List();
  Qis studentEvaluationQis;

  @override
  void initState() {
    super.initState();

    DateTime date = new DateTime.now();

    for (int i = 4; i >= 0; i--) {
      months.add('${date.month - i}月');
    }
  }

  @override
  Widget build(BuildContext context) {
    mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);

    //  获取七边形趋势数据
    trends = mainModel.studentEvaluationQisTrends;
    List<double> results = new List();

    trends.forEach((Trends res) {
      switch (mainModel.currentQis) {
        case 0 :
          results.add(res.sumAbilityTest1Score);
          break;
        case 1 :
          results.add(res.sumAbilityTest2Score);
          break;
        case 2 :
          results.add(res.sumAbilityTest3Score);
          break;
        case 3 :
          results.add(res.sumAbilityTest4Score);
          break;
        case 4 :
          results.add(res.sumAbilityTest5Score);
          break;
        case 5 :
          results.add(res.sumAbilityTest6Score);
          break;
        case 6 :
          results.add(res.sumAbilityTest7Score);
          break;
        default:
          results.add(res.sumAbilityTest1Score);
      }
      setState(() {});
    });

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
                painter: MyPainter(studentEvaluationQis, results),
              ),
              Container(
                width: ScreenUtil().setWidth(588),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    for ( String item in months) Container(
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
  MyPainter(Qis studentEvaluationQis, List<double> results)
      : _studentEvaluationQis = studentEvaluationQis,
        _results = results
  ;
  Qis _studentEvaluationQis;
  List<double> _results = new List();


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
      if (_results[index] > 100) {
        _results[index] = 100;
      }
      return Offset(eWidth * index, size.height - (_results[index] / 100) * ScreenUtil().setWidth(288));
    }

    //  画线
    for (int i = 0; i < _results.length - 1; ++i) {
      canvas.drawLine(point(i), point(i + 1), paint
        ..strokeWidth = ScreenUtil().setWidth(6)
        ..color = Color(0xff29D9D6));
    }

    //  画点
    for (int i = 0; i <= _results.length - 1; i++) {
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
          point(index).dy + ScreenUtil().setWidth(8),
          point(index).dx,
          size.height)
      );
    };

    //  画柱状图
    for (int i = 0; i <= _results.length - 1; ++i) {
      if (_results[i] <= 0) { continue; }
      canvas.drawLine(
        Offset(point(i).dx, size.height),
        Offset(point(i).dx, point(i).dy + ScreenUtil().setWidth(8)),
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