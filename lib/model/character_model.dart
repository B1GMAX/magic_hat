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
  final bool? isGuessed;
  final int? attempts;

  CharacterModel({
    required this.id,
    required this.name,
    required this.species,
    required this.house,
    required this.dateOfBirth,
    required this.actor,
    required this.image,
    required this.attempts,
    required this.isGuessed,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  CharacterModel copyWith({
    String? id,
    String? name,
    String? species,
    String? house,
    String? dateOfBirth,
    String? actor,
    String? image,
    bool? isGuessed,
    int? attempts,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      house: house ?? this.house,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      image: image ?? this.image,
      isGuessed: isGuessed ?? this.isGuessed,
      attempts: attempts ?? this.attempts,
      actor: actor ?? this.actor,
    );
  }
}
