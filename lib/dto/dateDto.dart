import 'package:flutter_module/plugins/calendar_plugin/flutter_custom_calendar.dart';

/**
 * @ClassName dateDto
 * @Author wushaohang
 * @Date 2020/6/3
 **/
class DateDto {
  DateModel toDateModel(DateTime oldDate) {
    DateModel newDate = new DateModel();
    newDate.year = oldDate.year;
    newDate.month = oldDate.month;
    newDate.day = oldDate.day;

    return newDate;
  }
}