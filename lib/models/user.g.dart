// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return AppUser(
    id: json['id'] as String?,
    fullName: json['fullName'] as String?,
    profilePicture: json['profilePicture'] as String?,
    email: json['email'] as String?,
    isEmailVerified: json['isEmailVerified'] as bool?,
    address: json['address'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
  );
}

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'address': instance.address,
      'profilePicture': instance.profilePicture,
      'phoneNumber': instance.phoneNumber,
      'isEmailVerified': instance.isEmailVerified,
    };
