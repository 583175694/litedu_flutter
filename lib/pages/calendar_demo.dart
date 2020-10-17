import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/components/calendar_month.dart';
import 'package:flutter_module/components/calendar_week.dart';
import 'package:flutter_module/components/custom_style.dart';
import 'package:flutter_module/components/schedule_calendar_demo.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/plugins/calendar_plugin/constants/constants.dart';
import 'package:flutter_module/plugins/calendar_plugin/controller.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/calendar_view.dart';
import 'package:flutter_module/plugins/panel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../main.dart';

class CalendarDemo extends StatefulWidget {
  CalendarDemo({Key key}) : super(key: key);

  @override
  _CalendarDemoState createState() => _CalendarDemoState();
}

class _CalendarDemoState extends State<CalendarDemo> with TickerProviderStateMixin{
  bool showCollapsed = false; //是否显示折叠时的内容
  double maxHeight = 368; //最大展开高度
  double minHeight = 152; //最小收缩高度
  bool showBorder = false; //是否显示边框
  bool borderRadius = true; //启用圆角
  bool backdropEnabled = false; //启用背景半透明化
  bool parallaxEnabled = false; //开启视差滚动
  double parallaxOffset = 0.1; //时差滚动阀值 0.0-1.0
  bool slideDirectionReverse = true; //拖动方向
  //  日历控制
  CalendarController _calendarController;
  //  切换周、月视图
  String currentView = 'week';
  //  初始日期
  ValueNotifier<String> text;
  //  选择日期
  ValueNotifier<String> selectText;
  //  编辑状态
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _calendarController = new CalendarController(
        minYear: now.year - 1,
        minYearMonth: 1,
        maxYear: now.year + 1,
        maxYearMonth: 12,
        showMode: CalendarConstants.MODE_SHOW_ONLY_WEEK);

    _calendarController.addMonthChangeListener((year, month) {
      text.value = "$year年$month月";
    });

    _calendarController.addOnCalendarSelectListener((dateModel) {
      //刷新选择的时间
      selectText.value = "${dateModel.year}年${dateModel.month}月${dateModel.day}日";
      setState(() { });
    });

    text = new ValueNotifier("${DateTime.now().year}年${DateTime.now().month}月");
    selectText = new ValueNotifier("${now.year}年 ${now.month}月${now.day}日");

    //  请求班级
    mainModel.getClassTeam().then((res) {
      //  初始化请求
      mainModel.initializeRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
		ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
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
                currentView = 'month';
                isEdit = !isEdit;
                mainModel.isEdit = isEdit;
                setState(() { });
              },
            ),
            Text('课程安排', style: TextStyle(color: Color(0xff6D7993), fontSize: 20),),
            Container()
          ],
        ),
        backgroundColor: Colors.white,
        elevation: mainModel.isEdit ? 0.3 : 0.0,
      ),
      body: !mainModel.isEdit ? SlidingUpPanel(
          collapsed: Container(
            child: CalendarWeek(),
          ),
          panel: Container(
            child: Stack(
              children: <Widget>[
                CalendarMonth(),
                Positioned(
                  bottom: 10,
                  left: 163,
                  child: Container(
                    width: 49,
                    height: 6,
                    decoration: BoxDecoration(
                        color: Color(0xffD3D6DE),
                        borderRadius: BorderRadius.all(Radius.circular(3.0))
                    ),
                  ),
                )
              ],
            )
          ),
          body: Stack(
            children: <Widget>[
              Positioned(
                top: 144,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 220,
                  child: ScheduleCalendarDemo(selectText: selectText),
                ),
              )
            ],
          ),
          maxHeight: maxHeight, //  maxHeight
          minHeight: minHeight,
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
          slideDirection: slideDirectionReverse ? SlideDirection.DOWN : SlideDirection.UP) : ScheduleList(selectText: selectText),
    );
  }


	//  月历
	Widget calendarContent() {
		return new Container(
			child: new Stack(
				children: <Widget>[
					CalendarViewWidget(
						weekBarItemWidgetBuilder: () {
							return CustomStyleWeekBarItem(text: text);
						},
						dayWidgetBuilder: (dateModel) {
							return CustomStyleDayWidget(dateModel);
						},
						calendarController: _calendarController,
						boxDecoration: BoxDecoration(
							borderRadius: BorderRadius.only(
									bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
							color: Colors.white,
						),
						verticalSpacing: 0,
						padding: EdgeInsets.only(bottom: 16),
					),
					Positioned(
						bottom: 10,
						left: 163,
						child: Container(
							width: 49,
							height: 6,
							decoration: BoxDecoration(
									color: Color(0xffD3D6DE),
									borderRadius: BorderRadius.all(Radius.circular(3.0))
							),
						),
					)
				],
			),
			decoration: BoxDecoration(
					borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
					boxShadow: [
						BoxShadow(
							color: Color.fromRGBO(0, 0, 0, 0.15),
							blurRadius: 20.0,
							offset: Offset(0.0, 0.0),
						),
					]
			),
		);
	}
}
