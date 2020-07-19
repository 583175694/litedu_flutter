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
    json['ability_test1'] == null
        ? null
        : Ability_test1.fromJson(json['ability_test1'] as Map<String, dynamic>),
    json['ability_test2'] == null
        ? null
        : Ability_test2.fromJson(json['ability_test2'] as Map<String, dynamic>),
    json['ability_test3'] == null
        ? null
        : Ability_test3.fromJson(json['ability_test3'] as Map<String, dynamic>),
    json['ability_test4'] == null
        ? null
        : Ability_test4.fromJson(json['ability_test4'] as Map<String, dynamic>),
    json['ability_test5'] == null
        ? null
        : Ability_test5.fromJson(json['ability_test5'] as Map<String, dynamic>),
    json['ability_test6'] == null
        ? null
        : Ability_test6.fromJson(json['ability_test6'] as Map<String, dynamic>),
    json['ability_test7'] == null
        ? null
        : Ability_test7.fromJson(json['ability_test7'] as Map<String, dynamic>),
    json['student_id'] as int,
    json['teacher_id'] as int,
    json['school_course_schedule_id'] as int,
    json['content'] as String,
    json['evaluation_type'] as String,
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'evaluate_datetime': instance.evaluateDatetime,
      'student_name': instance.studentName,
      'student_logo': instance.studentLogo,
      'ability_test1': instance.abilityTest1,
      'ability_test2': instance.abilityTest2,
      'ability_test3': instance.abilityTest3,
      'ability_test4': instance.abilityTest4,
      'ability_test5': instance.abilityTest5,
      'ability_test6': instance.abilityTest6,
      'ability_test7': instance.abilityTest7,
      'student_id': instance.studentId,
      'teacher_id': instance.teacherId,
      'school_course_schedule_id': instance.schoolCourseScheduleId,
      'content': instance.content,
      'evaluation_type': instance.evaluationType,
    };

Ability_test1 _$Ability_test1FromJson(Map<String, dynamic> json) {
  return Ability_test1(
    json['score'] as int,
    json['max_score'] as int,
    (json['percent'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$Ability_test1ToJson(Ability_test1 instance) =>
    <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Ability_test2 _$Ability_test2FromJson(Map<String, dynamic> json) {
  return Ability_test2(
    json['score'] as int,
    json['max_score'] as int,
    (json['percent'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$Ability_test2ToJson(Ability_test2 instance) =>
    <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Ability_test3 _$Ability_test3FromJson(Map<String, dynamic> json) {
  return Ability_test3(
    json['score'] as int,
    json['max_score'] as int,
    (json['percent'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$Ability_test3ToJson(Ability_test3 instance) =>
    <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Ability_test4 _$Ability_test4FromJson(Map<String, dynamic> json) {
  return Ability_test4(
    json['score'] as int,
    json['max_score'] as int,
    (json['percent'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$Ability_test4ToJson(Ability_test4 instance) =>
    <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Ability_test5 _$Ability_test5FromJson(Map<String, dynamic> json) {
  return Ability_test5(
    json['score'] as int,
    json['max_score'] as int,
    (json['percent'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$Ability_test5ToJson(Ability_test5 instance) =>
    <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Ability_test6 _$Ability_test6FromJson(Map<String, dynamic> json) {
  return Ability_test6(
    json['score'] as int,
    json['max_score'] as int,
    (json['percent'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$Ability_test6ToJson(Ability_test6 instance) =>
    <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Ability_test7 _$Ability_test7FromJson(Map<String, dynamic> json) {
  return Ability_test7(
    json['score'] as int,
    json['max_score'] as int,
    (json['percent'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$Ability_test7ToJson(Ability_test7 instance) =>
    <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };
