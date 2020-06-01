/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/plugins/calendar_dialog/fullscreen_demo.dart';

class DateChoiceModel extends StatefulWidget {
  @override
  DateChoiceModelState createState() => DateChoiceModelState();
}

class DateChoiceModelState extends State<DateChoiceModel> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: ScreenUtil().setWidth(670),
        height: ScreenUtil().setWidth(806),
        child: Column(
          children: <Widget>[
            Container(
              height: 56,
              child: Center(
                child: Text('选择班级', style: TextStyle(fontSize: ScreenUtil().setWidth(32), color: Color(0xff6D7993), fontWeight: FontWeight.normal, decoration: TextDecoration.none)),
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.06)))
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(670),
              height: ScreenUtil().setWidth(582),
              child: FullScreenDemo(),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.06)))
              ),
            ),
            GestureDetector(
              child: Container(
                height: 56,
                width: 336,
                child: Center(
                  child: Text('确定', style: TextStyle(fontSize: ScreenUtil().setWidth(32), color: Color(0xff29D9D6), fontWeight: FontWeight.normal, decoration: TextDecoration.none)),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
      ),
    );
  }
}