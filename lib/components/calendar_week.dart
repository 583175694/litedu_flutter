/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/custom_style.dart';
import 'package:flutter_module/dto/dateDto.dart';
import 'package:flutter_module/main.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/constants/constants.dart';
import 'package:flutter_module/plugins/calendar_plugin/controller.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/calendar_view.dart';
import 'package:scoped_model/scoped_model.dart';

class CalendarWeek extends StatefulWidget {
  @override
  CalendarWeekState createState() => CalendarWeekState();
}

class CalendarWeekState extends State<CalendarWeek> {
  //  日历控制
  CalendarController _calendarController;
  //  滚动控制
  ScrollController _scrollController;
  //  切换周、月视图
  String currentView = 'week';
  //  初始日期
  ValueNotifier<String> text;
  //  选择日期
  ValueNotifier<String> selectText;
  //  dateDto
  DateDto dateDto = new DateDto();


  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateModel selectDateModel = dateDto.toDateModel(now);

    _calendarController = new CalendarController(
        minYear: now.year - 1,
        minYearMonth: 1,
        maxYear: now.year + 1,
        maxYearMonth: 12,
        selectDateModel: selectDateModel,
        showMode: CalendarConstants.MODE_SHOW_ONLY_WEEK);

    mainModel.weekController = _calendarController;

    _calendarController.addMonthChangeListener((year, month) {
      text.value = "$year年$month月";
      mainModel.currentMonth = DateTime(year, month);
    });

    _calendarController.addOnCalendarSelectListener((dateModel) {
      //刷新选择的时间
      selectText.value = "${dateModel.year}年${dateModel.month}月${dateModel.day}日";
      mainModel.monthController.moveToCalendar(dateModel.year, dateModel.month, dateModel.day);

      setState(() { });
    });


    text = new ValueNotifier("${DateTime.now().year}年${DateTime.now().month}月");
    selectText = new ValueNotifier("${now.year}年 ${now.month}月${now.day}日");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ),
        ],
      ),
    );
  }
}