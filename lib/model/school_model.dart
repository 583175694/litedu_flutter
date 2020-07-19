import 'package:flutter_module/entity/class_team.dart';
import 'package:flutter_module/entity/semester.dart';
/**
 * @ClassName school_model
 * @Author wushaohang
 * @Date 2020/7/12
 **/
import 'package:scoped_model/scoped_model.dart';

class SchoolModel extends Model {
  List<dynamic> _schoolCourseSchedules;
  List<Classes> _classTeam;
  Semester _semester;
  Results _currentSemester;


  Results get currentSemester => _currentSemester;

  set currentSemester(Results value) {
    _currentSemester = value;
    notifyListeners();
  }

  Semester get semester => _semester;

  set semester(Semester value) {
    _semester = value;
    notifyListeners();
  }

  List<Classes> get classTeam => _classTeam;

  set classTeam(List<Classes> value) {
    _classTeam = value;
    notifyListeners();
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