/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/custom_style.dart';
import 'package:flutter_module/plugins/calendar_plugin/constants/constants.dart';
import 'package:flutter_module/plugins/calendar_plugin/controller.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/base_day_view.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/base_week_bar.dart';
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
    'keyboard', 'print',
    'router', 'pages',
    'zoom_out_map', 'zoom_out',
    'youtube_searched_for', 'wifi_tethering',
    'wifi_lock', 'widgets',
    'weekend', 'web',
    '图accessible', 'ac_unit',
  ];

  List<Icon> iconItems = <Icon>[
    new Icon(Icons.keyboard), new Icon(Icons.print),
    new Icon(Icons.router), new Icon(Icons.pages),
    new Icon(Icons.zoom_out_map), new Icon(Icons.zoom_out),
    new Icon(Icons.youtube_searched_for), new Icon(Icons.wifi_tethering),
    new Icon(Icons.wifi_lock), new Icon(Icons.widgets),
    new Icon(Icons.weekend), new Icon(Icons.web),
    new Icon(Icons.accessible), new Icon(Icons.ac_unit),
  ];

  List<String> subTitleItems = <String>[
    'subTitle: keyboard', 'subTitle: print',
    'subTitle: router', 'subTitle: pages',
    'subTitle: zoom_out_map', 'subTitle: zoom_out',
    'subTitle: youtube_searched_for', 'subTitle: wifi_tethering',
    'subTitle: wifi_lock', 'subTitle: widgets',
    'subTitle: weekend', 'subTitle: web',
    'subTitle: accessible', 'subTitle: ac_unit',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();

    //  监听滚动距离切换周/月视图
    _scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset > 256.0) {
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
          title: Text('标题'),
        ),
        body: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  bottom: PreferredSize(
                      preferredSize: Size(200, 86),
                      child: Container()
                  ),
                  backgroundColor: Colors.white,
                  expandedHeight: 396.0,
                  flexibleSpace: Stack(
                    overflow: Overflow.clip,
                    children: <Widget>[
                      Positioned(
                          top: 0,
                          child: CalendarContent()
                      ),
                    ],
                  ),
                  elevation: 0,
                  pinned: pinned,
                ),
                SliverFixedExtentList(
                  itemExtent: 80.0,
                  delegate: SliverChildListDelegate(
                      scheduleList()
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }

  //  日程列表
  List<Widget> scheduleList() {
    List<Widget> tiles = [];
    for (int i = 0; i < subTitleItems.length; i++) {
      tiles.add(
          buildListData(context, titleItems[i], iconItems[i], subTitleItems[i], i)
      );
    }

    return tiles;
  }

  //  单个日程项
  Widget buildListData(BuildContext context, String titleItem, Icon iconItem, String subTitleItem, index) {
    bool accepted = false;

    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return new ListTile(
          leading: iconItem,
          title: new Text(
            titleItem,
            style: TextStyle(fontSize: 18),
          ),
          subtitle: new Text(
            subTitleItem,
          ),
          trailing: new Draggable(
              child: new Icon(Icons.adjust),
              axis: Axis.vertical,
              feedback: new Container(
                  transform: Matrix4.translationValues(-MediaQuery.of(context).size.width + 50, 0, 0),
                  child: new Text(
                    titleItem,
                    style: TextStyle(fontSize: 25),
                  )
              ),
              onDragStarted: () {
                prov["value"] = titleItem;
                prov["index"] = index;
              }
          ),
        );
      },
      //返回是否接收 参数为Draggable的data 方向相同则允许接收
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        next["value"] = titleItem;
        next["index"] = index;
        accepted = true;

        setState(() {
          titleItems[next["index"]] = prov["value"];
          titleItems[prov["index"]] = next["value"];
        });

        print('prov: $prov, next: $next accepted:$accepted');
      },
    );
  }
}