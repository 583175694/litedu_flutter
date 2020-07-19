// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_evaluation_stages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentEvaluationStages _$StudentEvaluationStagesFromJson(
    Map<String, dynamic> json) {
  return StudentEvaluationStages(
    json['count'] as int,
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Results.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StudentEvaluationStagesToJson(
        StudentEvaluationStages instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results(
    json['id'] as int,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['evaluate_datetime'] as String,
    json['student_name'] as String,
    json['student_logo'] as String,
    json['student_id'] as int,
    json['teacher_id'] as int,
    json['school_course_schedule_id'] as int,
    json['content'] as String,
    json['ability_test1_score'] as int,
    json['ability_test2_score'] as int,
    json['ability_test3_score'] as int,
    json['ability_test4_score'] as int,
    json['ability_test5_score'] as int,
    json['ability_test6_score'] as int,
    json['ability_test7_score'] as int,
    json['evaluation_type'] as String,
    json['evaluation_stage'] as String,
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'evaluate_datetime': instance.evaluateDatetime,
      'student_name': instance.studentName,
      'student_logo': instance.studentLogo,
      'student_id': instance.studentId,
      'teacher_id': instance.teacherId,
      'school_course_schedule_id': instance.schoolCourseScheduleId,
      'content': instance.content,
      'ability_test1_score': instance.abilityTest1Score,
      'ability_test2_score': instance.abilityTest2Score,
      'ability_test3_score': instance.abilityTest3Score,
      'ability_test4_score': instance.abilityTest4Score,
      'ability_test5_score': instance.abilityTest5Score,
      'ability_test6_score': instance.abilityTest6Score,
      'ability_test7_score': instance.abilityTest7Score,
      'evaluation_type': instance.evaluationType,
      'evaluation_stage': instance.evaluationStage,
    };
