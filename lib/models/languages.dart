import 'package:json_annotation/json_annotation.dart';

part 'languages.g.dart';

@JsonSerializable()
class LanguagesModel {
  String? id;
  String? languages;

  LanguagesModel(
    this.id,
    this.languages,
  );




  factory LanguagesModel.fromJson(Map<String, dynamic> json) =>
      _$LanguagesModelFromJson(json);
  Map<String, dynamic> toJson() => _$LanguagesModelToJson(this);

}
