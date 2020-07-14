// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolCourse _$SchoolCourseFromJson(Map<String, dynamic> json) {
  return SchoolCourse(
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SchoolCourseToJson(SchoolCourse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['id'] as int,
    json['school_id'] as int,
    json['name'] as String,
    (json['school_course_schedules'] as List)
        ?.map((e) => e == null
            ? null
            : School_course_schedules.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'school_id': instance.schoolId,
      'name': instance.name,
      'school_course_schedules': instance.schoolCourseSchedules,
    };

School_course_schedules _$School_course_schedulesFromJson(
    Map<String, dynamic> json) {
  return School_course_schedules(
    json['id'] as int,
    json['school_course_id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$School_course_schedulesToJson(
        School_course_schedules instance) =>
    <String, dynamic>{
      'id': instance.id,
      'school_course_id': instance.schoolCourseId,
      'name': instance.name,
    };
