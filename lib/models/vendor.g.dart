// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorUser _$VendorUserFromJson(Map<String, dynamic> json) {
  return VendorUser(
    id: json['id'] as String?,
    fullName: json['fullName'] as String?,
    profilePicture: json['profilePicture'] as String?,
    email: json['email'] as String?,
    isEmailVerified: json['isEmailVerified'] as bool?,
    products: json['products'] as List<dynamic>?,
    address: json['address'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
  );
}

Map<String, dynamic> _$VendorUserToJson(VendorUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'address': instance.address,
      'profilePicture': instance.profilePicture,
      'phoneNumber': instance.phoneNumber,
      'isEmailVerified': instance.isEmailVerified,
      'products': instance.products,
    };
