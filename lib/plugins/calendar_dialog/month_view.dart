import 'package:flutter/material.dart';
import 'package:flutter_module/main.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/flutter_custom_calendar.dart';
import 'calendar_notification.dart';

import 'day_number.dart';
import 'month_title.dart';
import 'utils/dates.dart';
import 'utils/screen_sizes.dart';

class MonthView extends StatefulWidget {
  const MonthView({
    @required this.context,
    @required this.year,
    @required this.month,
    @required this.padding,
    @required this.dateTimeStart,
    @required this.onSelectDayRang,
    this.todayColor,
    this.monthNames,
  });

  final BuildContext context;
  final int year;
  final int month;
  final double padding;
  final Color todayColor;
  final List<String> monthNames;
  final DateModel dateTimeStart;
  final Function onSelectDayRang;

  double get itemWidth => getDayNumberSize(context, padding);

  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  DateModel selectedDate = new DateModel();

  Widget buildMonthDays(BuildContext context) {
    List<Row> dayRows = <Row>[];
    List<DayNumber> dayRowChildren = <DayNumber>[];

    int daysInMonth = getDaysInMonth(widget.year, widget.month);

    // 日 一 二 三 四 五 六
    int firstWeekdayOfMonth = DateTime(widget.year, widget.month, 2).weekday;

    for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++) {
      DateTime moment = DateTime(widget.year, widget.month, day);
      final bool isToday = dateIsToday(moment);

      dayRowChildren.add(
        DayNumber(
          size: widget.itemWidth,
          day: day,
          month: widget.month,
          year: widget.year,
          isToday: isToday,
          todayColor: widget.todayColor,
          selectedDate: widget.dateTimeStart
        ),
      );

      if ((day - 1 + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 ||
          day == daysInMonth) {
        dayRows.add(
          Row(
            children: List<DayNumber>.from(dayRowChildren),
          ),
        );
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);

    return NotificationListener<CalendarNotification>(
        onNotification: (notification) {
          selectedDate
            ..day = notification.selectDay
            ..month = widget.month
            ..year = widget.year;
          mainModel.currentDateModel = selectedDate;
          widget.onSelectDayRang(selectedDate);
          return true;
        },
        child: Container(
          width: 7 * getDayNumberSize(context, widget.padding),
          margin: EdgeInsets.all(widget.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MonthTitle(
                year: widget.year,
                month: widget.month,
                monthNames: widget.monthNames,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: buildMonthDays(context),
              ),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildMonthView(context),
    );
  }
}
