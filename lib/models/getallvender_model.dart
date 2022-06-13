
import 'package:json_annotation/json_annotation.dart';
part 'getallvender_model.g.dart';

@JsonSerializable()
class  GetVendor {

  GetVendor({ this.id,
        this.fullName,
        this.lat,
        this.long,
        this.products,
        this.createdOnDate,
        this.loginSource,
        this.age,
        this.todayRoutes,
        this.currentSpot,
        this.isActive,
        this.activeRoute,
        this.isApproved,
        this.isBlocked,
        this.isChatBlocked,
        this.email,
        this.phoneNumber,
        this.address,
        this.role,
        this.isEmailVerified,
        this.profilePicture,
        this.gender,
        });

  String? id;
    String? fullName;
    int? lat;
    int? long;
    Products? products;
    int? createdOnDate;
    String? loginSource;
    int? age;
    List<dynamic>? todayRoutes;
    String? currentSpot;
    bool? isActive;
    ActiveRoute? activeRoute;
    bool? isApproved;
    bool? isBlocked;
    bool? isChatBlocked;
    String? email;
    String? phoneNumber;
    String? address;
    String? role;
    bool? isEmailVerified;
    String? profilePicture;
    String? gender;

  factory GetVendor.fromJson(Map<String, dynamic> json) =>
      _$GetVendorFromJson(json);
  Map<String, dynamic> toJson() => _$GetVendorToJson(this);
}

class ActiveRoute {
    ActiveRoute({
        this.isServerError,
        this.isSuccess,
        this.message,
        this.data,
        this.truckNumber,
        this.vendorId,
        this.id,
        this.timeDuration,
        this.createdOnDate,
        this.stops,
        this.timeOfReaching,
        this.isActive,
        this.products,
    });

    bool? isServerError;
    bool? isSuccess;
    String? message;
    ActiveRouteData? data;
    String? truckNumber;
    String? vendorId;
    String? id;
    String? timeDuration;
    int? createdOnDate;
    List<Stop>? stops;
    String? timeOfReaching;
    bool? isActive;
    List<EoVunuvKaJXrlM7L6HbA>? products;

    factory ActiveRoute.fromJson(Map<String, dynamic> json) =>
      _$ActiveRouteFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveRouteToJson(this);

}
class ActiveRouteData {
    ActiveRouteData({
        this.createdOnDate,
        this.stops,
        this.vendorId,
        this.isActive,
        this.timeDuration,
        this.timeOfReaching,
        this.truckNumber,
        this.id,
        this.products,
    });

    int? createdOnDate;
    List<Stop>? stops;
    String? vendorId;
    bool? isActive;
    String? timeDuration;
    String? timeOfReaching;
    String? truckNumber;
    String? id;
    List<EoVunuvKaJXrlM7L6HbA>? products;

    factory ActiveRouteData.fromJson(Map<String, dynamic> json) =>
      _$ActiveRouteDataFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveRouteDataToJson(this);
}

class EoVunuvKaJXrlM7L6HbA {
    EoVunuvKaJXrlM7L6HbA({
        this.price,
        this.name,
        this.backgroundColor,
        this.createdOnDate,
        this.unit,
        this.id,
        this.picture,
        this.description,
    });

    String? price;
    String? name;
    String? backgroundColor;
    int? createdOnDate;
    String? unit;
    String? id;
    String? picture;
    String? description;

      factory EoVunuvKaJXrlM7L6HbA.fromJson(Map<String, dynamic> json) =>
      _$EoVunuvKaJXrlM7L6HbAFromJson(json);
  Map<String, dynamic> toJson() => _$EoVunuvKaJXrlM7L6HbAToJson(this);
}

class Stop {
    Stop({
        this.serialNo,
        this.isActive,
        this.timeOfReaching,
        this.createdOnDate,
        this.id,
        this.location,
        this.timeDuration,
        this.reachedAt,
    });

    int? serialNo;
    bool? isActive;
    String? timeOfReaching;
    int? createdOnDate;
    String? id;
    Location? location;
    String? timeDuration;
    int? reachedAt;

    factory Stop.fromJson(Map<String, dynamic> json) =>
      _$StopFromJson(json);
  Map<String, dynamic> toJson() => _$StopToJson(this);
}

class Location {
    Location({
        this.long,
        this.city,
        this.country,
        this.hashedLocation,
        this.lat,
    });

    double? long;
    String? city;
    String? country;
    String? hashedLocation;
    double? lat;

    factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
class Products {
    Products({
        this.iv8LoVetpiCpIcl8TiwF,
        this.wpQuV8SSvHeJpUey2LSb,
        this.the3L3I7ZcDDsnq6BsBf98M,
        this.bpIgAgKz7F8Mkz7B9WjZ,
        this.wUlCzF1PkzqGyIcdy4SY,
        this.the7DkCsnu3INiN5Fk9DPoh,
        this.wljWq2Abc5Nu3TQ0H4OS,
        this.bWh2KSy8CLt9BSYzqZHv,
        this.rZlfzoKKeoyLTmKowNor,
        this.hlDw1No3Uh0O5UfMgFQg,
        this.mz8WneS3RtYowyi0L9Wn,
        this.eoVunuvKaJXrlM7L6HbA,
        this.fYByoPx0EiATwLewgJBc,
    });

    The3L3I7ZcDDsnq6BsBf98M? iv8LoVetpiCpIcl8TiwF;
    The3L3I7ZcDDsnq6BsBf98M? wpQuV8SSvHeJpUey2LSb;
    The3L3I7ZcDDsnq6BsBf98M? the3L3I7ZcDDsnq6BsBf98M;
    The3L3I7ZcDDsnq6BsBf98M? bpIgAgKz7F8Mkz7B9WjZ;
    The3L3I7ZcDDsnq6BsBf98M? wUlCzF1PkzqGyIcdy4SY;
    The3L3I7ZcDDsnq6BsBf98M? the7DkCsnu3INiN5Fk9DPoh;
    EoVunuvKaJXrlM7L6HbA? wljWq2Abc5Nu3TQ0H4OS;
    EoVunuvKaJXrlM7L6HbA? bWh2KSy8CLt9BSYzqZHv;
    EoVunuvKaJXrlM7L6HbA? rZlfzoKKeoyLTmKowNor;
    EoVunuvKaJXrlM7L6HbA? hlDw1No3Uh0O5UfMgFQg;
    EoVunuvKaJXrlM7L6HbA? mz8WneS3RtYowyi0L9Wn;
    EoVunuvKaJXrlM7L6HbA? eoVunuvKaJXrlM7L6HbA;
    EoVunuvKaJXrlM7L6HbA? fYByoPx0EiATwLewgJBc;

     factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}
class The3L3I7ZcDDsnq6BsBf98M {
    The3L3I7ZcDDsnq6BsBf98M({
        this.id,
        this.backgroundColor,
        this.picture,
        this.createdOnDate,
        this.adminAdded,
        this.name,
        this.unit,
        this.updatedOnDate,
        this.description,
        this.createdBy,
        this.updatedBy,
        this.price,
    });

    String? id;
    String? backgroundColor;
    String? picture;
    int? createdOnDate;
    bool? adminAdded;
    String? name;
    String? unit;
    int? updatedOnDate;
    String? description;
    String? createdBy;
    String? updatedBy;
    String? price;
    
    factory The3L3I7ZcDDsnq6BsBf98M.fromJson(Map<String, dynamic> json) =>
      _$The3L3I7ZcDDsnq6BsBf98MFromJson(json);
  Map<String, dynamic> toJson() => _$The3L3I7ZcDDsnq6BsBf98MToJson(this);
}