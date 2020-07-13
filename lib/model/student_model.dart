import 'package:flutter_module/entity/student_archive.dart';
/**
 * @ClassName student_model
 * @Author wushaohang
 * @Date 2020/7/11
 **/
import 'package:flutter_module/entity/student_evaluation.dart';
/**
 * @ClassName calendar_model
 * @Author wushaohang
 * @Date 2020/7/7
 **/
import 'package:scoped_model/scoped_model.dart';

class StudentModel extends Model {
  StudentArchive _studentArchive;
  StudentEvaluation _studentEvaluation;

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
