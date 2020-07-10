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

  Map get studentManifests => _studentManifests;

  set studentManifests(Map value) {
    _studentManifests = value;
  }

  Map get studentArchive => _studentArchive;

  set studentArchive(Map value) {
    _studentArchive = value;
  }
}