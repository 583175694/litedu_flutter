import 'package:json_annotation/json_annotation.dart'; 
  
part 'student_evaluation.g.dart';


@JsonSerializable()
  class StudentEvaluation extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'results')
  List<Results> results;

  StudentEvaluation(this.count,this.results,);

  factory StudentEvaluation.fromJson(Map<String, dynamic> srcJson) => _$StudentEvaluationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StudentEvaluationToJson(this);

}

  
@JsonSerializable()
  class Results extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  @JsonKey(name: 'attribute_labels')
  List<dynamic> attributeLabels;

  @JsonKey(name: 'drafts')
  List<dynamic> drafts;

  @JsonKey(name: 'student_name')
  String studentName;

  @JsonKey(name: 'student_logo')
  String studentLogo;

  @JsonKey(name: 'questions')
  List<Questions> questions;

  @JsonKey(name: 'student_id')
  int studentId;

  @JsonKey(name: 'teacher_id')
  int teacherId;

  @JsonKey(name: 'school_course_schedule_id')
  int schoolCourseScheduleId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'ability_test7_score')
  int abilityTest7Score;

  @JsonKey(name: 'evaluation_type')
  String evaluationType;

  Results(this.id,this.createdAt,this.updatedAt,this.attributeLabels,this.drafts,this.studentName,this.studentLogo,this.questions,this.studentId,this.teacherId,this.schoolCourseScheduleId,this.content,this.abilityTest7Score,this.evaluationType,);

  factory Results.fromJson(Map<String, dynamic> srcJson) => _$ResultsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

}

  
@JsonSerializable()
  class Questions extends Object {

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'type_name')
  String typeName;

  Questions(this.content,this.type,this.score,this.typeName,);

  factory Questions.fromJson(Map<String, dynamic> srcJson) => _$QuestionsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$QuestionsToJson(this);

}

  
