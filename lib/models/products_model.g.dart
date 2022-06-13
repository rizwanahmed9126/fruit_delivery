// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return Products(
    id: json['id'] as String?,
    name: json['name'] as String?,
    picture: json['picture'] as String?,
    price: json['price'] as String?,
    unit: json['unit'] as String?,
    createdOnDate: json['createdOnDate'] as int?,
    backgroundColor: json['backgroundColor'] as String?,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'unit': instance.unit,
      'createdOnDate': instance.createdOnDate,
      'picture': instance.picture,
      'backgroundColor': instance.backgroundColor,
      'description': instance.description,
    };
