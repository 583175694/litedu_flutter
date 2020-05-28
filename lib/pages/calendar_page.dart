import 'dart:math';

/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/custom_style.dart';
import 'package:flutter_module/plugins/calendar_plugin/constants/constants.dart';
import 'package:flutter_module/plugins/calendar_plugin/controller.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/calendar_view.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  bool floating = false;
  bool pinned = true;
  CalendarController _calendarController;
  String currentView = 'month';   //  切换周、月视图

  ValueNotifier<String> text;
  ValueNotifier<String> selectText;

  Map prov = new Map();
  Map next = new Map();
  ScrollController _scrollController;

  // 数据源
  List<String> titleItems = <String>[
    null, '英语课',
    '语文课', '化学课',
    '物理课', null,
    null, '数学课', '英语课',
    '语文课', '化学课'
  ];  // 数据源

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

  List<String> subTitleItems = <String>[
    'keyboard', 'print',
    'router', 'pages',
    'zoom_out_map', 'zoom_out',
    'youtube_searched_for', 'wifi_tethering',
    'wifi_lock', 'widgets',
    'weekend'];

  int willAcceptIndex;

  bool accepted = false;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _calendarController = new CalendarController(
        minYear: now.year - 1,
        minYearMonth: 1,
        maxYear: now.year + 1,
        maxYearMonth: 12,
        showMode: CalendarConstants.MODE_SHOW_MONTH_AND_WEEK);

    _calendarController.addMonthChangeListener((year, month) {
      text.value = "$year年$month月";
    },
    );

    _calendarController.addOnCalendarSelectListener((dateModel) {
      //刷新选择的时间
      selectText.value = "${dateModel.year}年 ${dateModel.month}月${dateModel.day}日";
      setState(() { });
    });

    text = new ValueNotifier("${DateTime.now().year}年${DateTime.now().month}月");

    selectText = new ValueNotifier("${now.year}年 ${now.month}月${now.day}日");


    _scrollController = new ScrollController();

    //  监听滚动距离切换周/月视图
    _scrollController.addListener(() {
      if (_scrollController.offset > 210.0) {
        if (currentView == 'month') {
          _calendarController.toggleExpandStatus();
        }
        currentView = 'week';
      } else {
        if (currentView == 'week') {
          _calendarController.toggleExpandStatus();
        }
        currentView = 'month';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                child: Image.asset('lib/assets/icon_list.png'),
              ),
              Text('课程安排', style: TextStyle(color: Color(0xff6D7993), fontSize: 20),),
              Container(
                width: 24,
                height: 24,
                child: Image.asset('lib/assets/icon_setting.png'),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  bottom: PreferredSize(
                      preferredSize: Size(200, 83),
                      child: Container()
                  ),
                  backgroundColor: Colors.white,
                  expandedHeight: 352.0,
                  flexibleSpace: Stack(
                    overflow: Overflow.clip,
                    children: <Widget>[
                      Positioned(
                          top: 0,
                          child: calendarContent()
                      ),
                    ],
                  ),
                  elevation: 0,
                  pinned: pinned,
                ),
                SliverFixedExtentList(
                  itemExtent: 72.0,
                  delegate: SliverChildListDelegate(
                      scheduleList()
                  ),
                )
              ],
            ),
          ],
        )
    );
  }

  //  日程列表
  List<Widget> scheduleList() {
    TextStyle timeFont = TextStyle(fontSize: 11, color: Color(0xffB6BCC9));

    List<Widget> tiles = [];
    tiles.add(
        Container(
          height: 60.0,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(selectText.value, style: TextStyle(color: Color(0xff6D7993), fontSize: 20),)
            ],
          ),
          margin: EdgeInsets.only(left: 15.0),
        )
    );
    for (int i = 0; i < subTitleItems.length; i++) {
      //  可拖动列表
      tiles.add(
          DragTarget(  //  可放置的地方
            builder: (context, candidateData, rejectedData) {
              return Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 62,
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
                        prov["subtitle"] = subTitleItems[i];
                        prov["color"] = colorItems[i];
                        prov["index"] = i;

                        accepted = true;
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
            //返回是否接收 参数为Draggable的data 方向相同则允许接收
            onWillAccept: (data) {
              willAcceptIndex = i;
              setState(() { });
              return true;
            },
            onAccept: (data) {
              next["value"] = titleItems[i];
              next["subtitle"] = subTitleItems[i];
              next["color"] = colorItems[i];
              next["index"] = i;

              accepted = false;

              setState(() {
                titleItems[next["index"]] = prov["value"];
                titleItems[prov["index"]] = next["value"];
                subTitleItems[next["index"]] = prov["subtitle"];
                subTitleItems[prov["index"]] = next["subtitle"];
                colorItems[next["index"]] = prov["color"];
                colorItems[prov["index"]] = next["color"];
              });

              print('prov: $prov, next: $next accepted:$accepted');
            },
          )
      );
    }
    return tiles;
  }

  //  课程项
  Widget courseItem(int i) {
    return Opacity(
      opacity: willAcceptIndex == i && accepted ? 0.6 : 1,
      child: Container(
        width: 313,
        height: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(timeItems[i]["class"],
                      style: TextStyle(fontSize: 14, color: Color(0xff6D7993), fontWeight: FontWeight.normal, decoration: TextDecoration.none)),
                  margin: EdgeInsets.only(left: 12, right: 6),
                ),
                Text(titleItems[i] == null ? '' : "|  ${titleItems[i]}",
                    style: TextStyle(fontSize: 14, color: Color(0xff6D7993), decoration: TextDecoration.none, fontWeight: FontWeight.normal)),
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
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
        ),
      ),
    );
  }

  //  月历
  Widget calendarContent() {
    return new Container(
      child: new Stack(
        children: <Widget>[
          CalendarViewWidget(
            weekBarItemWidgetBuilder: () {
              return CustomStyleWeekBarItem(text: text,);
            },
            dayWidgetBuilder: (dateModel) {
              return CustomStyleDayWidget(dateModel);
            },
            calendarController: _calendarController,
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              color: Colors.white,
            ),
            verticalSpacing: 0,
            padding: EdgeInsets.only(bottom: 16),
          ),
          Positioned(
            bottom: 10,
            left: 163,
            child: Container(
              width: 49,
              height: 6,
              decoration: BoxDecoration(
                color: Color(0xffD3D6DE),
                borderRadius: BorderRadius.all(Radius.circular(3.0))
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 20.0,
              offset: Offset(0.0, 0.0),
            ),
          ]
      ),
    );
  }
}