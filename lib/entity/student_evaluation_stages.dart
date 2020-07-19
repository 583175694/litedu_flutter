import 'package:json_annotation/json_annotation.dart';

part 'student_evaluation_stages.g.dart';


@JsonSerializable()
class StudentEvaluationStages extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'results')
  List<Results> results;

  StudentEvaluationStages(this.count,this.results,);

  factory StudentEvaluationStages.fromJson(Map<String, dynamic> srcJson) => _$StudentEvaluationStagesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StudentEvaluationStagesToJson(this);

}


@JsonSerializable()
class Results extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  @JsonKey(name: 'evaluate_datetime')
  String evaluateDatetime;

  @JsonKey(name: 'student_name')
  String studentName;

  @JsonKey(name: 'student_logo')
  String studentLogo;

  @JsonKey(name: 'ability_test1')
  Ability_test1 abilityTest1;

  @JsonKey(name: 'ability_test2')
  Ability_test2 abilityTest2;

  @JsonKey(name: 'ability_test3')
  Ability_test3 abilityTest3;

  @JsonKey(name: 'ability_test4')
  Ability_test4 abilityTest4;

  @JsonKey(name: 'ability_test5')
  Ability_test5 abilityTest5;

  @JsonKey(name: 'ability_test6')
  Ability_test6 abilityTest6;

  @JsonKey(name: 'ability_test7')
  Ability_test7 abilityTest7;

  @JsonKey(name: 'student_id')
  int studentId;

  @JsonKey(name: 'teacher_id')
  int teacherId;

  @JsonKey(name: 'school_course_schedule_id')
  int schoolCourseScheduleId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'evaluation_type')
  String evaluationType;

  Results(this.id,this.createdAt,this.updatedAt,this.evaluateDatetime,this.studentName,this.studentLogo,this.abilityTest1,this.abilityTest2,this.abilityTest3,this.abilityTest4,this.abilityTest5,this.abilityTest6,this.abilityTest7,this.studentId,this.teacherId,this.schoolCourseScheduleId,this.content,this.evaluationType,);

  factory Results.fromJson(Map<String, dynamic> srcJson) => _$ResultsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

}


@JsonSerializable()
class Ability_test1 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  double percent;

  Ability_test1(this.score,this.maxScore,this.percent,);

  factory Ability_test1.fromJson(Map<String, dynamic> srcJson) => _$Ability_test1FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Ability_test1ToJson(this);

}


@JsonSerializable()
class Ability_test2 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  double percent;

  Ability_test2(this.score,this.maxScore,this.percent,);

  factory Ability_test2.fromJson(Map<String, dynamic> srcJson) => _$Ability_test2FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Ability_test2ToJson(this);

}


@JsonSerializable()
class Ability_test3 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  double percent;

  Ability_test3(this.score,this.maxScore,this.percent,);

  factory Ability_test3.fromJson(Map<String, dynamic> srcJson) => _$Ability_test3FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Ability_test3ToJson(this);

}


@JsonSerializable()
class Ability_test4 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  double percent;

  Ability_test4(this.score,this.maxScore,this.percent,);

  factory Ability_test4.fromJson(Map<String, dynamic> srcJson) => _$Ability_test4FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Ability_test4ToJson(this);

}


@JsonSerializable()
class Ability_test5 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  double percent;

  Ability_test5(this.score,this.maxScore,this.percent,);

  factory Ability_test5.fromJson(Map<String, dynamic> srcJson) => _$Ability_test5FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Ability_test5ToJson(this);

}


@JsonSerializable()
class Ability_test6 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  double percent;

  Ability_test6(this.score,this.maxScore,this.percent,);

  factory Ability_test6.fromJson(Map<String, dynamic> srcJson) => _$Ability_test6FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Ability_test6ToJson(this);

}


@JsonSerializable()
class Ability_test7 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  double percent;

  Ability_test7(this.score,this.maxScore,this.percent,);

  factory Ability_test7.fromJson(Map<String, dynamic> srcJson) => _$Ability_test7FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Ability_test7ToJson(this);

}

  
