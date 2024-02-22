import 'package:json_annotation/json_annotation.dart';

part 'languageJson.g.dart';

@JsonSerializable()
class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
