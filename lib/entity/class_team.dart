import 'package:json_annotation/json_annotation.dart';

part 'class_team.g.dart';


@JsonSerializable()
class ClassTeam extends Object {

  @JsonKey(name: 'data')
  List<Classes> data;

  ClassTeam(this.data,);

  factory ClassTeam.fromJson(Map<String, dynamic> srcJson) => _$ClassTeamFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ClassTeamToJson(this);

}


@JsonSerializable()
class Classes extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'year_grade_id')
  int yearGradeId;

  @JsonKey(name: 'year')
  int year;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  @JsonKey(name: 'school_id')
  int schoolId;

  @JsonKey(name: 'initial_year_grade_id')
  int initialYearGradeId;

  @JsonKey(name: 'bind_id')
  String bindId;

  @JsonKey(name: 'teacher_id')
  int teacherId;

  @JsonKey(name: 'teacher_type')
  String teacherType;

  @JsonKey(name: 'year_grade_name')
  String yearGradeName;

  Classes(this.id,this.yearGradeId,this.year,this.name,this.createdAt,this.updatedAt,this.schoolId,this.initialYearGradeId,this.bindId,this.teacherId,this.teacherType,this.yearGradeName,);

  factory Classes.fromJson(Map<String, dynamic> srcJson) => _$ClassesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ClassesToJson(this);

}

  
