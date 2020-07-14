import 'package:json_annotation/json_annotation.dart';

part 'school_course.g.dart';


@JsonSerializable()
class SchoolCourse extends Object {

  @JsonKey(name: 'data')
  List<Data> data;

  SchoolCourse(this.data,);

  factory SchoolCourse.fromJson(Map<String, dynamic> srcJson) => _$SchoolCourseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SchoolCourseToJson(this);

}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'school_id')
  int schoolId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'school_course_schedules')
  List<School_course_schedules> schoolCourseSchedules;

  Data(this.id,this.schoolId,this.name,this.schoolCourseSchedules,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


@JsonSerializable()
class School_course_schedules extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'school_course_id')
  int schoolCourseId;

  @JsonKey(name: 'name')
  String name;

  School_course_schedules(this.id,this.schoolCourseId,this.name,);

  factory School_course_schedules.fromJson(Map<String, dynamic> srcJson) => _$School_course_schedulesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$School_course_schedulesToJson(this);

}

  
