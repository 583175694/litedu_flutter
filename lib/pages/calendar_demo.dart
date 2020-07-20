import 'package:flutter/material.dart';
import 'package:flutter_module/components/calendar_month.dart';
import 'package:flutter_module/components/calendar_week.dart';
import 'package:flutter_module/components/custom_style.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/plugins/calendar_plugin/constants/constants.dart';
import 'package:flutter_module/plugins/calendar_plugin/controller.dart';
import 'package:flutter_module/plugins/calendar_plugin/widget/calendar_view.dart';
import 'package:flutter_module/plugins/panel.dart';

class SlideUpPanelDemo extends StatefulWidget {
  SlideUpPanelDemo({Key key}) : super(key: key);

  @override
  _SlideUpPanelDemoState createState() => _SlideUpPanelDemoState();
}

class _SlideUpPanelDemoState extends State<SlideUpPanelDemo> {
  bool showCollapsed = false; //是否显示折叠时的内容
  double maxHeight = 368; //最大展开高度
  double minHeight = 152; //最小收缩高度
  bool showBorder = false; //是否显示边框
  bool borderRadius = true; //启用圆角
  bool backdropEnabled = false; //启用背景半透明化
  bool parallaxEnabled = false; //开启视差滚动
  double parallaxOffset = 0.1; //时差滚动阀值 0.0-1.0
  bool slideDirectionReverse = true; //拖动方向
  //  日历控制
  CalendarController _calendarController;
  //  滚动控制
  ScrollController _scrollController;
  //  切换周、月视图
  String currentView = 'week';
  //  初始日期
  ValueNotifier<String> text;
  //  选择日期
  ValueNotifier<String> selectText;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _calendarController = new CalendarController(
        minYear: now.year - 1,
        minYearMonth: 1,
        maxYear: now.year + 1,
        maxYearMonth: 12,
        showMode: CalendarConstants.MODE_SHOW_ONLY_WEEK);

    _calendarController.addMonthChangeListener((year, month) {
      text.value = "$year年$month月";
    });

    _calendarController.addOnCalendarSelectListener((dateModel) {
      //刷新选择的时间
      selectText.value = "${dateModel.year}年${dateModel.month}月${dateModel.day}日";
      setState(() { });
    });

    text = new ValueNotifier("${DateTime.now().year}年${DateTime.now().month}月");
    selectText = new ValueNotifier("${now.year}年 ${now.month}月${now.day}日");
  }

  @override
  Widget build(BuildContext context) {
		ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
			..init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("slide_up_panel"),
        elevation: 0,
      ),
      body: SlidingUpPanel(
          collapsed: Container(
            child: CalendarWeek(),
          ),
          panel: Container(
            child: CalendarMonth(),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("是否显示折叠时的组件"),
                    new Switch(
                      value: this.showCollapsed,
                      activeColor: Colors.blue,
                      onChanged: (bool val) {
                        this.setState(() {
                          this.showCollapsed = !this.showCollapsed;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("最大展开高度:" + maxHeight.toInt().toString()),
                    new Slider(
                      value: this.maxHeight,
                      max: MediaQuery.of(context).size.height - 44,
                      min: 20.0,
                      activeColor: Colors.blue,
                      onChanged: (double val) {
                        this.setState(() {
                          this.maxHeight = val;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("是否显示边框border"),
                    new Switch(
                      value: this.showBorder,
                      activeColor: Colors.blue,
                      onChanged: (bool val) {
                        this.setState(() {
                          this.showBorder = !this.showBorder;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("是否启用圆角"),
                    new Switch(
                      value: this.borderRadius,
                      activeColor: Colors.blue,
                      onChanged: (bool val) {
                        this.setState(() {
                          this.borderRadius = !this.borderRadius;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("是否背景半透明化"),
                    new Switch(
                      value: this.backdropEnabled,
                      activeColor: Colors.blue,
                      onChanged: (bool val) {
                        this.setState(() {
                          this.backdropEnabled = !this.backdropEnabled;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("开启视差滚动"),
                    new Switch(
                      value: this.parallaxEnabled,
                      activeColor: Colors.blue,
                      onChanged: (bool val) {
                        this.setState(() {
                          this.parallaxEnabled = !this.parallaxEnabled;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("视差滚动阀值:" + parallaxOffset.toStringAsFixed(2)),
                    new Slider(
                      value: this.parallaxOffset,
                      max: 1.0,
                      min: 0.0,
                      activeColor: Colors.blue,
                      onChanged: (double val) {
                        this.setState(() {
                          this.parallaxOffset = val;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("从上往下"),
                    new Switch(
                      value: this.slideDirectionReverse,
                      activeColor: Colors.blue,
                      onChanged: (bool val) {
                        this.setState(() {
                          this.slideDirectionReverse = !this.slideDirectionReverse;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          maxHeight: maxHeight, //  maxHeight
          minHeight: minHeight,
          border: showBorder
              ? Border(
                  top: BorderSide(
                  color: Colors.blue,
                ))
              : null,
          borderRadius: borderRadius
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                )
              : null,
          backdropEnabled: backdropEnabled,
          parallaxEnabled: parallaxEnabled,
          parallaxOffset: parallaxOffset,
          slideDirection: slideDirectionReverse ? SlideDirection.DOWN : SlideDirection.UP),
    );
  }


	//  月历
	Widget calendarContent() {
		return new Container(
			child: new Stack(
				children: <Widget>[
					CalendarViewWidget(
						weekBarItemWidgetBuilder: () {
							return CustomStyleWeekBarItem(text: text);
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
