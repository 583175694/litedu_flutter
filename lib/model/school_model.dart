import 'package:flutter_module/entity/class_team.dart';
/**
 * @ClassName school_model
 * @Author wushaohang
 * @Date 2020/7/12
 **/
import 'package:scoped_model/scoped_model.dart';

class SchoolModel extends Model {
  List<dynamic> _schoolCourseSchedules;
  List<Classes> _classTeam;

  List<Classes> get classTeam => _classTeam;

  set classTeam(List<Classes> value) {
    _classTeam = value;
  }

  List _currentCourse;

  List get currentCourse => _currentCourse;

  set currentCourse(List value) {
    _currentCourse = value;
    notifyListeners();
  }

  List<dynamic> get schoolCourseSchedules => _schoolCourseSchedules;

  set schoolCourseSchedules(List<dynamic> value) {
    _schoolCourseSchedules = value;
    notifyListeners();
  }

}