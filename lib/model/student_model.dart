/**
 * @ClassName student_model
 * @Author wushaohang
 * @Date 2020/7/11
 **/
/**
 * @ClassName calendar_model
 * @Author wushaohang
 * @Date 2020/7/7
 **/
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/dto/dateDto.dart';

class StudentModel extends Model{
  Map _studentArchive;
  Map _studentManifests;
  List _myStudents;
  Map _semester;
  Map _teachFeedbackList;
  Map _studentAfterTeachFeedbackList;

  List get myStudents => _myStudents;

  set myStudents(List value) {
    _myStudents = value;
  }

  Map get studentAfterTeachFeedbackList => _studentAfterTeachFeedbackList;

  set studentAfterTeachFeedbackList(Map value) {
    _studentAfterTeachFeedbackList = value;
  }

  Map get teachFeedbackList => _teachFeedbackList;

  set teachFeedbackList(Map value) {
    _teachFeedbackList = value;
  }

  Map get semester => _semester;

  set semester(Map value) {
    _semester = value;
    notifyListeners();
  }

  Map get studentManifests => _studentManifests;

  set studentManifests(Map value) {
    _studentManifests = value;
    notifyListeners();
  }

  Map get studentArchive => _studentArchive;

  set studentArchive(Map value) {
    _studentArchive = value;
    notifyListeners();
  }
}