/**
 * @ClassName school_model
 * @Author wushaohang
 * @Date 2020/7/12
 **/
import 'package:scoped_model/scoped_model.dart';

class SchoolModel extends Model {
  List<dynamic> _schoolCourseSchedules;
  List<dynamic> _classTeam;

  List<dynamic> get schoolCourseSchedules => _schoolCourseSchedules;

  set schoolCourseSchedules(List<dynamic> value) {
    _schoolCourseSchedules = value;
    notifyListeners();
  }

  List<dynamic> get classTeam => _classTeam;

  set classTeam(List<dynamic> value) {
    _classTeam = value;
    notifyListeners();
  }
}