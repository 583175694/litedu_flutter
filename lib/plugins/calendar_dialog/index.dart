import 'package:flutter/material.dart';

import 'calendar_list.dart';

class CalendarDialog extends StatefulWidget {
  CalendarDialog({Key key}) : super(key: key);

  @override
  _CalendarDialogState createState() => new _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  @override
  Widget build(BuildContext context) {
    return CalendarList(
      firstDate: DateTime.now(),
      lastDate: DateTime(2030, 6),
      onSelect: () {

      },
      onSelectFinish: (selectStartTime) {
        List<DateTime> result = <DateTime>[];
        result.add(selectStartTime);;
      },
    );
  }
}
