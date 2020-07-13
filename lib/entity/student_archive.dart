import 'package:json_annotation/json_annotation.dart';

part 'student_archive.g.dart';


@JsonSerializable()
class StudentArchive extends Object {

  @JsonKey(name: 'student_id')
  int studentId;

  @JsonKey(name: 'basics')
  Basics basics;

  @JsonKey(name: 'six_skills')
  Six_skills sixSkills;

  @JsonKey(name: 'qi_skills')
  Qi_skills qiSkills;

  @JsonKey(name: 'attendances')
  Attendances attendances;

  StudentArchive(this.studentId,this.basics,this.sixSkills,this.qiSkills,this.attendances,);

  factory StudentArchive.fromJson(Map<String, dynamic> srcJson) => _$StudentArchiveFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StudentArchiveToJson(this);

}


@JsonSerializable()
class Basics extends Object {

  @JsonKey(name: 'height')
  double height;

  @JsonKey(name: 'weight')
  double weight;

  @JsonKey(name: 'soles')
  double soles;

  @JsonKey(name: 'attention_matters')
  String attentionMatters;

  Basics(this.height,this.weight,this.soles,this.attentionMatters,);

  factory Basics.fromJson(Map<String, dynamic> srcJson) => _$BasicsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BasicsToJson(this);

}


@JsonSerializable()
class Six_skills extends Object {

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

  Six_skills(this.abilityTest1,this.abilityTest2,this.abilityTest3,this.abilityTest4,this.abilityTest5,this.abilityTest6,);

  factory Six_skills.fromJson(Map<String, dynamic> srcJson) => _$Six_skillsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Six_skillsToJson(this);

}


@JsonSerializable()
class Ability_test1 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  int percent;

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
  int percent;

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
  int percent;

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
  int percent;

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
  int percent;

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
  int percent;

  Ability_test6(this.score,this.maxScore,this.percent,);

  factory Ability_test6.fromJson(Map<String, dynamic> srcJson) => _$Ability_test6FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Ability_test6ToJson(this);

}


@JsonSerializable()
class Qi_skills extends Object {

  @JsonKey(name: 'skill_1')
  Skill_1 skill1;

  @JsonKey(name: 'skill_2')
  Skill_2 skill2;

  @JsonKey(name: 'skill_3')
  Skill_3 skill3;

  @JsonKey(name: 'skill_4')
  Skill_4 skill4;

  @JsonKey(name: 'skill_5')
  Skill_5 skill5;

  @JsonKey(name: 'skill_6')
  Skill_6 skill6;

  @JsonKey(name: 'skill_7')
  Skill_7 skill7;

  Qi_skills(this.skill1,this.skill2,this.skill3,this.skill4,this.skill5,this.skill6,this.skill7,);

  factory Qi_skills.fromJson(Map<String, dynamic> srcJson) => _$Qi_skillsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Qi_skillsToJson(this);

}


@JsonSerializable()
class Skill_1 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  int percent;

  Skill_1(this.score,this.maxScore,this.percent,);

  factory Skill_1.fromJson(Map<String, dynamic> srcJson) => _$Skill_1FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Skill_1ToJson(this);

}


@JsonSerializable()
class Skill_2 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  int percent;

  Skill_2(this.score,this.maxScore,this.percent,);

  factory Skill_2.fromJson(Map<String, dynamic> srcJson) => _$Skill_2FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Skill_2ToJson(this);

}


@JsonSerializable()
class Skill_3 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  int percent;

  Skill_3(this.score,this.maxScore,this.percent,);

  factory Skill_3.fromJson(Map<String, dynamic> srcJson) => _$Skill_3FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Skill_3ToJson(this);

}


@JsonSerializable()
class Skill_4 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  int percent;

  Skill_4(this.score,this.maxScore,this.percent,);

  factory Skill_4.fromJson(Map<String, dynamic> srcJson) => _$Skill_4FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Skill_4ToJson(this);

}


@JsonSerializable()
class Skill_5 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  int percent;

  Skill_5(this.score,this.maxScore,this.percent,);

  factory Skill_5.fromJson(Map<String, dynamic> srcJson) => _$Skill_5FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Skill_5ToJson(this);

}


@JsonSerializable()
class Skill_6 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  int percent;

  Skill_6(this.score,this.maxScore,this.percent,);

  factory Skill_6.fromJson(Map<String, dynamic> srcJson) => _$Skill_6FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Skill_6ToJson(this);

}


@JsonSerializable()
class Skill_7 extends Object {

  @JsonKey(name: 'score')
  int score;

  @JsonKey(name: 'max_score')
  int maxScore;

  @JsonKey(name: 'percent')
  int percent;

  Skill_7(this.score,this.maxScore,this.percent,);

  factory Skill_7.fromJson(Map<String, dynamic> srcJson) => _$Skill_7FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Skill_7ToJson(this);

}


@JsonSerializable()
class Attendances extends Object {

  @JsonKey(name: 'leave')
  int leave;

  @JsonKey(name: 'presence')
  int presence;

  @JsonKey(name: 'absence')
  int absence;

  @JsonKey(name: 'total')
  int total;

  Attendances(this.leave,this.presence,this.absence,this.total,);

  factory Attendances.fromJson(Map<String, dynamic> srcJson) => _$AttendancesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AttendancesToJson(this);

}


