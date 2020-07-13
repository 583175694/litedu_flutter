// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_archive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentArchive _$StudentArchiveFromJson(Map<String, dynamic> json) {
  return StudentArchive(
    json['student_id'] as int,
    json['basics'] == null
        ? null
        : Basics.fromJson(json['basics'] as Map<String, dynamic>),
    json['six_skills'] == null
        ? null
        : Six_skills.fromJson(json['six_skills'] as Map<String, dynamic>),
    json['qi_skills'] == null
        ? null
        : Qi_skills.fromJson(json['qi_skills'] as Map<String, dynamic>),
    json['attendances'] == null
        ? null
        : Attendances.fromJson(json['attendances'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StudentArchiveToJson(StudentArchive instance) =>
    <String, dynamic>{
      'student_id': instance.studentId,
      'basics': instance.basics,
      'six_skills': instance.sixSkills,
      'qi_skills': instance.qiSkills,
      'attendances': instance.attendances,
    };

Basics _$BasicsFromJson(Map<String, dynamic> json) {
  return Basics(
    (json['height'] as num)?.toDouble(),
    (json['weight'] as num)?.toDouble(),
    (json['soles'] as num)?.toDouble(),
    json['attention_matters'] as String,
  );
}

Map<String, dynamic> _$BasicsToJson(Basics instance) => <String, dynamic>{
      'height': instance.height,
      'weight': instance.weight,
      'soles': instance.soles,
      'attention_matters': instance.attentionMatters,
    };

Six_skills _$Six_skillsFromJson(Map<String, dynamic> json) {
  return Six_skills(
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
  );
}

Map<String, dynamic> _$Six_skillsToJson(Six_skills instance) =>
    <String, dynamic>{
      'ability_test1': instance.abilityTest1,
      'ability_test2': instance.abilityTest2,
      'ability_test3': instance.abilityTest3,
      'ability_test4': instance.abilityTest4,
      'ability_test5': instance.abilityTest5,
      'ability_test6': instance.abilityTest6,
    };

Ability_test1 _$Ability_test1FromJson(Map<String, dynamic> json) {
  return Ability_test1(
    json['score'] as int,
    json['max_score'] as int,
    json['percent'] as int,
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
    json['percent'] as int,
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
    json['percent'] as int,
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
    json['percent'] as int,
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
    json['percent'] as int,
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
    json['percent'] as int,
  );
}

Map<String, dynamic> _$Ability_test6ToJson(Ability_test6 instance) =>
    <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Qi_skills _$Qi_skillsFromJson(Map<String, dynamic> json) {
  return Qi_skills(
    json['skill_1'] == null
        ? null
        : Skill_1.fromJson(json['skill_1'] as Map<String, dynamic>),
    json['skill_2'] == null
        ? null
        : Skill_2.fromJson(json['skill_2'] as Map<String, dynamic>),
    json['skill_3'] == null
        ? null
        : Skill_3.fromJson(json['skill_3'] as Map<String, dynamic>),
    json['skill_4'] == null
        ? null
        : Skill_4.fromJson(json['skill_4'] as Map<String, dynamic>),
    json['skill_5'] == null
        ? null
        : Skill_5.fromJson(json['skill_5'] as Map<String, dynamic>),
    json['skill_6'] == null
        ? null
        : Skill_6.fromJson(json['skill_6'] as Map<String, dynamic>),
    json['skill_7'] == null
        ? null
        : Skill_7.fromJson(json['skill_7'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$Qi_skillsToJson(Qi_skills instance) => <String, dynamic>{
      'skill_1': instance.skill1,
      'skill_2': instance.skill2,
      'skill_3': instance.skill3,
      'skill_4': instance.skill4,
      'skill_5': instance.skill5,
      'skill_6': instance.skill6,
      'skill_7': instance.skill7,
    };

Skill_1 _$Skill_1FromJson(Map<String, dynamic> json) {
  return Skill_1(
    json['score'] as int,
    json['max_score'] as int,
    json['percent'] as int,
  );
}

Map<String, dynamic> _$Skill_1ToJson(Skill_1 instance) => <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Skill_2 _$Skill_2FromJson(Map<String, dynamic> json) {
  return Skill_2(
    json['score'] as int,
    json['max_score'] as int,
    json['percent'] as int,
  );
}

Map<String, dynamic> _$Skill_2ToJson(Skill_2 instance) => <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Skill_3 _$Skill_3FromJson(Map<String, dynamic> json) {
  return Skill_3(
    json['score'] as int,
    json['max_score'] as int,
    json['percent'] as int,
  );
}

Map<String, dynamic> _$Skill_3ToJson(Skill_3 instance) => <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Skill_4 _$Skill_4FromJson(Map<String, dynamic> json) {
  return Skill_4(
    json['score'] as int,
    json['max_score'] as int,
    json['percent'] as int,
  );
}

Map<String, dynamic> _$Skill_4ToJson(Skill_4 instance) => <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Skill_5 _$Skill_5FromJson(Map<String, dynamic> json) {
  return Skill_5(
    json['score'] as int,
    json['max_score'] as int,
    json['percent'] as int,
  );
}

Map<String, dynamic> _$Skill_5ToJson(Skill_5 instance) => <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Skill_6 _$Skill_6FromJson(Map<String, dynamic> json) {
  return Skill_6(
    json['score'] as int,
    json['max_score'] as int,
    json['percent'] as int,
  );
}

Map<String, dynamic> _$Skill_6ToJson(Skill_6 instance) => <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Skill_7 _$Skill_7FromJson(Map<String, dynamic> json) {
  return Skill_7(
    json['score'] as int,
    json['max_score'] as int,
    json['percent'] as int,
  );
}

Map<String, dynamic> _$Skill_7ToJson(Skill_7 instance) => <String, dynamic>{
      'score': instance.score,
      'max_score': instance.maxScore,
      'percent': instance.percent,
    };

Attendances _$AttendancesFromJson(Map<String, dynamic> json) {
  return Attendances(
    json['leave'] as int,
    json['presence'] as int,
    json['absence'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$AttendancesToJson(Attendances instance) =>
    <String, dynamic>{
      'leave': instance.leave,
      'presence': instance.presence,
      'absence': instance.absence,
      'total': instance.total,
    };
