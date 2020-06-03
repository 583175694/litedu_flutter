/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/plugins/calendar_dialog/calendar_dialog.dart';

class DateChoiceModel extends StatefulWidget {
  @override
  DateChoiceModelState createState() => DateChoiceModelState();
}

class DateChoiceModelState extends State<DateChoiceModel> {
  TextStyle titleFont = TextStyle(fontSize: ScreenUtil().setSp(32), color: Color(0xff6D7993), fontWeight: FontWeight.normal, decoration: TextDecoration.none);
  TextStyle buttonFont = TextStyle(fontSize: ScreenUtil().setWidth(32), color: Color(0xff29D9D6), fontWeight: FontWeight.normal, decoration: TextDecoration.none);

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
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 56,
                  child: Center(
                    child: Text('日期', style: titleFont),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(670),
                  height: ScreenUtil().setWidth(582),
                  child: CalendarDialog(),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.06)))
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 56,
                    width: 336,
                    child: Center(
                      child: Text('确定', style: buttonFont),
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
            Positioned(
              top: ScreenUtil().setHeight(40),
              right: ScreenUtil().setWidth(48),
              child: Text('取消', style: buttonFont),
            )
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