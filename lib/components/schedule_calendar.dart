/**
 * @ClassName 课程表组件
 * @Author wushaohang
 * @Date 2020-6-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/school_course_schedules.dart';
import 'package:flutter_module/main.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/plugins/common.dart';
import 'package:scoped_model/scoped_model.dart';

class ScheduleCalendar extends StatefulWidget {
  ScheduleCalendar({Key key, this.selectText}) : super(key: key);
  final ValueNotifier<String> selectText;

  @override
  ScheduleCalendarState createState() => ScheduleCalendarState();
}

class ScheduleCalendarState extends State<ScheduleCalendar> {
  TextStyle courseFont = TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993), fontWeight: FontWeight.normal, decoration: TextDecoration.none);
  TextStyle evaluateFont = TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff29D9D6), fontWeight: FontWeight.normal, decoration: TextDecoration.none);
  TextStyle timeFont = TextStyle(fontSize: ScreenUtil().setSp(22), color: Color(0xffB6BCC9));
  TextStyle selectFont = TextStyle(color: Color(0xff29D9D6), fontSize: ScreenUtil().setSp(32));

  Map prov = new Map();
  Map next = new Map();

  // 数据源
//  List<String> titleItems = <String>[null, '英语课', '语文课', '化学课', '物理课', null, null, '数学课', '英语课', '语文课', '化学课'];  // 数据源
  List titleItems = new List(11);

  List colorItems = [
    {"background": Color(0xffD0EDFF), "circle": Color(0xff14A4FF)},
    {"background": Color(0xffD4F7F7), "circle": Color(0xff29D9D6)},
    {"background": Color(0xffFFEED7), "circle": Color(0xffFFA938)},
    {"background": Color(0xffFEDCDB), "circle": Color(0xffFC4F4D)},
    {"background": Color(0xffD0EDFF), "circle": Color(0xff14A4FF)},
    {"background": Color(0xffF0F2F4), "circle": Color(0xffB6BCC9)},
    {"background": Color(0xffF0F2F4), "circle": Color(0xffB6BCC9)},
    {"background": Color(0xffD4F7F7), "circle": Color(0xff29D9D6)},
    {"background": Color(0xffFFEED7), "circle": Color(0xffFFA938)},
    {"background": Color(0xffFEDCDB), "circle": Color(0xffFC4F4D)},
    {"background": Color(0xffD0EDFF), "circle": Color(0xff14A4FF)},
  ];

  List timeItems = [
    {"class": "早读", "time": "07:00", "interval": "07:00 - 08:00", "endTime": "08:00"},
    {"class": "第1节课", "time": "08:00", "interval": "08:00 - 09:00", "endTime": "09:00"},
    {"class": "第2节课", "time": "09:00", "interval": "09:00 - 10:00", "endTime": "10:00"},
    {"class": "第3节课", "time": "10:00", "interval": "10:00 - 11:00", "endTime": "11:00"},
    {"class": "第4节课", "time": "11:00", "interval": "11:00 - 12:00", "endTime": "12:00"},
    {"class": "午休时间", "time": "12:00", "interval": "12:00 - 13:00", "endTime": "13:00"},
    {"class": "午休时间", "time": "13:00", "interval": "13:00 - 14:00", "endTime": "14:00"},
    {"class": "第5节课", "time": "14:00", "interval": "14:00 - 15:00", "endTime": "15:00"},
    {"class": "第6节课", "time": "15:00", "interval": "15:00 - 16:00", "endTime": "16:00"},
    {"class": "第7节课", "time": "16:00", "interval": "16:00 - 17:00", "endTime": "17:00"},
    {"class": "第8节课", "time": "17:00", "interval": "17:00 - 18:00", "endTime": "18:00"},
  ];

  Common common = new Common();

  int willAcceptIndex;

  bool accepted = false;

  //  判断午休时间
  bool isLunchBreak(int i) {
    return i < 5 || i > 6 ? false : true;
  }

  //  跳转到课程教案
  void toCourseDetail(titleItem) { 
    FlutterBoost.singleton.channel.invokeMethod('calendarPage/routeCoursePlan', {'courseSchedule': titleItem});
  }

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);
    DateModel date = mainModel.currentDateModel;
    if (mainModel.currentCourse != null) {
      titleItems = mainModel.currentCourse;
    }
    setState(() {});

    //  日程列表
    List<Widget> scheduleList() {
      List<Widget> tiles = [];

      //  选中课程
      mainModel.isEdit ? tiles.add(
          Container(
            height: ScreenUtil().setWidth(112),
            color: Color.fromRGBO(41, 217, 214, 0.2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('调课：', style: selectFont),
                Text('${date.year}年${date.month}月${date.day}日 ', style: selectFont),
                Text('数学课', style: selectFont)
              ],
            ),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(48)),
          )
      ) : null;

      //  日期标题
      tiles.add(
        Container(
          height: ScreenUtil().setHeight(60),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('${date.year}年${date.month}月${date.day}日', style: TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(44)))
            ],
          ),
          margin: EdgeInsets.only(left: 15.0),
        )
      );

      for (int i = 0; i < titleItems.length; i++) {

        //  可拖动列表
        if (!isLunchBreak(i) && titleItems[i] != null) {
          tiles.add(
            GestureDetector(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(124),
                      child: Column(
                        children: <Widget>[
                          Text(timeItems[i]["class"], style: timeFont),
                          Text(timeItems[i]["time"], style: timeFont)
                        ],
                      ),
                    ),
                    courseItem(i),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              onTap: () => toCourseDetail(titleItems[i]),
            )
          );
        } else {
          //  午休时间
          tiles.add(
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(124),
                      child: Column(
                        children: <Widget>[
                          Text(timeItems[i]["class"], style: timeFont),
                          Text(timeItems[i]["time"], style: timeFont)
                        ],
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(626),
                      height: ScreenUtil().setWidth(138),
                      padding: EdgeInsets.only(top: i == 5 ? 20 : 0),
                      margin: EdgeInsets.only(top: i == 5 ? 6 : 0, bottom: i == 6 ? 6 : 0),
                      child: i == 6 ? Container() : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(timeItems[i]["class"], style: courseFont),
                                margin: EdgeInsets.only(left: 12, right: 6),
                              ),
                              Text("无课程", style: courseFont),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    color: Color(0xffB6BCC9)
                                ),
                                margin: EdgeInsets.only(left: 12, right: 6),
                              ),
                              Text(timeItems[i]["interval"], style: courseFont),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xffF0F2F4),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(i == 6 ? 0 : 10), bottomLeft: Radius.circular(i == 5 ? 0 :10))
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              )
          );
        }
      }

      //  底部留白
      tiles.add(Container(
        color: Colors.white,
      ));

      return tiles;
    }
    
    return SliverFixedExtentList(
      itemExtent: ScreenUtil().setWidth(144),
      delegate: SliverChildListDelegate(
          scheduleList()
      ),
    );
  }

  //  课程项
  Widget courseItem(int i) {
    return Container(
      width: ScreenUtil().setWidth(626),
      height: ScreenUtil().setWidth(128),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Text(timeItems[i]["class"], style: courseFont),
                    margin: EdgeInsets.only(left: 12, right: 6),
                  ),
                  Container(
                      width: ScreenUtil().setWidth(320),
                      child: Text(titleItems[i] == null ? '' : "-  ${titleItems[i]['name']}", style: courseFont, softWrap: false, overflow: TextOverflow.ellipsis,)
                  ),
                ],
              ),
              i == 5 ? Container() : GestureDetector(
                child: Container(
                  width: ScreenUtil().setWidth(128),
                  height: ScreenUtil().setWidth(56),
                  alignment: Alignment.centerRight,
                  child: Center(
                    child: Text('评估', style: evaluateFont),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      color: Colors.white
                  ),
                  margin: EdgeInsets.only(right: 8),
                ),
                onTap: () => toEvaluation(titleItems[i]["id"], titleItems[i]['name']),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: colorItems[i]["circle"]
                ),
                margin: EdgeInsets.only(left: 12, right: 6),
              ),
              Text(timeItems[i]["interval"], style: courseFont,),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: colorItems[i]["background"],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(i == 6 ? 0 : 10), bottomLeft: Radius.circular(i == 5 ? 0 :10))
      ),
    );
  }

  //  跳转到评价列表
  void toEvaluation(int id, String name) async {
    await mainModel.getStudentEvaluation(id);
    Navigator.pushNamed(context, "assessment_page", arguments: name);
  }
}