import 'package:json_annotation/json_annotation.dart';
part 'trip_routes_model.g.dart';

@JsonSerializable()
class TripRouteModel {
  TripRouteModel({
    this.id,
    this.vendorId,
    this.truckNumber,
    this.products,
    this.timeOfReaching,
    this.timeDuration,
    this.createdOnDate,
    this.startLocation,
    this.stops,
    this.isActive,
  });

  String? id;
  String? vendorId;
  StartLocation? startLocation;
  String? timeOfReaching;
  String? timeDuration;
  String? truckNumber;
  List<Product>? products;
  List<Stop>? stops;
  bool? isActive;
  int? createdOnDate;

  factory TripRouteModel.fromJson(Map<String, dynamic> json) =>
      _$TripDetailRouteModelFromJson(json);
  Map<String, dynamic> toJson() => _$TripDetailRouteModelToJson(this);
}

class Product {
  Product({
    this.unit,
    this.backgroundColor,
    this.picture,
    this.createdOnDate,
    this.name,
    this.id,
    this.price,
  });

  String? unit;
  String? backgroundColor;
  String? picture;
  int? createdOnDate;
  String? name;
  String? id;
  String? price;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  // factory Product.fromJson(Map<String, dynamic> json) => Product(
  //   unit: json["unit"],
  //   backgroundColor: json["backgroundColor"],
  //   picture: json["picture"],
  //   createdOnDate: json["createdOnDate"],
  //   name: json["name"],
  //   id: json["id"],
  //   price: json["price"],
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "unit": unit,
  //   "backgroundColor": backgroundColor,
  //   "picture": picture,
  //   "createdOnDate": createdOnDate,
  //   "name": name,
  //   "id": id,
  //   "price": price,
  // };
}

class Location {
  Location({
    this.lat,
    this.long,
    this.city,
    this.country,
    this.hashedLocation,
    this.address,
  });

  dynamic lat;
  dynamic long;
  String? city;
  String? country;
  String? hashedLocation;
  String? address;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  // factory Location.fromJson(Map<String, dynamic> json) => Location(
  //   lat: json["lat"] == null ? null : json["lat"].toDouble(),
  //   long: json["long"] == null ? null : json["long"].toDouble(),
  //   city: json["city"] == null ? null : json["city"],
  //   country: json["country"] == null ? null : json["country"],
  //   hashedLocation: json["hashedLocation"] == null ? null : json["hashedLocation"],
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "lat": lat == null ? null : lat,
  //   "long": long == null ? null : long,
  //   "city": city == null ? null : city,
  //   "country": country == null ? null : country,
  //   "hashedLocation": hashedLocation == null ? null : hashedLocation,
  // };
}

class Stop {
  Stop({
    this.id,
    this.createdOnDate,
    this.timeDuration,
    this.location,
    this.timeOfReaching,
    this.isActive,
    this.serialNo,

  });

  String? id;
  int? createdOnDate;
  String? timeDuration;

  Location? location;
  String? timeOfReaching;
  bool? isActive;
  dynamic serialNo;

  factory Stop.fromJson(Map<String, dynamic> json) => _$StopModelFromJson(json);
  Map<String, dynamic> toJson() => _$StopModelToJson(this);

  // factory Stop.fromJson(Map<String, dynamic> json) => Stop(
  //   id: json["id"],
  //   createdOnDate: json["createdOnDate"],
  //   timeDuration: json["timeDuration"],
  //   location: Location.fromJson(json["location"]),
  //   timeOfReaching: json["timeOfReaching"],
  //   isActive: json["isActive"],
  //   serialNo: json["serialNo"],
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "createdOnDate": createdOnDate,
  //   "timeDuration": timeDuration,
  //   "location": location.toJson(),
  //   "timeOfReaching": timeOfReaching,
  //   "isActive": isActive,
  //   "serialNo": serialNo,
  // };
}

class StartLocation {
  StartLocation({
    required this.long,
    required this.city,
    required this.country,
    required this.lat,
    required this.address
  });

  dynamic long;
  String city;
  String country;
  String address;
  dynamic lat;

  factory StartLocation.fromJson(Map<String, dynamic> json) => StartLocation(
        long: json["long"].toDouble(),
        city: json["city"],
        address: json["address"],
        country: json["country"],
        lat: json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "long": long,
        "city": city,
        "address":address,
        "country": country,
        "lat": lat,
      };
}
