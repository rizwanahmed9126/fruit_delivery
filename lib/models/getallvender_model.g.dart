part of 'getallvender_model.dart';

GetVendor _$GetVendorFromJson(Map<String, dynamic> json) {
  return GetVendor(
    id: json["id"],
    fullName: json["fullName"],
    lat: json["lat"],
    long: json["long"],
    products: Products.fromJson(json["products"]),
    createdOnDate: json["createdOnDate"],
    loginSource: json["loginSource"],
    age: json["age"],
    todayRoutes: List<dynamic>.from(json["TodayRoutes"].map((x) => x)),
    currentSpot: json["currentSpot"],
    isActive: json["isActive"],
    activeRoute: json["activeRoute"] == null
        ? null
        : ActiveRoute.fromJson(json["activeRoute"]),
    isApproved: json["isApproved"],
    isBlocked: json["isBlocked"],
    isChatBlocked: json["isChatBlocked"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    address: json["address"],
    role: json["role"],
    isEmailVerified: json["isEmailVerified"],
    profilePicture: json["profilePicture"],
    gender: json["gender"] == null ? null : json["gender"],
  );
}

Map<String, dynamic> _$GetVendorToJson(GetVendor instance) => <String, dynamic>{
      "id": instance.id,
      "fullName": instance.fullName,
      "lat": instance.lat,
      "long": instance.long,
      "products": instance.products!.toJson(),
      "createdOnDate": instance.createdOnDate,
      "loginSource": instance.loginSource,
      "age": instance.age,
      "TodayRoutes": List<dynamic>.from(instance.todayRoutes!.map((x) => x)),
      "currentSpot": instance.currentSpot,
      "isActive": instance.isActive,
      "activeRoute":
          instance.activeRoute == null ? null : instance.activeRoute!.toJson(),
      "isApproved": instance.isApproved,
      "isBlocked": instance.isBlocked,
      "isChatBlocked": instance.isChatBlocked,
      "email": instance.email,
      "phoneNumber": instance.phoneNumber,
      "address": instance.address,
      "role": instance.role,
      "isEmailVerified": instance.isEmailVerified,
      "profilePicture": instance.profilePicture,
      "gender": instance.gender == null ? null : instance.gender,
    };

ActiveRoute _$ActiveRouteFromJson(Map<String, dynamic> json) {
  return ActiveRoute(
    isServerError: json["isServerError"] == null ? null : json["isServerError"],
    isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : ActiveRouteData.fromJson(json["data"]),
    truckNumber: json["truckNumber"] == null ? null : json["truckNumber"],
    vendorId: json["vendorId"] == null ? null : json["vendorId"],
    id: json["id"] == null ? null : json["id"],
    timeDuration: json["timeDuration"] == null ? null : json["timeDuration"],
    createdOnDate: json["createdOnDate"] == null ? null : json["createdOnDate"],
    stops: json["stops"] == null
        ? null
        : List<Stop>.from(json["stops"].map((x) => Stop.fromJson(x))),
    timeOfReaching:
        json["timeOfReaching"] == null ? null : json["timeOfReaching"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    products: json["products"] == null
        ? null
        : List<EoVunuvKaJXrlM7L6HbA>.from(
            json["products"].map((x) => EoVunuvKaJXrlM7L6HbA.fromJson(x))),
  );
}

Map<String, dynamic> _$ActiveRouteToJson(ActiveRoute instance) =>
    <String, dynamic>{
      "isServerError":
          instance.isServerError == null ? null : instance.isServerError,
      "isSuccess": instance.isSuccess == null ? null : instance.isSuccess,
      "message": instance.message == null ? null : instance.message,
      "data": instance.data == null ? null : instance.data!.toJson(),
      "truckNumber": instance.truckNumber == null ? null : instance.truckNumber,
      "vendorId": instance.vendorId == null ? null : instance.vendorId,
      "id": instance.id == null ? null : instance.id,
      "timeDuration":
          instance.timeDuration == null ? null : instance.timeDuration,
      "createdOnDate":
          instance.createdOnDate == null ? null : instance.createdOnDate,
      "stops": instance.stops == null
          ? null
          : List<dynamic>.from(instance.stops!.map((x) => x.toJson())),
      "timeOfReaching":
          instance.timeOfReaching == null ? null : instance.timeOfReaching,
      "isActive": instance.isActive == null ? null : instance.isActive,
      "products": instance.products == null
          ? null
          : List<dynamic>.from(instance.products!.map((x) => x.toJson())),
    };
ActiveRouteData _$ActiveRouteDataFromJson(Map<String, dynamic> json) {
  return ActiveRouteData(
    createdOnDate: json["createdOnDate"],
    stops: List<Stop>.from(json["stops"].map((x) => Stop.fromJson(x))),
    vendorId: json["vendorId"],
    isActive: json["isActive"],
    timeDuration: json["timeDuration"],
    timeOfReaching: json["timeOfReaching"],
    truckNumber: json["truckNumber"],
    id: json["id"],
    products: List<EoVunuvKaJXrlM7L6HbA>.from(
        json["products"].map((x) => EoVunuvKaJXrlM7L6HbA.fromJson(x))),
  );
}

Map<String, dynamic> _$ActiveRouteDataToJson(ActiveRouteData instance) =>
    <String, dynamic>{
      "createdOnDate": instance.createdOnDate,
      "stops": List<dynamic>.from(instance.stops!.map((x) => x.toJson())),
      "vendorId": instance.vendorId,
      "isActive": instance.isActive,
      "timeDuration": instance.timeDuration,
      "timeOfReaching": instance.timeOfReaching,
      "truckNumber": instance.truckNumber,
      "id": instance.id,
      "products": List<dynamic>.from(instance.products!.map((x) => x.toJson())),
    };

EoVunuvKaJXrlM7L6HbA _$EoVunuvKaJXrlM7L6HbAFromJson(Map<String, dynamic> json) {
  return EoVunuvKaJXrlM7L6HbA(
    price: json["price"],
    name: json["name"],
    backgroundColor: json["backgroundColor"],
    createdOnDate: json["createdOnDate"],
    unit: json["unit"],
    id: json["id"],
    picture: json["picture"],
    description: json["description"] == null ? null : json["description"],
  );
}

Map<String, dynamic> _$EoVunuvKaJXrlM7L6HbAToJson(
        EoVunuvKaJXrlM7L6HbA instance) =>
    <String, dynamic>{
      "price": instance.price,
      "name": instance.name,
      "backgroundColor": instance.backgroundColor,
      "createdOnDate": instance.createdOnDate,
      "unit": instance.unit,
      "id": instance.id,
      "picture": instance.picture,
      "description": instance.description == null ? null : instance.description,
    };

Stop _$StopFromJson(Map<String, dynamic> json) {
  return Stop(
    serialNo: int.parse(json["serialNo"]),
    isActive: json["isActive"],
    timeOfReaching: json["timeOfReaching"],
    createdOnDate: json["createdOnDate"],
    id: json["id"],
    location: Location.fromJson(json["location"]),
    timeDuration: json["timeDuration"],
    reachedAt: json["reachedAt"] == null ? null : json["reachedAt"],
  );
}

Map<String, dynamic> _$StopToJson(Stop instance) => <String, dynamic>{
      "serialNo": instance.serialNo,
      "isActive": instance.isActive,
      "timeOfReaching": instance.timeOfReaching,
      "createdOnDate": instance.createdOnDate,
      "id": instance.id,
      "location": instance.location!.toJson(),
      "timeDuration": instance.timeDuration,
      "reachedAt": instance.reachedAt == null ? null : instance.reachedAt,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    long: json["long"].toDouble(),
    city: json["city"],
    country: json["country"],
    hashedLocation: json["hashedLocation"],
    lat: json["lat"].toDouble(),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      "long": instance.long,
      "city": instance.city,
      "country": instance.country,
      "hashedLocation": instance.hashedLocation,
      "lat": instance.lat,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return Products(
    iv8LoVetpiCpIcl8TiwF: json["Iv8loVetpiCPIcl8tiwF"] == null
        ? null
        : The3L3I7ZcDDsnq6BsBf98M.fromJson(json["Iv8loVetpiCPIcl8tiwF"]),
    wpQuV8SSvHeJpUey2LSb: json["WpQuV8sSvHeJpUey2lSb"] == null
        ? null
        : The3L3I7ZcDDsnq6BsBf98M.fromJson(json["WpQuV8sSvHeJpUey2lSb"]),
    the3L3I7ZcDDsnq6BsBf98M: json["3l3i7ZcDDsnq6BsBF98M"] == null
        ? null
        : The3L3I7ZcDDsnq6BsBf98M.fromJson(json["3l3i7ZcDDsnq6BsBF98M"]),
    bpIgAgKz7F8Mkz7B9WjZ: json["BPIgAgKZ7f8MKZ7b9wjZ"] == null
        ? null
        : The3L3I7ZcDDsnq6BsBf98M.fromJson(json["BPIgAgKZ7f8MKZ7b9wjZ"]),
    wUlCzF1PkzqGyIcdy4SY: json["wUlCzF1PKZQGyICDY4sY"] == null
        ? null
        : The3L3I7ZcDDsnq6BsBf98M.fromJson(json["wUlCzF1PKZQGyICDY4sY"]),
    the7DkCsnu3INiN5Fk9DPoh: json["7DKCsnu3INiN5FK9dPOH"] == null
        ? null
        : The3L3I7ZcDDsnq6BsBf98M.fromJson(json["7DKCsnu3INiN5FK9dPOH"]),
    wljWq2Abc5Nu3TQ0H4OS: json["WljWQ2Abc5Nu3tQ0H4oS"] == null
        ? null
        : EoVunuvKaJXrlM7L6HbA.fromJson(json["WljWQ2Abc5Nu3tQ0H4oS"]),
    bWh2KSy8CLt9BSYzqZHv: json["bWh2KSy8cLt9bSYzqZHv"] == null
        ? null
        : EoVunuvKaJXrlM7L6HbA.fromJson(json["bWh2KSy8cLt9bSYzqZHv"]),
    rZlfzoKKeoyLTmKowNor: json["RZlfzoKKeoyLTmKowNOR"] == null
        ? null
        : EoVunuvKaJXrlM7L6HbA.fromJson(json["RZlfzoKKeoyLTmKowNOR"]),
    hlDw1No3Uh0O5UfMgFQg: json["hlDw1No3UH0o5UFMgFQg"] == null
        ? null
        : EoVunuvKaJXrlM7L6HbA.fromJson(json["hlDw1No3UH0o5UFMgFQg"]),
    mz8WneS3RtYowyi0L9Wn: json["mz8wneS3RtYOWYI0l9WN"] == null
        ? null
        : EoVunuvKaJXrlM7L6HbA.fromJson(json["mz8wneS3RtYOWYI0l9WN"]),
    eoVunuvKaJXrlM7L6HbA: json["EoVUNUVKaJXrlM7l6HbA"] == null
        ? null
        : EoVunuvKaJXrlM7L6HbA.fromJson(json["EoVUNUVKaJXrlM7l6HbA"]),
    fYByoPx0EiATwLewgJBc: json["fYByoPX0eiATwLewgJBc"] == null
        ? null
        : EoVunuvKaJXrlM7L6HbA.fromJson(json["fYByoPX0eiATwLewgJBc"]),
  );
}

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      "Iv8loVetpiCPIcl8tiwF": instance.iv8LoVetpiCpIcl8TiwF == null
          ? null
          : instance.iv8LoVetpiCpIcl8TiwF!.toJson(),
      "WpQuV8sSvHeJpUey2lSb": instance.wpQuV8SSvHeJpUey2LSb == null
          ? null
          : instance.wpQuV8SSvHeJpUey2LSb!.toJson(),
      "3l3i7ZcDDsnq6BsBF98M": instance.the3L3I7ZcDDsnq6BsBf98M == null
          ? null
          : instance.the3L3I7ZcDDsnq6BsBf98M!.toJson(),
      "BPIgAgKZ7f8MKZ7b9wjZ": instance.bpIgAgKz7F8Mkz7B9WjZ == null
          ? null
          : instance.bpIgAgKz7F8Mkz7B9WjZ!.toJson(),
      "wUlCzF1PKZQGyICDY4sY": instance.wUlCzF1PkzqGyIcdy4SY == null
          ? null
          : instance.wUlCzF1PkzqGyIcdy4SY!.toJson(),
      "7DKCsnu3INiN5FK9dPOH": instance.the7DkCsnu3INiN5Fk9DPoh == null
          ? null
          : instance.the7DkCsnu3INiN5Fk9DPoh!.toJson(),
      "WljWQ2Abc5Nu3tQ0H4oS": instance.wljWq2Abc5Nu3TQ0H4OS == null
          ? null
          : instance.wljWq2Abc5Nu3TQ0H4OS!.toJson(),
      "bWh2KSy8cLt9bSYzqZHv": instance.bWh2KSy8CLt9BSYzqZHv == null
          ? null
          : instance.bWh2KSy8CLt9BSYzqZHv!.toJson(),
      "RZlfzoKKeoyLTmKowNOR": instance.rZlfzoKKeoyLTmKowNor == null
          ? null
          : instance.rZlfzoKKeoyLTmKowNor!.toJson(),
      "hlDw1No3UH0o5UFMgFQg": instance.hlDw1No3Uh0O5UfMgFQg == null
          ? null
          : instance.hlDw1No3Uh0O5UfMgFQg!.toJson(),
      "mz8wneS3RtYOWYI0l9WN": instance.mz8WneS3RtYowyi0L9Wn == null
          ? null
          : instance.mz8WneS3RtYowyi0L9Wn!.toJson(),
      "EoVUNUVKaJXrlM7l6HbA": instance.eoVunuvKaJXrlM7L6HbA == null
          ? null
          : instance.eoVunuvKaJXrlM7L6HbA!.toJson(),
      "fYByoPX0eiATwLewgJBc": instance.fYByoPx0EiATwLewgJBc == null
          ? null
          : instance.fYByoPx0EiATwLewgJBc!.toJson(),
    };

The3L3I7ZcDDsnq6BsBf98M _$The3L3I7ZcDDsnq6BsBf98MFromJson(
    Map<String, dynamic> json) {
  return The3L3I7ZcDDsnq6BsBf98M(
    id: json["id"],
    backgroundColor: json["backgroundColor"],
    picture: json["picture"],
    createdOnDate: json["createdOnDate"],
    adminAdded: json["adminAdded"] == null ? null : json["adminAdded"],
    name: json["name"],
    unit: json["unit"],
    updatedOnDate: json["updatedOnDate"] == null ? null : json["updatedOnDate"],
    description: json["description"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
    price: json["price"],
  );
}

Map<String, dynamic> _$The3L3I7ZcDDsnq6BsBf98MToJson(
        The3L3I7ZcDDsnq6BsBf98M instance) =>
    <String, dynamic>{
      "id": instance.id,
      "backgroundColor": instance.backgroundColor,
      "picture": instance.picture,
      "createdOnDate": instance.createdOnDate,
      "adminAdded": instance.adminAdded == null ? null : instance.adminAdded,
      "name": instance.name,
      "unit": instance.unit,
      "updatedOnDate":
          instance.updatedOnDate == null ? null : instance.updatedOnDate,
      "description": instance.description,
      "createdBy": instance.createdBy == null ? null : instance.createdBy,
      "updatedBy": instance.updatedBy == null ? null : instance.updatedBy,
      "price": instance.price,
    };
