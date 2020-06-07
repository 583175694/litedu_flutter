/**
 * @ClassName 学生数据
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';

class StudentData extends StatefulWidget {
  @override
  StudentDataState createState() => StudentDataState();
}

class StudentDataState extends State<StudentData> {
  TextStyle fontTitle = TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993));
  TextStyle fontValue = TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff29D9D6));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setWidth(348),
      child: Stack(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(348),
            height: ScreenUtil().setWidth(348),
            child: Image.asset('lib/assets/img_litedu.png'),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(202)),
          ),
          Positioned(
            top: 0,
            left: ScreenUtil().setWidth(502),
            child: RichText(
              text: TextSpan(
                text: '身高：',
                style: fontTitle,
                children: <TextSpan>[
                  TextSpan(text: '120cm', style: fontValue),
                ],
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setWidth(142),
            left: ScreenUtil().setWidth(36),
            child: RichText(
              text: TextSpan(
                text: '体重：',
                style: fontTitle,
                children: <TextSpan>[
                  TextSpan(text: '75kg', style: fontValue),
                ],
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setWidth(314),
            left: ScreenUtil().setWidth(496),
            child: RichText(
              text: TextSpan(
                text: '脚掌：',
                style: fontTitle,
                children: <TextSpan>[
                  TextSpan(text: '32cm', style: fontValue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}