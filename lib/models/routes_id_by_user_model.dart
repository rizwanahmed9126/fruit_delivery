import 'package:fruit_delivery_flutter/models/products_model.dart';
import 'package:fruit_delivery_flutter/models/trip_routes_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'routes_id_by_user_model.g.dart';

@JsonSerializable()
class RouteById {
  RouteById({
    this.id,
    this.vendorId,
    this.turckNumber,
    this.products,
    this.timeOfReaching,
    this.timeDuration,
    this.createdOnDate,
    this.startLocation,
    this.stops,
    this.isActive,
  });


  // bool isActive;
  // String timeOfReaching;
  // Location startLocation;
  // List<Stop> stops;
  // String vendorId;
  // String id;
  // int reachedAt;
  // String truckNumber;
  // List<Product> products;
  // int createdOnDate;


  String? id;
  String? vendorId;
  String? turckNumber;
  List<Products>? products;
  String? timeOfReaching;
  String? timeDuration;
  int? createdOnDate;
  List<Map<String, dynamic>>? stops;
  Map<String, dynamic>? startLocation;
  bool? isActive;

  factory RouteById.fromJson(Map<String, dynamic> json) =>
      _$RouteByIdFromJson(json);
  Map<String, dynamic> toJson() => _$RouteByIdToJson(this);
}
