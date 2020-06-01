import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'calendar_notification.dart';

class DayNumber extends StatefulWidget {
  const DayNumber({
    @required this.size,
    @required this.day,
    @required this.isDefaultSelected,
    this.isToday,
    this.todayColor = Colors.blue,
  });

  final int day;
  final bool isToday;
  final Color todayColor;
  final double size;
  final bool isDefaultSelected;

  @override
  _DayNumberState createState() => _DayNumberState();
}

class _DayNumberState extends State<DayNumber> {
  final double itemMargin = ScreenUtil().setWidth(24);
  bool isSelected;

  Widget _dayItem() {
    return Container(
      width: ScreenUtil().setWidth(64),
      height: ScreenUtil().setWidth(64),
      margin: EdgeInsets.all(ScreenUtil().setWidth(15.8)),
      alignment: Alignment.center,
      decoration: (isSelected && widget.day > 0)
          ? BoxDecoration(color: Colors.blue)
          : widget.isToday ? BoxDecoration(color: widget.todayColor) : null,
      child: Text(
        widget.day < 1 ? '' : widget.day.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: (widget.isToday || isSelected) ? Colors.white : Colors.black87,
          fontSize: ScreenUtil().setSp(28),
          fontWeight: FontWeight.normal,
        ),
        overflow: TextOverflow.visible,
        softWrap: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isSelected = widget.isDefaultSelected;
    return widget.day > 0
        ? GestureDetector(
            onTap: () => CalendarNotification(widget.day).dispatch(context),
            child: _dayItem())
        : _dayItem();
  }
}
