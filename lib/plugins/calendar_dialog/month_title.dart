import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';

import 'utils/dates.dart';

class MonthTitle extends StatelessWidget {
  const MonthTitle({
    @required this.month,
    @required this.year,
    this.monthNames,
  });

  final int month;
  final int year;
  final List<String> monthNames;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 4,
            height: 28,
            decoration: BoxDecoration(
                color: Color(0xff29D9D6),
                borderRadius: BorderRadius.only(topRight: Radius.circular(77.0), bottomRight: Radius.circular(77.0))
            ),
            margin: EdgeInsets.only(right: 16.0),
          ),
          Text(
            '$year年$month月',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color(0xff6D7993)
            ),
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
    );
  }
}
