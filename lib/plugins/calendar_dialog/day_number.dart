import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/main.dart';
import 'package:flutter_module/plugins/calendar_plugin/flutter_custom_calendar.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class DayNumber extends StatefulWidget {
  const DayNumber({
    @required this.size,
    @required this.day,
    @required this.month,
    @required this.year,
    @required this.selectedDate,
    this.isToday,
    this.todayColor = Colors.blue,
  });

  final int day;
  final int month;
  final int year;
  final bool isToday;
  final Color todayColor;
  final double size;
  final DateModel selectedDate;

  @override
  _DayNumberState createState() => _DayNumberState();
}

class _DayNumberState extends State<DayNumber> {
  final double itemMargin = ScreenUtil().setWidth(24);
  DateModel date = new DateModel();

  @override
  void initState() {
    super.initState();

    date
      ..day = widget.day
      ..month = widget.month
      ..year = widget.year;
  }

  Widget _dayItem() {
    return Container(
      width: ScreenUtil().setWidth(94),
      height: ScreenUtil().setWidth(94),
      alignment: Alignment.center,
      child: Container(
        width: ScreenUtil().setWidth(64),
        height: ScreenUtil().setWidth(64),
        child: Center(
          child: Text(
            widget.day < 1 ? '' : widget.day.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: mainModel.currentDateModel == date ? Colors.white : Color(0xff6D7993),
              fontSize: ScreenUtil().setSp(28),
              fontWeight: FontWeight.normal,
            ),
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ),
        decoration: (mainModel.currentDateModel == date && widget.day > 0) ? BoxDecoration(
            color: Color(0xff29D9D6),
            borderRadius: BorderRadius.all(Radius.circular(40))
        ) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);

    return widget.day > 0
      ? GestureDetector(
          onTap: () {
            date
              ..day = widget.day
              ..month = widget.month
              ..year = widget.year;
            mainModel.currentDateModel = date;
            setState(() { });
          },
          child: _dayItem())
      : _dayItem();
  }
}
