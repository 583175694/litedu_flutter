/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';

class ScheduleList extends StatefulWidget {
  ScheduleList({Key key, this.selectText}) : super(key: key);
  final ValueNotifier<String> selectText;

  @override
  ScheduleListState createState() => ScheduleListState();
}

class ScheduleListState extends State<ScheduleList> {
  Map prov = new Map();
  Map next = new Map();

  // 数据源
  List<String> titleItems = <String>[null, '英语课', '语文课', '化学课', '物理课', null, null, '数学课', '英语课', '语文课', '化学课'];  // 数据源

  List colorItems = [
    {"background": Color(0xffD0EDFF), "circle": Color(0xff14A4FF)},
    {"background": Color(0xffD4F7F7), "circle": Color(0xff29D9D6)},
    {"background": Color(0xffFFEED7), "circle": Color(0xffFFA938)},
    {"background": Color(0xffFEDCDB), "circle": Color(0xffFC4F4D)},
    {"background": Color(0xffD0EDFF), "circle": Color(0xff14A4FF)},
    {"background": Color(0xffF0F2F4), "circle": Color(0xffB6BCC9)},
    {"background": Color(0xffF0F2F4), "circle": Color(0xffB6BCC9)},
    {"background": Color(0xffD4F7F7), "circle": Color(0xff29D9D6)},
    {"background": Color(0xffFFEED7), "circle": Color(0xffFFA938)},
    {"background": Color(0xffFEDCDB), "circle": Color(0xffFC4F4D)},
    {"background": Color(0xffD0EDFF), "circle": Color(0xff14A4FF)},
  ];

  List timeItems = [
    {"class": "早读", "time": "07:00", "interval": "07:00 - 07:45"},
    {"class": "第1节课", "time": "08:00", "interval": "08:00 - 08:45"},
    {"class": "第2节课", "time": "09:00", "interval": "09:00 - 09:45"},
    {"class": "第3节课", "time": "10:00", "interval": "10:00 - 10:45"},
    {"class": "第4节课", "time": "11:00", "interval": "11:00 - 11:45"},
    {"class": "午休时间", "time": "12:00", "interval": "12:00 - 12:45"},
    {"class": "午休时间", "time": "13:00", "interval": "13:00 - 13:45"},
    {"class": "第5节课", "time": "14:00", "interval": "14:00 - 14:45"},
    {"class": "第6节课", "time": "15:00", "interval": "15:00 - 15:45"},
    {"class": "第7节课", "time": "16:00", "interval": "16:00 - 16:45"},
    {"class": "第8节课", "time": "17:00", "interval": "17:00 - 17:45"},
  ];

  int willAcceptIndex;

  bool accepted = false;

