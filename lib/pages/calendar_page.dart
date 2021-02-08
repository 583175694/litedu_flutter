import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/components/calendar_month.dart';
import 'package:flutter_module/components/calendar_week.dart';
import 'package:flutter_module/components/schedule_calendar.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/controller.dart';
import 'package:flutter_module/plugins/panel.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with TickerProviderStateMixin{
  bool showCollapsed = false; //是否显示折叠时的内容
  bool showBorder = false; //是否显示边框
  bool borderRadius = true; //启用圆角
  bool backdropEnabled = false; //启用背景半透明化
  bool parallaxEnabled = false; //开启视差滚动
  double parallaxOffset = 0.1; //时差滚动阀值 0.0-1.0
  bool slideDirectionReverse = true; //拖动方向
  ValueNotifier<String> selectText; //  选择日期
  CalendarController _calendarController = new CalendarController();

  @override
  void initState() {
    super.initState();
    //  请求班级
    mainModel.getClassTeam().then((res) {
      //  初始化请求
      mainModel.initializeRequest();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);
		ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
			..init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: ScreenUtil().setWidth(64),
                height: ScreenUtil().setWidth(48),
                child: mainModel.isEdit ? Text('取消', style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993))) : Image.asset('lib/assets/icon_list.png', width: ScreenUtil().setWidth(48),),
              ),
              onTap: () {
                mainModel.isEdit = !mainModel.isEdit;
                setState(() { });
              },
            ),
            Text('课程安排', style: TextStyle(color: Color(0xff6D7993), fontSize: 20),),
            Container(
              width: ScreenUtil().setWidth(64),
              height: ScreenUtil().setWidth(48),
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: mainModel.isEdit ? 0.3 : 0.0,
      ),
      body: !mainModel.isEdit ?

      //  日历状态
      SlidingUpPanel(
          collapsed: Container(
            child: CalendarWeek(),
          ),
          panel: Container(
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 4,
                      height: 28,
                      decoration: BoxDecoration(
                          color: Color(0xff29D9D6),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(77.0), bottomRight: Radius.circular(77.0))
                      ),
                      margin: EdgeInsets.only(right: 16.0),
                    ),
                    Text('${mainModel.currentMonth.year}年${mainModel.currentMonth.month}月', style: TextStyle(fontSize: ScreenUtil().setWidth(28), color: Color(0xff6D7993)),),
                  ],
                ),
                Positioned(
                  top: 30,
                  child: CalendarMonth(),
                ),
                Positioned(
                  bottom: 10,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Container(
                      width: 49,
                      height: 6,
                      decoration: BoxDecoration(
                          color: Color(0xffD3D6DE),
                          borderRadius: BorderRadius.all(Radius.circular(3.0))
                      ),
                    ),
                  )
                )
              ],
            )
          ),
          body: Stack(
            children: <Widget>[
              Positioned(
                top: 106,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(184)),
                  child: ScheduleCalendar(selectText: selectText),
                ),
              )
            ],
          ),
          maxHeight: ScreenUtil().setWidth(820),
          minHeight: ScreenUtil().setWidth(206),
          border: showBorder
              ? Border(
                  top: BorderSide(
                  color: Colors.blue,
                ))
              : null,
          borderRadius: borderRadius
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                )
              : null,
          backdropEnabled: backdropEnabled,
          parallaxEnabled: parallaxEnabled,
          parallaxOffset: parallaxOffset,
          slideDirection: slideDirectionReverse ? SlideDirection.DOWN : SlideDirection.UP,
          onPanelOpened: () {
            mainModel.currentView = 'month';
          },
          onPanelClosed: () {
            mainModel.currentView = 'week';
          },
      ) :

      //  编辑状态
      ScheduleList(selectText: selectText),
    );
  }
}
