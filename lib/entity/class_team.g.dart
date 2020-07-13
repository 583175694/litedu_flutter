// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassTeam _$ClassTeamFromJson(Map<String, dynamic> json) {
  return ClassTeam(
    json['id'] as int,
    json['year_grade_id'] as int,
    json['year'] as int,
    json['name'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['school_id'] as int,
    json['initial_year_grade_id'] as int,
    json['bind_id'] as String,
    json['teacher_id'] as int,
    json['teacher_type'] as String,
    json['year_grade_name'] as String,
  );
}

Map<String, dynamic> _$ClassTeamToJson(ClassTeam instance) => <String, dynamic>{
      'id': instance.id,
      'year_grade_id': instance.yearGradeId,
      'year': instance.year,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'school_id': instance.schoolId,
      'initial_year_grade_id': instance.initialYearGradeId,
      'bind_id': instance.bindId,
      'teacher_id': instance.teacherId,
      'teacher_type': instance.teacherType,
      'year_grade_name': instance.yearGradeName,
    };
