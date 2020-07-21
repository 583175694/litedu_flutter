/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2020-06-08
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/bar_chart.dart';
import 'package:flutter_module/components/line_chart.dart';
import 'package:flutter_module/components/loading.dart';
import 'package:flutter_module/components/screen_fit.dart';

class EvaluationPage extends StatefulWidget {
  @override
  EvaluationPageState createState() => EvaluationPageState();
}

class EvaluationPageState extends State<EvaluationPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    return Scaffold(
      backgroundColor: Color(0xffF0F1F4),
      appBar: AppBar(
        title: Text('学生评估', style: TextStyle(fontSize: ScreenUtil().setSp(40), color: Color(0xff6D7993))),
        elevation: 0.4,
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              //  学生分数
              Container(
                height: ScreenUtil().setWidth(664),
                child: Stack(
                  children: <Widget>[
                    title('七边形分数'),
                    subtitle('本学期累积平均分'),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      child: BarChart(),
                      top: ScreenUtil().setWidth(110),
                    ),
                  ],
                ),
                color: Colors.white,
              ),
              //  趋势
              Container(
                height: ScreenUtil().setWidth(600),
                child: Stack(
                  children: <Widget>[
                    title('data4'),
                    subtitle('本学期data4变化趋势'),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      child: LineChart(),
                      top: ScreenUtil().setWidth(116),
                    ),
                  ],
                ),
                color: Colors.white,
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              ),
            ],
          ),
          Loading()
        ],
      ),
    );
  }

  Widget title(String arg) {
    return Positioned(
      top: ScreenUtil().setWidth(20.0),
      left: ScreenUtil().setWidth(48.0),
      child: Text(arg, style: TextStyle(fontSize: ScreenUtil().setSp(28.0), color: Color(0xff6D7993)))
    );
  }

  Widget subtitle(String arg) {
    return Positioned(
      bottom: ScreenUtil().setWidth(56.0),
      right: ScreenUtil().setWidth(64.0),
      child: Text(arg, style: TextStyle(fontSize: ScreenUtil().setSp(22.0), color: Color(0xffB6BCC9)))
    );
  }
}