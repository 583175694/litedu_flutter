import 'package:flutter_module/plugins/calendar_plugin/controller.dart';
/**
 * @ClassName calendar_model
 * @Author wushaohang
 * @Date 2020/7/7
 **/
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/dto/dateDto.dart';

class CalendarModel extends Model{
  //  编辑状态
  bool _isEdit = false;
  //  当前选中日期，默认当前日期
  DateModel _currentDateModel = DateDto().toDateModel(DateTime.now());
  //  当前月份
  String _currentMonth = "${DateTime.now().year}年${DateTime.now().month}月";
  //  当前视图
  String _currentView = "week";
  //  月视图控制器
  CalendarController _monthController;
  //  周视图控制器
  CalendarController _weekController;


  bool get isEdit => _isEdit;
  DateModel get currentDateModel => _currentDateModel;
  String get currentMonth => _currentMonth;
  String get currentView => _currentView;
  CalendarController get monthController => _monthController;
  CalendarController get weekController => _weekController;

  set isEdit(bool value) {
    _isEdit = value;
    notifyListeners();
  }

  set currentDateModel(DateModel value) {
    _currentDateModel = value;
    notifyListeners();
  }

  set currentMonth(String value) {
    _currentMonth = value;
    notifyListeners();
  }

  set currentView(String value) {
    _currentView = value;
    notifyListeners();
  }

  set monthController(CalendarController value) {
    _monthController = value;
    notifyListeners();
  }

  set weekController(CalendarController value) {
    _weekController = value;
    notifyListeners();
  }

}