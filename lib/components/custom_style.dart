/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/plugins/calendar_plugin/constants/constants.dart';
import 'package:flutter_module/plugins/calendar_plugin/controller.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/base_day_view.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/base_week_bar.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/calendar_view.dart';

class CalendarContent extends StatefulWidget {
  @override
  CalendarContentState createState() => CalendarContentState();
}

class CalendarContentState extends State<CalendarContent> {
  bool floating = false;
  bool pinned = true;
  CalendarController _calendarController;
  String currentView = 'month';   //  切换周、月视图

  ValueNotifier<String> text;
  ValueNotifier<String> selectText;

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
    },
    );

    _calendarController.addOnCalendarSelectListener((dateModel) {
      //刷新选择的时间
      selectText.value = "单选模式，选中的时间: ${_calendarController.getSingleSelectCalendar()}";
    });

    text = new ValueNotifier("${DateTime.now().year}年${DateTime.now().month}月");

    selectText = new ValueNotifier("单选模式\n选中的时间:\n${_calendarController.getSingleSelectCalendar()}");
  }
  
  Widget calendarContent() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                  icon: Icon(Icons.navigate_before),
                  onPressed: () {
                    _calendarController.moveToPreviousMonth();
                    _calendarController.previousPage();
                  }),
              ValueListenableBuilder(
                  valueListenable: text,
                  builder: (context, value, child) {
                    return new Text(text.value);
                  }),
              new IconButton(
                  icon: Icon(Icons.navigate_next),
                  onPressed: () {
                    _calendarController.nextPage();
                  }),
            ],
          ),
          CalendarViewWidget(
            weekBarItemWidgetBuilder: () {
              return CustomStyleWeekBarItem();
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
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return calendarContent();
  }
}

class CustomStyleWeekBarItem extends BaseWeekBar {
  final List<String> weekList = ["一", "二", "三", "四", "五", "六", "日"];

  //可以直接重写build方法
  @override
  Widget build(BuildContext context) {
    List<Widget> children = List();

    var items = getWeekDayWidget();
    children.add(Row(
      children: items,
    ));
    return Column(
      children: children,
    );
  }

  @override
  Widget getWeekBarItem(int index) {
    return new Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: new Center(
        child: new Text(
          weekList[index],
          style:
          TextStyle(fontWeight: FontWeight.w700, color: Color(0xffC5BCDC)),
        ),
      ),
    );
  }
}

class CustomStyleDayWidget extends BaseCombineDayWidget {
  CustomStyleDayWidget(DateModel dateModel) : super(dateModel);

  final TextStyle normalTextStyle = TextStyle(fontWeight: FontWeight.w700, color: Colors.black);

  final TextStyle noIsCurrentMonthTextStyle = TextStyle(fontWeight: FontWeight.w700, color: Colors.grey);

  @override
  Widget getNormalWidget(DateModel dateModel) {
    return Container(
      margin: EdgeInsets.all(8),
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //公历
              new Expanded(
                child: Center(
                  child: new Text(
                    dateModel.day.toString(),
                    style: dateModel.isCurrentMonth
                        ? normalTextStyle
                        : noIsCurrentMonthTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget getSelectedWidget(DateModel dateModel) {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: Color(0xffFED32B),
      ),
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //公历
              new Expanded(
                child: Center(
                  child: new Text(
                    dateModel.day.toString(),
                    style: dateModel.isCurrentMonth
                        ? normalTextStyle
                        : noIsCurrentMonthTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
