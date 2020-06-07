/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/line_chart.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/components/student_assessment.dart';
import 'package:flutter_module/components/student_attendance.dart';
import 'package:flutter_module/components/student_data.dart';
import 'package:flutter_module/components/student_portraits.dart';
import 'package:flutter_module/components/student_score.dart';
import 'package:flutter_module/plugins/custom_underline_tab_indicator.dart';

class StudentFile extends StatefulWidget {
  @override
  StudentFileState createState() => StudentFileState();
}

class StudentFileState extends State<StudentFile> {
  List tabs = [
    {"title": "成长档案", "icon": ""},
    {"title": "精彩瞬间", "icon": ""},
    {"title": "亲子时光", "icon": ""}
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);
    TextStyle fontTitle = TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              for (var item in tabs) Container(
                width: ScreenUtil().setWidth(112),
                height: ScreenUtil().setWidth(114),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.directions_car, color: Color(0xffA8F2EC)),
                      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(22)),
                    ),
                    Text(item["title"], style: fontTitle, softWrap: false)
                  ],
                ),
              )
            ],
            indicatorColor: Color(0xff29D9D6),
            indicatorSize: TabBarIndicatorSize.label,
            indicator: CustomUnderlineTabIndicator(
              borderSide: BorderSide(width: ScreenUtil().setWidth(8), color: Color(0xff29D9D6))),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  //  分割线
                  line(),
                  //  学生数据
                  Container(
                    height: ScreenUtil().setWidth(560),
                    child: Stack(
                      children: <Widget>[
                        title('学生数据'),
                        Positioned(
                          child: StudentData(),
                          top: ScreenUtil().setWidth(152),
                        ),
                      ],
                    ),
                  ),
                  //  分割线
                  line(),
                  //  学生评估
                  Container(
                    height: ScreenUtil().setWidth(662),
                    child: Stack(
                      children: <Widget>[
                        title('学生评估'),
                        Positioned(
                          child: StudentAssessment(),
                          top: ScreenUtil().setWidth(108),
                          left: ScreenUtil().setWidth(286),
                        ),
                        Positioned(
                          child: Text('- 最新评估 -', style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Color(0xffB6BCC9))),
                          bottom: ScreenUtil().setWidth(44),
                          left: ScreenUtil().setWidth(314),
                        )
                      ],
                    ),
                  ),
                  //  分割线
                  line(),
                  //  学生画像
                  Container(
                    height: ScreenUtil().setWidth(662),
                    child: Stack(
                      children: <Widget>[
                        title('学生画像'),
                        Container(
                          child: StudentPortraits(),
                          margin: EdgeInsets.only(top: ScreenUtil().setWidth(126)),
                        ),
                      ],
                    ),
                  ),
                  //  分割线
                  line(),
                  //  学生考勤
                  Container(
                    height: ScreenUtil().setWidth(496),
                    child: Stack(
                      children: <Widget>[
                        title('考勤统计'),
                        Container(
                          child: StudentAttendance(),
                          margin: EdgeInsets.only(top: ScreenUtil().setWidth(118)),
                        ),
                      ],
                    ),
                  ),
                  //  分割线
                  line(),
                  //  学生分数
                  StudentScore(),
                  //  趋势
                  LineChart()
                ],
              ),
            ),
            Container(),
            Container()
          ],
        ),
      ),
    );
  }

  Container line() {
    return Container(
        height: ScreenUtil().setHeight(20),
        color: Color(0xffF0F1F4)
    );
  }

  Widget title(String arg) {
    return Positioned(
      top: ScreenUtil().setWidth(46.0),
      left: ScreenUtil().setWidth(48.0),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(8.0),
            height: ScreenUtil().setWidth(24.0),
            decoration: BoxDecoration(
              color: Color(0xffFFA938),
              borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(16.0)),
          ),
          Text(arg, style: TextStyle(fontSize: ScreenUtil().setSp(32.0), color: Color(0xff6D7993)))
        ],
      ),
    );
  }
}