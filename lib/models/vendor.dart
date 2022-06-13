import 'package:fruit_delivery_flutter/models/products_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendor.g.dart';

@JsonSerializable()
class VendorUser {
  String? id;
  String? fullName;
  String? email;
  String? address;

  String? profilePicture;
  String? phoneNumber;

  bool? isEmailVerified = false;
  List<dynamic>? products;
  // int? lastNotificationReadTime = 0;
  // bool? isPremium = false;
  // Map<String, dynamic>? package;

  VendorUser({
    this.id,
    this.fullName,
    this.profilePicture,
    this.email,
    this.isEmailVerified,
    this.products,
    this.address,
    this.phoneNumber,
    //    this.lastNotificationReadTime,
    // this.isPremium,
    // this.package,
  });

  factory VendorUser.fromJson(Map<String, dynamic> json) =>
      _$VendorUserFromJson(json);
  Map<String, dynamic> toJson() => _$VendorUserToJson(this);
}
