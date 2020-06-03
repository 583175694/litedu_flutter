import 'package:flutter/material.dart';
import 'package:flutter_module/dto/dateDto.dart';
import 'calendar_list.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CalendarDialog extends StatefulWidget {
  CalendarDialog({Key key}) : super(key: key);

  @override
  _CalendarDialogState createState() => new _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);

    return CalendarList(
      firstDate: DateTime.now(),
      lastDate: DateTime(2030, 6),
      selectedStartDate: mainModel.currentDateModel
    );
  }
}