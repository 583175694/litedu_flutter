// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Semester _$SemesterFromJson(Map<String, dynamic> json) {
  return Semester(
    json['count'] as int,
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Results.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SemesterToJson(Semester instance) => <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results(
    json['id'] as int,
    json['str_date'] as String,
    json['end_date'] as String,
    json['name'] as String,
    json['school_id'] as int,
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'id': instance.id,
      'str_date': instance.strDate,
      'end_date': instance.endDate,
      'name': instance.name,
      'school_id': instance.schoolId,
    };
