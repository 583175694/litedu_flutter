import 'package:json_annotation/json_annotation.dart'; 
  
part 'school_course_schedules.g.dart';


List<SchoolCourseSchedules> getSchoolCourseSchedulesList(List<dynamic> list){
    List<SchoolCourseSchedules> result = [];
    list.forEach((item){
      result.add(SchoolCourseSchedules.fromJson(item));
    });
    return result;
  }
@JsonSerializable()
  class SchoolCourseSchedules extends Object {

  @JsonKey(name: 'to_date')
  String toDate;

  @JsonKey(name: 'school_course_schedules')
  List<School_course_schedules> schoolCourseSchedules;

  SchoolCourseSchedules(this.toDate,this.schoolCourseSchedules,);

  factory SchoolCourseSchedules.fromJson(Map<String, dynamic> srcJson) => _$SchoolCourseSchedulesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SchoolCourseSchedulesToJson(this);

}

  
@JsonSerializable()
  class School_course_schedules extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'no')
  int no;

  @JsonKey(name: 'school_course_id')
  int schoolCourseId;

  @JsonKey(name: 'to_date')
  String toDate;

  @JsonKey(name: 'start_time')
  String startTime;

  @JsonKey(name: 'end_time')
  String endTime;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  @JsonKey(name: 'student_manifest_datetime')
  String studentManifestDatetime;

  @JsonKey(name: 'time_length')
  int timeLength;

  @JsonKey(name: 'course_schedule_id')
  int courseScheduleId;

  @JsonKey(name: 'questions')
  String questions;

  @JsonKey(name: 'evaluation_type')
  String evaluationType;

  @JsonKey(name: 'school_course_schedule_name')
  String schoolCourseScheduleName;

  @JsonKey(name: 'school_course_schedule_type')
  String schoolCourseScheduleType;

  School_course_schedules(this.id,this.name,this.no,this.schoolCourseId,this.toDate,this.startTime,this.endTime,this.createdAt,this.updatedAt,this.studentManifestDatetime,this.timeLength,this.courseScheduleId,this.questions,this.evaluationType,this.schoolCourseScheduleName,this.schoolCourseScheduleType,);

  factory School_course_schedules.fromJson(Map<String, dynamic> srcJson) => _$School_course_schedulesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$School_course_schedulesToJson(this);

}

  
