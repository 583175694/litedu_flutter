import 'package:json_annotation/json_annotation.dart'; 
  
part 'semester.g.dart';


@JsonSerializable()
  class Semester extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'results')
  List<Results> results;

  Semester(this.count,this.results,);

  factory Semester.fromJson(Map<String, dynamic> srcJson) => _$SemesterFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SemesterToJson(this);

}

  
@JsonSerializable()
  class Results extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'str_date')
  String strDate;

  @JsonKey(name: 'end_date')
  String endDate;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'school_id')
  int schoolId;

  Results(this.id,this.strDate,this.endDate,this.name,this.schoolId,);

  factory Results.fromJson(Map<String, dynamic> srcJson) => _$ResultsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

}

  
