import 'package:flutter_module/entity/class_team.dart';
/**
 * @ClassName school_model
 * @Author wushaohang
 * @Date 2020/7/12
 **/
import 'package:scoped_model/scoped_model.dart';

class HomeModel extends Model {
  Map<String, dynamic> _header;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Map<String, dynamic> get header => _header;

  set header(Map<String, dynamic> value) {
    _header = value;
    notifyListeners();
  }
}