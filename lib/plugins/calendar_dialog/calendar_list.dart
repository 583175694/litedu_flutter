library calendar_list;

import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/dto/dateDto.dart';
import 'package:flutter_module/plugins/calendar_plugin/flutter_custom_calendar.dart';

import 'month_view.dart';
import 'weekday_row.dart';

class CalendarList extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateModel selectedStartDate;
  final Function onSelectFinish;
  final Function onSelect;

  CalendarList(
      {@required this.firstDate,
      @required this.lastDate,
      this.onSelectFinish,
      this.selectedStartDate,
      this.onSelect})
      : assert(firstDate != null),
        assert(lastDate != null),
        assert(!firstDate.isAfter(lastDate),
            'lastDate must be on or after firstDate');

  @override
  _CalendarListState createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {
  final double HORIZONTAL_PADDING = 0.0;
  DateModel selectStartTime;
  int yearStart;
  int monthStart;
  int yearEnd;
  int monthEnd;
  int count;
  DateDto _dateDto = new DateDto();

  @override
  void initState() {
    super.initState();
    // 传入的开始日期
    selectStartTime = widget.selectedStartDate;
    yearStart = widget.firstDate.year;
    monthStart = widget.firstDate.month;
    yearEnd = widget.lastDate.year;
    monthEnd = widget.lastDate.month;
    count = monthEnd - monthStart + (yearEnd - yearStart) * 12 + 1;
  }

  // 选项处理回调
  void onSelectDayChanged(dateTime) {
    selectStartTime = dateTime;
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: ScreenUtil().setHeight(56.0),
              child: Container(
                padding: EdgeInsets.only(
                    left: HORIZONTAL_PADDING, right: HORIZONTAL_PADDING),
                decoration: BoxDecoration(
                  // border: Border.all(width: 3, color: Color(0xffaaaaaa)),
                  // 实现阴影效果
                  color: Colors.white,
                ),
                child: WeekdayRow(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(56.0)),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        int month = index + monthStart;
                        DateTime calendarDateTime = DateTime(yearStart, month);
                        return _getMonthView(calendarDateTime);
                      },
                      childCount: count,
                    ),
                  ),
                ],
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMonthView(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    return MonthView(
      context: context,
      year: year,
      month: month,
      padding: HORIZONTAL_PADDING,
      dateTimeStart: selectStartTime,
      todayColor: Colors.deepOrange,
      onSelectDayRang: (dateTime) => onSelectDayChanged(dateTime),
    );
  }
}
