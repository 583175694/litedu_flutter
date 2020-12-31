// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_evaluation_trends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentEvaluationTrends _$StudentEvaluationTrendsFromJson(
    Map<String, dynamic> json) {
  return StudentEvaluationTrends(
    json['code'] as int,
    json['msg'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Trends.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StudentEvaluationTrendsToJson(
        StudentEvaluationTrends instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

Trends _$TrendsFromJson(Map<String, dynamic> json) {
  return Trends(
    json['date_name'] as String,
    json['date_range'] as String,
    (json['sum_ability_test1_score'] as num)?.toDouble(),
    (json['sum_ability_test2_score'] as num)?.toDouble(),
    (json['sum_ability_test3_score'] as num)?.toDouble(),
    (json['sum_ability_test4_score'] as num)?.toDouble(),
    (json['sum_ability_test5_score'] as num)?.toDouble(),
    (json['sum_ability_test6_score'] as num)?.toDouble(),
    (json['sum_ability_test7_score'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TrendsToJson(Trends instance) => <String, dynamic>{
      'date_name': instance.dateName,
      'date_range': instance.dateRange,
      'sum_ability_test1_score': instance.sumAbilityTest1Score,
      'sum_ability_test2_score': instance.sumAbilityTest2Score,
      'sum_ability_test3_score': instance.sumAbilityTest3Score,
      'sum_ability_test4_score': instance.sumAbilityTest4Score,
      'sum_ability_test5_score': instance.sumAbilityTest5Score,
      'sum_ability_test6_score': instance.sumAbilityTest6Score,
      'sum_ability_test7_score': instance.sumAbilityTest7Score,
    };
