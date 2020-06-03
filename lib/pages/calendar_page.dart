import 'dart:math';

/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/custom_style.dart';
import 'package:flutter_module/components/date_choice_model.dart';
import 'package:flutter_module/components/grade_choice_model.dart';
import 'package:flutter_module/components/schedule_list.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/main.dart';
import 'package:flutter_module/plugins/calendar_dialog/index.dart';
import 'package:flutter_module/plugins/calendar_plugin/constants/constants.dart';
import 'package:flutter_module/plugins/calendar_plugin/controller.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/calendar_view.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  bool floating = false;
  bool pinned = true;
  //  日历控制
  CalendarController _calendarController;
  //  滚动控制
  ScrollController _scrollController;
  //  切换周、月视图
  String currentView = 'month';  
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
        showMode: CalendarConstants.MODE_SHOW_MONTH_AND_WEEK);

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

    _scrollController = new ScrollController();

    //  监听滚动距离切换周/月视图
    _scrollController.addListener(() {
      if (_scrollController.offset > 210.0) {
        if (currentView == 'month') {
          _calendarController.toggleExpandStatus();
        }
        currentView = 'week';
      } else {
        if (currentView == 'week') {
          _calendarController.toggleExpandStatus();
        }
        currentView = 'month';
      }
    });
  }

  Future<DateTime> _showDatePicker() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add( //未来30天可选
        Duration(days: 365),
      ),
    );
  }

  // Dialog方式
  _navigateDialog() {
    showDialog(context: context, builder: (context) => DateChoiceModel());
  }

  //  选择班级
  void _selectClass() {
    showDialog(context: context, builder: (context) => GradeChoiceModel());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    return Scaffold(
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
                  isEdit = !isEdit;
                  mainModel.isEdit = isEdit;
                  setState(() { });
                },
              ),
              Text('课程安排', style: TextStyle(color: Color(0xff6D7993), fontSize: 20),),
              GestureDetector(
                child: Container(
                  width: ScreenUtil().setWidth(48),
                  height: ScreenUtil().setWidth(48),
                  child: Image.asset('lib/assets/icon_setting.png'),
                ),
                onTap: () {
                  mainModel.isEdit ? _navigateDialog() : _selectClass();
                },
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: mainModel.isEdit ? 0.3 : 0.0,
        ),
        body: Stack(
          children: <Widget>[
            mainModel.isEdit ? CustomScrollView(
              slivers: <Widget>[
                ScheduleList(selectText: selectText)
              ],
            ) : CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                buildSliverAppBar(),
                ScheduleList(selectText: selectText)
              ],
            ),
          ],
        )
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      bottom: PreferredSize(
          preferredSize: Size(200, ScreenUtil().setWidth(164.0)),
          child: Container()
      ),
      backgroundColor: Colors.white,
      expandedHeight: ScreenUtil().setWidth(706.0),
      flexibleSpace: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          Positioned(
              top: 0,
              child: calendarContent()
          ),
        ],
      ),
      elevation: 0,
      pinned: pinned,
    );
  }

  //  月历
  Widget calendarContent() {
    return new Container(
      child: new Stack(
        children: <Widget>[
          CalendarViewWidget(
            weekBarItemWidgetBuilder: () {
              return CustomStyleWeekBarItem(text: text,);
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