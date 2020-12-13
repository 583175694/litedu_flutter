// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_archive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentArchive _$StudentArchiveFromJson(Map<String, dynamic> json) {
  return StudentArchive(
    json['student_id'] as int,
    json['student_name'] as String,
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
      'student_name': instance.studentName,
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

Qi_skills _$Qi_skillsFromJson(Map<String, dynamic> json) {
  return Qi_skills(
    json['qi_ability1'] as int,
    json['qi_ability2'] as int,
    json['qi_ability3'] as int,
    json['qi_ability4'] as int,
    json['qi_ability5'] as int,
    json['qi_ability6'] as int,
    json['qi_ability7'] as int,
  );
}

Map<String, dynamic> _$Qi_skillsToJson(Qi_skills instance) => <String, dynamic>{
      'qi_ability1': instance.qiAbility1,
      'qi_ability2': instance.qiAbility2,
      'qi_ability3': instance.qiAbility3,
      'qi_ability4': instance.qiAbility4,
      'qi_ability5': instance.qiAbility5,
      'qi_ability6': instance.qiAbility6,
      'qi_ability7': instance.qiAbility7,
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
