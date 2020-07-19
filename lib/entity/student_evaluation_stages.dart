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

  @JsonKey(name: 'student_id')
  int studentId;

  @JsonKey(name: 'teacher_id')
  int teacherId;

  @JsonKey(name: 'school_course_schedule_id')
  int schoolCourseScheduleId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'ability_test1_score')
  int abilityTest1Score;

  @JsonKey(name: 'ability_test2_score')
  int abilityTest2Score;

  @JsonKey(name: 'ability_test3_score')
  int abilityTest3Score;

  @JsonKey(name: 'ability_test4_score')
  int abilityTest4Score;

  @JsonKey(name: 'ability_test5_score')
  int abilityTest5Score;

  @JsonKey(name: 'ability_test6_score')
  int abilityTest6Score;

  @JsonKey(name: 'ability_test7_score')
  int abilityTest7Score;

  @JsonKey(name: 'evaluation_type')
  String evaluationType;

  @JsonKey(name: 'evaluation_stage')
  String evaluationStage;

  Results(this.id,this.createdAt,this.updatedAt,this.evaluateDatetime,this.studentName,this.studentLogo,this.studentId,this.teacherId,this.schoolCourseScheduleId,this.content,this.abilityTest1Score,this.abilityTest2Score,this.abilityTest3Score,this.abilityTest4Score,this.abilityTest5Score,this.abilityTest6Score,this.abilityTest7Score,this.evaluationType,this.evaluationStage,);

  factory Results.fromJson(Map<String, dynamic> srcJson) => _$ResultsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

}

  
