// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      id: json['id'] as String,
      name: json['name'] as String,
      species: json['species'] as String,
      house: json['house'] as String,
      dateOfBirth: json['dateOfBirth'] as String?,
      actor: json['actor'] as String,
      image: json['image'] as String,
      attempts: json['attempts'] as int?,
      isGuessed: json['isGuessed'] as bool?,
    );

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'species': instance.species,
      'house': instance.house,
      'dateOfBirth': instance.dateOfBirth,
      'actor': instance.actor,
      'image': instance.image,
      'isGuessed': instance.isGuessed,
      'attempts': instance.attempts,
    };
