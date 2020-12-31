import 'package:json_annotation/json_annotation.dart';

part 'student_evaluation_trends.g.dart';


@JsonSerializable()
class StudentEvaluationTrends extends Object {

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  List<Trends> data;

  StudentEvaluationTrends(this.code,this.msg,this.data,);

  factory StudentEvaluationTrends.fromJson(Map<String, dynamic> srcJson) => _$StudentEvaluationTrendsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StudentEvaluationTrendsToJson(this);

}


@JsonSerializable()
class Trends extends Object {

  @JsonKey(name: 'date_name')
  String dateName;

  @JsonKey(name: 'date_range')
  String dateRange;

  @JsonKey(name: 'sum_ability_test1_score')
  double sumAbilityTest1Score;

  @JsonKey(name: 'sum_ability_test2_score')
  double sumAbilityTest2Score;

  @JsonKey(name: 'sum_ability_test3_score')
  double sumAbilityTest3Score;

  @JsonKey(name: 'sum_ability_test4_score')
  double sumAbilityTest4Score;

  @JsonKey(name: 'sum_ability_test5_score')
  double sumAbilityTest5Score;

  @JsonKey(name: 'sum_ability_test6_score')
  double sumAbilityTest6Score;

  @JsonKey(name: 'sum_ability_test7_score')
  double sumAbilityTest7Score;

  Trends(this.dateName,this.dateRange,this.sumAbilityTest1Score,this.sumAbilityTest2Score,this.sumAbilityTest3Score,this.sumAbilityTest4Score,this.sumAbilityTest5Score,this.sumAbilityTest6Score,this.sumAbilityTest7Score,);

  factory Trends.fromJson(Map<String, dynamic> srcJson) => _$TrendsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TrendsToJson(this);

}