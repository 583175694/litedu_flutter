// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_course_schedules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolCourseSchedules _$SchoolCourseSchedulesFromJson(
    Map<String, dynamic> json) {
  return SchoolCourseSchedules(
    json['to_date'] as String,
    (json['school_course_schedules'] as List)
        ?.map((e) => e == null
            ? null
            : School_course_schedules.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SchoolCourseSchedulesToJson(
        SchoolCourseSchedules instance) =>
    <String, dynamic>{
      'to_date': instance.toDate,
      'school_course_schedules': instance.schoolCourseSchedules,
    };

School_course_schedules _$School_course_schedulesFromJson(
    Map<String, dynamic> json) {
  return School_course_schedules(
    json['id'] as int,
    json['name'] as String,
    json['no'] as int,
    json['school_course_id'] as int,
    json['to_date'] as String,
    json['start_time'] as String,
    json['end_time'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['student_manifest_datetime'] as String,
    json['time_length'] as int,
    json['course_schedule_id'] as int,
    json['questions'] as String,
    json['evaluation_type'] as String,
    json['school_course_schedule_name'] as String,
    json['school_course_schedule_type'] as String,
  );
}

Map<String, dynamic> _$School_course_schedulesToJson(
        School_course_schedules instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'no': instance.no,
      'school_course_id': instance.schoolCourseId,
      'to_date': instance.toDate,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'student_manifest_datetime': instance.studentManifestDatetime,
      'time_length': instance.timeLength,
      'course_schedule_id': instance.courseScheduleId,
      'questions': instance.questions,
      'evaluation_type': instance.evaluationType,
      'school_course_schedule_name': instance.schoolCourseScheduleName,
      'school_course_schedule_type': instance.schoolCourseScheduleType,
    };
