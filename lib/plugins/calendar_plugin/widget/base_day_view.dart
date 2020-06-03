import 'package:flutter/material.dart';
import 'package:flutter_module/plugins/calendar_plugin/controller.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';


//  🐶通过组合widget创建item，只需实现相关的方法就可以
abstract class BaseCombineDayWidget extends StatelessWidget {
  final DateModel dateModel;

  BaseCombineDayWidget(this.dateModel);

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);

    //  根据当前点击日期，判断是否选中
    return mainModel.currentDateModel == dateModel
        ? getSelectedWidget(dateModel)
        : getNormalWidget(dateModel);
  }

  Widget getNormalWidget(DateModel dateModel);

  Widget getSelectedWidget(DateModel dateModel);
}

//  通过canvas自定义item，只需实现相关的方法就可以
abstract class BaseCustomDayWidget extends StatelessWidget {
  final DateModel dateModel;

  const BaseCustomDayWidget(
    this.dateModel,
  );

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);

    return Container(
      child: new CustomPaint(
        painter:
          //  根据当前点击日期，判断是否选中
          mainModel.currentDateModel == dateModel
              ? new CustomDayWidgetPainter(dateModel,
                  drawDayWidget: drawSelected)
              : new CustomDayWidgetPainter(dateModel,
                  drawDayWidget: drawNormal),
      ),
    );
  }

  void drawNormal(DateModel dateModel, Canvas canvas, Size size);

  void drawSelected(DateModel dateModel, Canvas canvas, Size size);
}

class CustomDayWidgetPainter extends CustomPainter {
  DateModel dateModel;

  DrawDayWidget drawDayWidget; //普通样式是必须的

  CustomDayWidgetPainter(this.dateModel, {this.drawDayWidget});

  Paint textPaint;

  @override
  void paint(Canvas canvas, Size size) {
    drawDayWidget(dateModel, canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}