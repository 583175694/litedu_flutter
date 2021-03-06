import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';

class WeekdayRow extends StatelessWidget {
  Widget _weekdayContainer(String weekDay) => Expanded(
        child: Container(
          child: Center(
            child: DefaultTextStyle(
              style: TextStyle(
                color: Color(0xffB6BCC9),
                fontSize: ScreenUtil().setSp(28),
              ),
              child: Text(
                weekDay,
              ),
            ),
          ),
        ),
      );

  List<Widget> _renderWeekDays() {
    List<Widget> list = [];
    list.add(_weekdayContainer("日"));
    list.add(_weekdayContainer("一"));
    list.add(_weekdayContainer("二"));
    list.add(_weekdayContainer("三"));
    list.add(_weekdayContainer("四"));
    list.add(_weekdayContainer("五"));
    list.add(_weekdayContainer("六"));
    return list;
  }

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: _renderWeekDays(),
  );
}
