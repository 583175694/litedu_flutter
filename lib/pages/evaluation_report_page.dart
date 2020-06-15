/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';

class EvaluationReportPage extends StatefulWidget {
  @override
  EvaluationReportPageState createState() => EvaluationReportPageState();
}

class EvaluationReportPageState extends State<EvaluationReportPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);
    TextStyle fontTitle = TextStyle(fontSize: ScreenUtil().setSp(40), color: Colors.white);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('2019下学期', style: fontTitle),
            Container(
              child: Image.asset('lib/assets/icon_updown.png',
                width: ScreenUtil().setWidth(16),
                height: ScreenUtil().setWidth(32),
                fit: BoxFit.contain,
              ),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
            )
          ],
        ),
        backgroundColor: Color(0xff29D9D6),
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xff29D9D6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(686),
              height: ScreenUtil().setHeight(192),
              child: Row(
                children: <Widget>[

                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16)
                ),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(686),
              height: 1,
              color: Color(0xffF0F1F4),
            ),
            Container(
              width: ScreenUtil().setWidth(686),
              height: ScreenUtil().setHeight(1152),
              child: ListView(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}