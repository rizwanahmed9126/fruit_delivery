


import 'package:json_annotation/json_annotation.dart';

part 'routehistory_model.g.dart';

@JsonSerializable()
class RouteHistory {
    RouteHistory({
        this.id,
        this.vendorId,
        this.startLocation,
        this.timeOfReaching,
        this.timeDuration,
        this.truckNumber,
        this.products,
        this.stops,
        this.isActive,
        this.createdOnDate,
    });

    String? id;
    String? vendorId;
    String? startLocation;
    String? timeOfReaching;
    String? timeDuration;
    String? truckNumber;
    List<dynamic>? products;
    List<dynamic>? stops;
    bool? isActive;
    int? createdOnDate;

    factory RouteHistory.fromJson(Map<String, dynamic> json) =>
      _$RouteHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$RouteHistoryToJson(this);

  
}

class StartLocation {
    StartLocation();

    factory StartLocation.fromJson(Map<String, dynamic> json) => StartLocation(
    );
}