part of 'routehistory_model.dart';

RouteHistory _$RouteHistoryFromJson(Map<String, dynamic> json) {
  return RouteHistory(
     id: json["id"],
        vendorId: json["vendorId"],
        startLocation: json["startLocation"],
        timeOfReaching: json["timeOfReaching"],
        timeDuration: json["timeDuration"],
        truckNumber: json["truckNumber"],
        products: List<dynamic>.from(json["products"].map((x) => x)),
        stops: List<dynamic>.from(json["stops"].map((x) => x)),
        isActive: json["isActive"],
        createdOnDate: json["createdOnDate"],
  );



}
  Map<String, dynamic> _$RouteHistoryToJson(RouteHistory instance) => <String, dynamic>{
      "id": instance.id,
        "vendorId": instance.vendorId,
        "startLocation": instance.startLocation,
        "timeOfReaching": instance.timeOfReaching,
        "timeDuration": instance.timeDuration,
        "truckNumber": instance.truckNumber,
        "products": List<dynamic>.from(instance.products!.map((x) => x)),
        "stops": List<dynamic>.from(instance.stops!.map((x) => x)),
        "isActive": instance.isActive,
        "createdOnDate": instance.createdOnDate,
  };

