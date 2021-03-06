import 'package:flutter_module/entity/qis.dart';
import 'package:flutter_module/entity/school_course.dart';
import 'package:flutter_module/entity/student_archive.dart';
/**
 * @ClassName student_model
 * @Author wushaohang
 * @Date 2020/7/11
 **/
import 'package:flutter_module/entity/student_evaluation.dart';
import 'package:flutter_module/entity/student_evaluation_stages.dart';
import 'package:flutter_module/entity/student_evaluation_trends.dart';
/**
 * @ClassName calendar_model
 * @Author wushaohang
 * @Date 2020/7/7
 **/
import 'package:scoped_model/scoped_model.dart';

class StudentModel extends Model {
  //  学生档案
  StudentArchive _studentArchive;
  //  学生评估
  StudentEvaluation _studentEvaluation;
  //  学校课程
  SchoolCourse _schoolCourse;
  //  学生评估阶段
  StudentEvaluationStages _studentEvaluationStages;
  //  七边形数据
  Qis _studentEvaluationQis;
  //  当前选中七边形索引
  int _currentQis = 0;
  //  学生id
  String _studentId;
  //  学生评价列表高度
  int _listHeight;
  //  七边形趋势
  List<Trends> _studentEvaluationQisTrends;

  StudentArchive get studentArchive => _studentArchive;

  set studentArchive(StudentArchive value) {
    _studentArchive = value;
    notifyListeners();
  }

  StudentEvaluation get studentEvaluation => _studentEvaluation;

  set studentEvaluation(StudentEvaluation value) {
    _studentEvaluation = value;
    notifyListeners();
  }

  SchoolCourse get schoolCourse => _schoolCourse;

  set schoolCourse(SchoolCourse value) {
    _schoolCourse = value;
    notifyListeners();
  }

  StudentEvaluationStages get studentEvaluationStages => _studentEvaluationStages;

  set studentEvaluationStages(StudentEvaluationStages value) {
    _studentEvaluationStages = value;
    notifyListeners();
  }

  Qis get studentEvaluationQis => _studentEvaluationQis;

  set studentEvaluationQis(Qis value) {
    _studentEvaluationQis = value;
    notifyListeners();
  }

  int get currentQis => _currentQis;

  set currentQis(int value) {
    _currentQis = value;
    notifyListeners();
  }

  String get studentId => _studentId;

  set studentId(String value) {
    _studentId = value;
    notifyListeners();
  }

  int get listHeight => _listHeight;

  set listHeight(int value) {
    _listHeight = value;
    notifyListeners();
  }

  List<Trends> get studentEvaluationQisTrends => _studentEvaluationQisTrends;

  set studentEvaluationQisTrends(List<Trends> value) {
    _studentEvaluationQisTrends = value;
    notifyListeners();
  }
}
