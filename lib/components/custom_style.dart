/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/base_day_view.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/base_week_bar.dart';

class CustomStyleWeekBarItem extends BaseWeekBar {
  CustomStyleWeekBarItem({Key key, this.text}) : super(key: key);
  ValueNotifier<String> text;

  final List<String> weekList = ["一", "二", "三", "四", "五", "六", "日"];

  //可以直接重写build方法
  @override
  Widget build(BuildContext context) {
    List<Widget> children = List();

    var items = getWeekDayWidget();
    children.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
        ValueListenableBuilder(
            valueListenable: text,
            builder: (context, value, child) {
              return new Text(text.value, style: TextStyle(fontSize: 14, color: Color(0xff6D7993)),);
            }),
      ],
    ));
    children.add(Row(
      children: items,
    ));
    return Column(
      children: children,
    );
  }

  @override
  Widget getWeekBarItem(int index) {
    return new Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          new Center(
            child: new Text(
              weekList[index], style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xffB6BCC9)),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStyleDayWidget extends BaseCombineDayWidget {
  CustomStyleDayWidget(DateModel dateModel) : super(dateModel);

  final TextStyle normalTextStyle = TextStyle(fontSize: 14, color: Color(0xff6D7993));
  final TextStyle selectTextStyle = TextStyle(fontSize: 14, color: Colors.white);
  final TextStyle noIsCurrentMonthTextStyle = TextStyle(fontSize: 14, color: Colors.white);

  @override
  Widget getNormalWidget(DateModel dateModel) {
    return Container(
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //公历
              new Expanded(
                child: Center(
                  child: new Text(
                    dateModel.day.toString(),
                    style: dateModel.isCurrentMonth
                        ? normalTextStyle
                        : noIsCurrentMonthTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget getSelectedWidget(DateModel dateModel) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
        color: Color(0xff29D9D6),
      ),
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //公历
              Container(
                child: new Expanded(
                  child: Center(
                    child: new Text(
                      dateModel.day.toString(),
                      style: dateModel.isCurrentMonth
                          ? selectTextStyle
                          : noIsCurrentMonthTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
