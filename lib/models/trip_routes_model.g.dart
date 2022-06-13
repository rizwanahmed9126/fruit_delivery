// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_routes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripRouteModel _$TripDetailRouteModelFromJson(Map<String, dynamic> json) {
  return TripRouteModel(
    id: json["id"],
    vendorId: json["vendorId"],
    startLocation: StartLocation.fromJson(json["startLocation"]),
    timeOfReaching: json["timeOfReaching"],
    timeDuration: json["timeDuration"],
    truckNumber: json["truckNumber"],
    products:
        List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    stops: List<Stop>.from(json["stops"].map((x) => Stop.fromJson(x))),
    isActive: json["isActive"],
    createdOnDate: json["createdOnDate"],
  );
}

Map<String, dynamic> _$TripDetailRouteModelToJson(TripRouteModel instance) =>
    <String, dynamic>{
      "id": instance.id,
      "vendorId": instance.vendorId,
      "startLocation": instance.startLocation!.toJson(),
      "timeOfReaching": instance.timeOfReaching,
      "timeDuration": instance.timeDuration,
      "truckNumber": instance.truckNumber,
      "products": List<Product>.from(instance.products!.map((x) => x.toJson())),
      "stops": List<Stop>.from(instance.stops!.map((x) => x.toJson())),
      "isActive": instance.isActive,
      "createdOnDate": instance.createdOnDate ?? 0,
    };

Product _$ProductModelFromJson(Map<String, dynamic> json) {
  return Product(
    unit: json["unit"],
    backgroundColor: json["backgroundColor"],
    picture: json["picture"],
    createdOnDate: json["createdOnDate"],
    name: json["name"],
    id: json["id"],
    price: json["price"],
  );
}

Map<String, dynamic> _$ProductModelToJson(Product instance) =>
    <String, dynamic>{
      "unit": instance.unit,
      "backgroundColor": instance.backgroundColor,
      "picture": instance.picture,
      "createdOnDate": instance.createdOnDate,
      "name": instance.name,
      "id": instance.id,
      "price": instance.price,
    };

Location _$LocationModelFromJson(Map<String, dynamic> json) {
  return Location(
    lat: json["lat"],
    long: json["long"],
    city: json["city"],
    country: json["country"],
    hashedLocation: json["hashedLocation"],
      address: json["address"]
  );
}

Map<String, dynamic> _$LocationModelToJson(Location instance) =>
    <String, dynamic>{
      "lat": instance.lat,
      "long": instance.long,
      "city": instance.city,
      "country": instance.country,
      "hashedLocation": instance.hashedLocation,
      "address":instance.address,
    };

Stop _$StopModelFromJson(Map<String, dynamic> json) {
  return Stop(
    id: json["id"],
    createdOnDate: json["createdOnDate"],
    timeDuration: json["timeDuration"],
    location: Location.fromJson(json["location"]),
    timeOfReaching: json["timeOfReaching"],
    isActive: json["isActive"],
    serialNo: json["serialNo"],

  );
}

Map<String, dynamic> _$StopModelToJson(Stop instance) => <String, dynamic>{
      "id": instance.id,
      "createdOnDate": instance.createdOnDate,
      "timeDuration": instance.timeDuration,
      "location": instance.location!.toJson(),
      "timeOfReaching": instance.timeOfReaching,
      "isActive": instance.isActive,
      "serialNo": instance.serialNo,

    };
