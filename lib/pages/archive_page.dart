/**
 * @ClassName 学生档案
 * @Author wushaohang
 * @Date 2020-06-04
 **/
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/components/loading.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/components/student_assessment.dart';
import 'package:flutter_module/components/student_attendance.dart';
import 'package:flutter_module/components/student_data.dart';
import 'package:flutter_module/components/student_portraits.dart';
import 'package:flutter_module/entity/student_archive.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class ArchivePage extends StatefulWidget {
  @override
  ArchivePageState createState() => ArchivePageState();
}

class ArchivePageState extends State<ArchivePage> {
  String studentId;
  String strDate;
  String endDate;

  //  学生档案
  StudentArchive studentArchive;
  //  基本信息
  Basics basics;
  //  学生画像
  Six_skills sixSkills;
  //  七边形图
  Qi_skills qiSkills;
  //  考勤
  Attendances attendances;

  @override
  void initState() {
    super.initState();

    FlutterBoost.singleton.channel.addMethodHandler((handler) async {
      var method = handler.method;

      if (method == 'archivePage/reloadData') {
        var studentId = handler.arguments['studentId'];
        var strDate = handler.arguments['strDate'];
        var endDate = handler.arguments['endDate'];
        //  请求学生档案
        await mainModel.getStudentArchive(studentId, strDate, endDate);
        //  请求七边形
        await mainModel.getQis(studentId, strDate, endDate);
        //  请求七边形趋势
        await mainModel.getQisTrends(studentId);

        mainModel.studentId = studentId;
        mainModel.currentSemester
          ..strDate = strDate
          ..endDate = endDate;
      }
      return Future.value('done');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

//    print('qiAbility1: ${mainModel.studentArchive.qiSkills.qiAbility1}');
  }

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    studentArchive = mainModel.studentArchive;
    setState(() {});

    return Scaffold(
      body: Stack(
        children: <Widget>[
          NotificationListener<ScrollNotification>(
            onNotification: (Notification scrollNotification) {
              if (scrollNotification is ScrollStartNotification) {
                FlutterBoost.singleton.channel.invokeMethod('archivePage/onScrollStart');
              } else if (scrollNotification is ScrollEndNotification) {
                FlutterBoost.singleton.channel.invokeMethod('archivePage/onScrollEnd');
              }
              return true;
            },
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                //  学生数据
                GestureDetector(
                  child: Container(
                    height: ScreenUtil().setWidth(560),
                    child: Stack(
                      children: <Widget>[
                        title('成长印记'),
                        Positioned(
                          child: StudentData(),
                          top: ScreenUtil().setWidth(152),
                        ),
                      ],
                    ),
                    color: Colors.white,
                  ),
                  onTap: () {
                    FlutterBoost.singleton.channel.invokeMethod('archivePage/routeStudentData');
                  },
                ),
                //  学生评估
                GestureDetector(
                  child: Container(
                    height: ScreenUtil().setWidth(662),
                    child: Stack(
                      children: <Widget>[
                        title('七大关键能力'),
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
                    color: Colors.white,
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                  ),
                  onTap: () {
                    //  请求七边形趋势
                    FlutterBoost.singleton.channel.invokeMethod('archivePage/routeEvaluation');
//                     Navigator.pushNamed(context, 'evaluation_page');
                  },
                ),
                //  学生画像
                GestureDetector(
                  child: Container(
                    height: ScreenUtil().setWidth(762),
                    child: Stack(
                      children: <Widget>[
                        title('六大领域'),
                        Container(
                          child: StudentPortraits(origin: 'archive'),
                          margin: EdgeInsets.only(top: ScreenUtil().setWidth(126)),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                  ),
                  onTap: () {
                    FlutterBoost.singleton.channel.invokeMethod('archivePage/routeEvaluationReport');
                  },
                ),
                //  学生考勤
                GestureDetector(
                  child: Container(
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
                    color: Colors.white,
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                  ),
                  onTap: () {
                    FlutterBoost.singleton.channel.invokeMethod('archivePage/routeAttendanceData');
                  },
                ),
                //  注意事项
                GestureDetector(
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        title('注意事项'),
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(56), top: ScreenUtil().setWidth(64)),
                            width: ScreenUtil().setWidth(622),
                            child: Text(studentArchive == null ? '' : studentArchive?.basics?.attentionMatters, style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Color(0xffB6BCC9))),
                            margin: EdgeInsets.only(top: ScreenUtil().setWidth(66)),
                          ),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(20), bottom: ScreenUtil().setHeight(180)),
                  ),
                  onTap: () {
                    FlutterBoost.singleton.channel.invokeMethod('archivePage/routeStudentAttentions');
                  },
                ),
              ],
            ),
          ),
          Loading()
        ],
      ),
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