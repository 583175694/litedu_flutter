import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/cache_data.dart';
import 'package:flutter_module/plugins/calendar_plugin/calendar_provider.dart';
import 'package:flutter_module/plugins/calendar_plugin/configuration.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/utils/LogUtil.dart';
import 'package:flutter_module/plugins/calendar_plugin/utils/date_util.dart';
import 'package:provider/provider.dart';

/**
 * 月视图，显示整个月的日子
 */
class MonthView extends StatefulWidget {
  final int year;
  final int month;
  final int day;

  final CalendarConfiguration configuration;

  const MonthView({
    Key key,
    @required this.year,
    @required this.month,
    this.day,
    this.configuration,
  }) : super(key: key);

  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView>
    with AutomaticKeepAliveClientMixin {
  List<DateModel> items = List();

  int lineCount;
  Map<DateModel, Object> extraDataMap; //自定义额外的数据

  @override
  void initState() {
    super.initState();
    extraDataMap = widget.configuration.extraDataMap;
    DateModel firstDayOfMonth =
        DateModel.fromDateTime(DateTime(widget.year, widget.month, 1));
    if (CacheData.getInstance().monthListCache[firstDayOfMonth]?.isNotEmpty ==
        true) {
      LogUtil.log(TAG: this.runtimeType, message: "缓存中有数据");
      items = CacheData.getInstance().monthListCache[firstDayOfMonth];
    } else {
      LogUtil.log(TAG: this.runtimeType, message: "缓存中无数据");
      getItems().then((_) {
        CacheData.getInstance().monthListCache[firstDayOfMonth] = items;
      });
    }

    lineCount = DateUtil.getMonthViewLineCount(widget.year, widget.month, widget.configuration.offset);

    //第一帧后,添加监听，generation发生变化后，需要刷新整个日历
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<CalendarProvider>(context, listen: false)
          .generation
          .addListener(() async {
        extraDataMap = widget.configuration.extraDataMap;
        await getItems();
      });
    });
  }

  Future getItems() async {
    items = await compute(initCalendarForMonthView, {
      'year': widget.year,
      'month': widget.month,
      'minSelectDate': widget.configuration.minSelectDate,
      'maxSelectDate': widget.configuration.maxSelectDate,
      'extraDataMap': extraDataMap,
      'offset': widget.configuration.offset
    });
    setState(() {});
  }

  static Future<List<DateModel>> initCalendarForMonthView(Map map) async {
    return DateUtil.initCalendarForMonthView(
        map['year'], map['month'], DateTime.now(), DateTime.sunday,
        minSelectDate: map['minSelectDate'],
        maxSelectDate: map['maxSelectDate'],
        extraDataMap: map['extraDataMap'],
        offset: map['offset']);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    CalendarProvider calendarProvider =
        Provider.of<CalendarProvider>(context, listen: false);
    CalendarConfiguration configuration =
        calendarProvider.calendarConfiguration;

    return new GridView.builder(
        addAutomaticKeepAlives: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, mainAxisSpacing: configuration.verticalSpacing),
        itemCount: items.isEmpty ? 0 : items.length,
        itemBuilder: (context, index) {
          DateModel dateModel = items[index];

          //  🐶判断是否被选择
          if (mainModel.currentDateModel == null &&
              dateModel.year == DateTime.now().year &&
              dateModel.month == DateTime.now().month &&
              dateModel.day == DateTime.now().day) {
            mainModel.currentDateModel = dateModel;
          }

          return ItemContainer(
            dateModel: dateModel,
            key: ObjectKey(dateModel),  //这里使用objectKey，保证可以刷新。原因1：跟flutter的刷新机制有关。原因2：statefulElement持有state。
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class ItemContainer extends StatefulWidget {
  final DateModel dateModel;

  const ItemContainer({Key key, this.dateModel}) : super(key: key);

  @override
  ItemContainerState createState() => ItemContainerState();
}

class ItemContainerState extends State<ItemContainer> {
  DateModel dateModel;
  CalendarConfiguration configuration;
  CalendarProvider calendarProvider;

  @override
  void initState() {
    super.initState();
    dateModel = widget.dateModel;

    //  🐶判断是不是当前时间
    WidgetsBinding.instance.addPostFrameCallback((callback) {
       if (dateModel.year == DateTime.now().year &&
          dateModel.month == DateTime.now().month &&
          dateModel.day == DateTime.now().day) {
         calendarProvider.lastClickDateModel = dateModel;
         calendarProvider.selectDateModel = dateModel;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);

    calendarProvider = Provider.of<CalendarProvider>(context, listen: false);
    configuration = calendarProvider.calendarConfiguration;

    return GestureDetector(
      //  🐶点击整个item都会触发事件
      behavior: HitTestBehavior.opaque,
      onTap: () {
        mainModel.currentDateModel = dateModel;

        calendarProvider.lastClickDateModel = dateModel;
        calendarProvider.selectDateModel = dateModel;

        if (configuration.calendarSelect != null) {
          configuration.calendarSelect(dateModel);
        }
      },
      child: configuration.dayWidgetBuilder(dateModel),
    );
  }
}
