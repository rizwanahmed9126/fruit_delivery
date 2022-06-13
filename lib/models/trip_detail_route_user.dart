import 'package:json_annotation/json_annotation.dart';
part 'trip_detail_route_user.g.dart';

@JsonSerializable()
class TripDetailRouteUser {
  TripDetailRouteUser({
    this.id,
    this.fullName,
    this.turckNumber,
    this.products,
    this.timeOfReaching,
    this.timeDuration,
    this.createdOnDate,
    this.startLocation,
    this.activeRoute,
    this.isActive,
  });

  String? id;
  String? fullName;
  String? turckNumber;
  List<Map<String, dynamic>>? products;
  String? timeOfReaching;
  String? timeDuration;
  int? createdOnDate;
  Map<String, dynamic>? activeRoute;
  Map<String, dynamic>? startLocation;
  bool? isActive;

  factory TripDetailRouteUser.fromJson(Map<String, dynamic> json) =>
      _$TripDetailRouteUserFromJson(json);
  Map<String, dynamic> toJson() => _$TripDetailRouteUserToJson(this);
}
