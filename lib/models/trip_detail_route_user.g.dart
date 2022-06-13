// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail_route_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailRouteUser _$TripDetailRouteUserFromJson(Map<String, dynamic> json) {
  return TripDetailRouteUser(
    id: json['id'] as String?,
    fullName: json['fullName'] as String?,
    turckNumber: json['turckNumber'] as String?,
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
    timeOfReaching: json['timeOfReaching'] as String?,
    timeDuration: json['timeDuration'] as String?,
    createdOnDate: json['createdOnDate'] as int?,
    startLocation: json['startLocation'] as Map<String, dynamic>?,
    
    activeRoute: json['activeRoute'] as Map<String, dynamic>?,
    //  (json['activeRoute'] as List<dynamic>?)
    //     ?.map((e) => e as Map<String, dynamic>)
    //     .(),
    isActive: json['isActive'] as bool?,
  );
}

Map<String, dynamic> _$TripDetailRouteUserToJson(
        TripDetailRouteUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'turckNumber': instance.turckNumber,
      'products': instance.products,
      'timeOfReaching': instance.timeOfReaching,
      'timeDuration': instance.timeDuration,
      'createdOnDate': instance.createdOnDate,
      'activeRoute': instance.activeRoute,
      'startLocation': instance.startLocation,
      'isActive': instance.isActive,
    };
