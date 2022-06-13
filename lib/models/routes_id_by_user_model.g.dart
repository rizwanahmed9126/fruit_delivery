// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes_id_by_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteById _$RouteByIdFromJson(Map<String, dynamic> json) {
  return RouteById(
    id: json['id'] as String?,
    vendorId: json['vendorId'] as String?,
    turckNumber: json['truckNumber'] as String?,
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
        .toList(),
    timeOfReaching: json['timeOfReaching'] as String?,
    timeDuration: json['timeDuration'] as String?,
    createdOnDate: json['createdOnDate'] as int?,
    startLocation: json['startLocation'] as Map<String, dynamic>?,
    stops: (json['stops'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
    isActive: json['isActive'] as bool?,
  );
}

Map<String, dynamic> _$RouteByIdToJson(RouteById instance) => <String, dynamic>{
      'id': instance.id,
      'vendorId': instance.vendorId,
      'truckNumber': instance.turckNumber,
      'products': instance.products,
      'timeOfReaching': instance.timeOfReaching,
      'timeDuration': instance.timeDuration,
      'createdOnDate': instance.createdOnDate,
      'stops': instance.stops,
      'startLocation': instance.startLocation,
      'isActive': instance.isActive,
    };
