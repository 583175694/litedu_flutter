/**
 * @ClassName main_model
 * @Author wushaohang
 * @Date 2020/6/2
 **/
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';

class MainModel extends Model{
  //  编辑状态
  bool _isEdit = false;
  //  当前选中日期
  DateModel _currentDateModel;

  bool get isEdit => _isEdit;
  DateModel get currentDateModel => _currentDateModel;

  set isEdit(bool value) {
    _isEdit = value;
    notifyListeners();
  }

  set currentDateModel(DateModel value) {
    _currentDateModel = value;
    notifyListeners();
  }
}