  //  判断午休时间
  bool isLunchBreak(int i) {
    return i < 5 || i > 6 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    //  日程列表
    List<Widget> scheduleList() {
      TextStyle timeFont = TextStyle(fontSize: ScreenUtil().setSp(22), color: Color(0xffB6BCC9));

      List<Widget> tiles = [];
      tiles.add(
          Container(
            height: 60.0,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(widget.selectText.value, style: TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(44)))
              ],
            ),
            margin: EdgeInsets.only(left: 15.0),
          )
      );
      for (int i = 0; i < titleItems.length; i++) {
        //  可拖动列表
        if (!isLunchBreak(i)) {
          tiles.add(
              DragTarget(  //  可放置的地方
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(124),
                          child: Column(
                            children: <Widget>[
                              Text(timeItems[i]["class"], style: timeFont),
                              Text(timeItems[i]["time"], style: timeFont)
                            ],
                          ),
                        ),
                        LongPressDraggable(  //  可拖动的地方
                            child: courseItem(i),
                            axis: Axis.vertical,
                            feedback: courseItem(i),
                            onDragStarted: () {
                              prov["value"] = titleItems[i];
                              prov["color"] = colorItems[i];
                              prov["index"] = i;

                              accepted = true;
                              setState(() { });
                            },
                            onDraggableCanceled: (velocity, offset) {
                              accepted = false;
                              setState(() { });
                            }
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  );
                },
                onWillAccept: (data) {
                  willAcceptIndex = i;
                  setState(() { });
                  return true;
                },
                onAccept: (data) {
                  next["value"] = titleItems[i];
                  next["color"] = colorItems[i];
                  next["index"] = i;

                  setState(() {
                    titleItems[next["index"]] = prov["value"];
                    titleItems[prov["index"]] = next["value"];
                    colorItems[next["index"]] = prov["color"];
                    colorItems[prov["index"]] = next["color"];

                    accepted = false;
                  });

                  print('prov: $prov, next: $next accepted:$accepted');
                },
              )
          );
        } else {
          tiles.add(
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(124),
                      child: Column(
                        children: <Widget>[
                          Text(timeItems[i]["class"], style: timeFont),
                          Text(timeItems[i]["time"], style: timeFont)
                        ],
                      ),
                    ),
                    lunchBreakItem(i)
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              )
          );
        }
      }
      return tiles;
    }
    
    return SliverFixedExtentList(
      itemExtent: ScreenUtil().setWidth(144),
      delegate: SliverChildListDelegate(
          scheduleList()
      ),
    );
  }

  //  课程项
  Widget courseItem(int i) {
    TextStyle courseFont = TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993), fontWeight: FontWeight.normal, decoration: TextDecoration.none);
    TextStyle evaluateFont = TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff29D9D6), fontWeight: FontWeight.normal, decoration: TextDecoration.none);

    return Opacity(
      opacity: willAcceptIndex == i && accepted ? 0.6 : 1,
      child: Container(
        width: ScreenUtil().setWidth(626),
        height: ScreenUtil().setWidth(128),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(timeItems[i]["class"],
                          style: courseFont
                      ),
                      margin: EdgeInsets.only(left: 12, right: 6),
                    ),
                    Text(titleItems[i] == null ? '' : "-  ${titleItems[i]}",
                        style: courseFont
                    ),
                  ],
                ),
                i == 5 ? Container() : Container(
                  width: ScreenUtil().setWidth(128),
                  height: ScreenUtil().setWidth(56),
                  alignment: Alignment.centerRight,
                  child: Center(
                    child: Text('评估', style: evaluateFont),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      color: Colors.white
                  ),
                  margin: EdgeInsets.only(right: 8),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: colorItems[i]["circle"]
                  ),
                  margin: EdgeInsets.only(left: 12, right: 6),
                ),
                Text(
                  timeItems[i]["interval"],
                  style: courseFont,
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: colorItems[i]["background"],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(i == 6 ? 0 : 10), bottomLeft: Radius.circular(i == 5 ? 0 :10))
        ),
      ),
    );
  }

  //  午休的情况
  Widget lunchBreakItem(int i) {
    return Container(
      width: ScreenUtil().setWidth(626),
      height: ScreenUtil().setWidth(138),
      padding: EdgeInsets.only(top: i == 5 ? 20 : 0),
      margin: EdgeInsets.only(top: i == 5 ? 6 : 0, bottom: i == 6 ? 6 : 0),
      child: i == 6 ? Container() : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text(timeItems[i]["class"],
                    style: TextStyle(fontSize: 14, color: Color(0xff6D7993), fontWeight: FontWeight.normal, decoration: TextDecoration.none)
                ),
                margin: EdgeInsets.only(left: 12, right: 6),
              ),
              Text(titleItems[i] == null ? '' : "-  ${titleItems[i]}",
                  style: TextStyle(fontSize: 14, color: Color(0xff6D7993), decoration: TextDecoration.none, fontWeight: FontWeight.normal)
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: colorItems[i]["circle"]
                ),
                margin: EdgeInsets.only(left: 12, right: 6),
              ),
              Text(
                timeItems[i]["interval"],
                style: TextStyle(fontSize: 14, color: Color(0xff6D7993), decoration: TextDecoration.none, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: colorItems[i]["background"],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(i == 6 ? 0 : 10), bottomLeft: Radius.circular(i == 5 ? 0 :10))
      ),
    );
  }
}