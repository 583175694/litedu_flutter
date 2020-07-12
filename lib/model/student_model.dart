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

class StudentModel extends Model{
  Map _studentArchive;
  Map _studentEvaluation;

  Map get studentEvaluation => _studentEvaluation;

  set studentEvaluation(Map value) {
    _studentEvaluation = value;
  }

  Map get studentArchive => _studentArchive;

  set studentArchive(Map value) {
    _studentArchive = value;
  }
}