/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/components/bean/dialog_gravity.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_module/components/expansion_tile.dart';
import 'package:flutter_module/components/loading.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/components/student_semester.dart';
import 'package:flutter_module/entity/student_evaluation_stages.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class Item {
  Item({
     this.expandedValue,
     this.headerValue,
     this.isExpanded = false,
   });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class EvaluationReportPage extends StatefulWidget {
  final String schoolId;
  final String studentId;
  EvaluationReportPage({Key key, @required this.schoolId, @required this.studentId}):super(key:key);

  @override
  EvaluationReportPageState createState() => EvaluationReportPageState(this.schoolId, this.studentId);
}

class EvaluationReportPageState extends State<EvaluationReportPage> {
  EvaluationReportPageState(this.schoolId, this.studentId);
  final String schoolId;
  final String studentId;
  StudentEvaluationStages studentEvaluationStages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mainModel.schoolId = int.parse(this.schoolId);
    mainModel.studentId = int.parse(this.studentId);
    initializeRequest();
  }

  //  请求学期以及学生评估数据
  initializeRequest () async {

    //  请求学生课程
    await mainModel.getSemester();

    await mainModel.getStages();
  }

  //  返回学生档案
  void toArchive() {}

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    TextStyle fontTitle = TextStyle(fontSize: ScreenUtil().setSp(40), color: Colors.white);
    TextStyle nameFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(32));
    studentEvaluationStages = mainModel.studentEvaluationStages;

    YYDialog.init(context);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  child: Icon(
                    Icons.keyboard_arrow_left, color: Colors.white,
                  ),
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(220)),
                ),
                onTap: () => toArchive(),
              ),
              Text(mainModel.currentSemester?.name ?? '', style: fontTitle),
              Container(
                child: Image.asset('lib/assets/icon_updown.png',
                  width: ScreenUtil().setWidth(16),
                  height: ScreenUtil().setWidth(32),
                  fit: BoxFit.contain,
                ),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(26)),
              )
            ],
          ),
          onTap: () {
            YYAlertDialogWithGravity(
              gravity: Gravity.top,
              width: MediaQuery.of(context).size.width,
            );
          },
        ),
        backgroundColor: Color(0xff29D9D6),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xff29D9D6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(686),
                  height: ScreenUtil().setWidth(192),
                  child: studentEvaluationStages == null ? Container() : Row(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: ScreenUtil().setWidth(144),
                              height: ScreenUtil().setWidth(144),
                              decoration: BoxDecoration(
                                color: Color(0xffBEF3F2),
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(72)))
                              ),
                            ),
                            Positioned(
                              top: ScreenUtil().setWidth(8),
                              left: ScreenUtil().setWidth(8),
                              child: Container(
                                width: ScreenUtil().setWidth(128),
                                height: ScreenUtil().setWidth(128),
                                decoration: BoxDecoration(
                                    image: studentEvaluationStages.results.isNotEmpty ? DecorationImage(
                                        image: NetworkImage(studentEvaluationStages.results[0].studentLogo),
                                        fit: BoxFit.contain
                                    ) : null,
                                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(64)))
                                ),
                              ),
                            ),
                            Positioned(
                              top: ScreenUtil().setWidth(0.0),
                              right: ScreenUtil().setWidth(-3.0),
                              width: ScreenUtil().setWidth(52),
                              height: ScreenUtil().setWidth(52),
                                child: Image.asset('lib/assets/icon_sex_girl.png')
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: ScreenUtil().setWidth(32)),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(studentEvaluationStages.results.isNotEmpty ? studentEvaluationStages.results[0].studentName : '', style: TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(40)),),
                            Container(
                              child: Text(studentEvaluationStages.results.isNotEmpty ? studentEvaluationStages.results[0].studentId.toString() : '深圳小学 | 01133973', style: TextStyle(color: Color(0xffB6BCC9), fontSize: ScreenUtil().setSp(28)),),
                              margin: EdgeInsets.only(top: ScreenUtil().setWidth(8)),
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(left: ScreenUtil().setWidth(28)),
                      )
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
                  height: 1.0,
                  color: Color(0xffF0F1F4),
                ),

                //  报告
                Container(
                  width: ScreenUtil().setWidth(686),
                  height: ScreenUtil().setHeight(1136),
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(32)),
                  child: ExpansionTileSample(),
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
          Loading()
        ],
      ),
    );
  }

  //  弹框
  YYDialog YYAlertDialogWithGravity({width, gravity, doubleButtonGravity}) {
    return YYDialog().build()
      ..gravity = gravity
      ..gravityAnimationEnable = true
      ..borderRadius = 8.0
      ..widget(
          StudentSemester()
      )
      ..show();
  }

}