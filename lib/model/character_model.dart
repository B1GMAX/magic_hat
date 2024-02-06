import 'package:json_annotation/json_annotation.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel {
  final String id;
  final String name;
  final String species;
  final String house;
  final String? dateOfBirth;
  final String actor;
  final String image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.species,
    required this.house,
    required this.dateOfBirth,
    required this.actor,
    required this.image,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);
}
