library calendar_list;

import 'package:flutter/material.dart';

import 'month_view.dart';
import 'weekday_row.dart';

class CalendarList extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedStartDate;
  final DateTime selectedEndDate;
  final Function onSelectFinish;
  final Function onSelect;

  CalendarList(
      {@required this.firstDate,
      @required this.lastDate,
      this.onSelectFinish,
      this.selectedStartDate,
      this.selectedEndDate,
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
  DateTime selectStartTime;
  DateTime selectEndTime;
  int yearStart;
  int monthStart;
  int yearEnd;
  int monthEnd;
  int count;

  @override
  void initState() {
    super.initState();
    // 传入的开始日期
    selectStartTime = widget.selectedStartDate;
    // 传入的结束日期
    selectEndTime = widget.selectedEndDate;
    yearStart = widget.firstDate.year;
    monthStart = widget.firstDate.month;
    yearEnd = widget.lastDate.year;
    monthEnd = widget.lastDate.month;
    count = monthEnd - monthStart + (yearEnd - yearStart) * 12 + 1;
  }

  // 选项处理回调
  void onSelectDayChanged(dateTime) {
    if (selectStartTime == null && selectEndTime == null) {
      selectStartTime = dateTime;
    } else if (selectStartTime != null && selectEndTime == null) {
      selectEndTime = dateTime;
      // 如果选择的开始日期和结束日期相等，则清除选项
      if (selectStartTime == selectEndTime) {
        setState(() {
          selectStartTime = null;
          selectEndTime = null;
        });
        return;
      }
      // 如果用户反选，则交换开始和结束日期
      if (selectStartTime?.isAfter(selectEndTime)) {
        DateTime temp = selectStartTime;
        selectStartTime = selectEndTime;
        selectEndTime = temp;
      }
    } else if (selectStartTime != null && selectEndTime != null) {
      selectStartTime = null;
      selectEndTime = null;
      selectStartTime = dateTime;
    }
    setState(() {
      selectStartTime;
      selectEndTime;
    });
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
              height: 55.0,
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
              margin: EdgeInsets.only(top: 55.0),
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
            ),
          ],
        ),
      ),
    );
  }

  void _finishSelect() {
    if (selectStartTime != null) {
      widget.onSelectFinish(selectStartTime, selectEndTime);
    }
  }

  void _onSelect() {
    if (selectStartTime != null) {
      widget.onSelect();
    }
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
      dateTimeEnd: selectEndTime,
      todayColor: Colors.deepOrange,
      onSelectDayRang: (dateTime) => onSelectDayChanged(dateTime),
    );
  }
}
