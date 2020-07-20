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
/**
 * @ClassName calendar_model
 * @Author wushaohang
 * @Date 2020/7/7
 **/
import 'package:scoped_model/scoped_model.dart';

class StudentModel extends Model {
  StudentArchive _studentArchive;
  StudentEvaluation _studentEvaluation;
  SchoolCourse _schoolCourse;
  StudentEvaluationStages _studentEvaluationStages;
  Qis _studentEvaluationQis;

  Qis get studentEvaluationQis => _studentEvaluationQis;

  set studentEvaluationQis(Qis value) {
    _studentEvaluationQis = value;
  }

  int _studentId;

  int get studentId => _studentId;

  set studentId(int value) {
    _studentId = value;
    notifyListeners();
  }

  StudentEvaluationStages get studentEvaluationStages => _studentEvaluationStages;

  set studentEvaluationStages(StudentEvaluationStages value) {
    _studentEvaluationStages = value;
    notifyListeners();
  }

  SchoolCourse get schoolCourse => _schoolCourse;

  set schoolCourse(SchoolCourse value) {
    _schoolCourse = value;
    notifyListeners();
  }

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
}
