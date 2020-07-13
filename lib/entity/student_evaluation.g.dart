// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentEvaluation _$StudentEvaluationFromJson(Map<String, dynamic> json) {
  return StudentEvaluation(
    json['count'] as int,
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Results.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StudentEvaluationToJson(StudentEvaluation instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results(
    json['id'] as int,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['attribute_labels'] as List,
    json['drafts'] as List,
    json['student_name'] as String,
    json['student_logo'] as String,
    (json['questions'] as List)
        ?.map((e) =>
            e == null ? null : Questions.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['student_id'] as int,
    json['teacher_id'] as int,
    json['school_course_schedule_id'] as int,
    json['content'] as String,
    json['ability_test7_score'] as int,
    json['evaluation_type'] as String,
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'attribute_labels': instance.attributeLabels,
      'drafts': instance.drafts,
      'student_name': instance.studentName,
      'student_logo': instance.studentLogo,
      'questions': instance.questions,
      'student_id': instance.studentId,
      'teacher_id': instance.teacherId,
      'school_course_schedule_id': instance.schoolCourseScheduleId,
      'content': instance.content,
      'ability_test7_score': instance.abilityTest7Score,
      'evaluation_type': instance.evaluationType,
    };

Questions _$QuestionsFromJson(Map<String, dynamic> json) {
  return Questions(
    json['content'] as String,
    json['type'] as String,
    json['score'] as int,
    json['type_name'] as String,
  );
}

Map<String, dynamic> _$QuestionsToJson(Questions instance) => <String, dynamic>{
      'content': instance.content,
      'type': instance.type,
      'score': instance.score,
      'type_name': instance.typeName,
    };
