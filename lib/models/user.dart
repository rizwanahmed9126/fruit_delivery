import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class AppUser {
  String? id;
  String? fullName;
  String? email;
  String? address;
  String? profilePicture;
  String? phoneNumber;

  bool? isEmailVerified = false;
  // int? lastNotificationReadTime = 0;
  // bool? isPremium = false;
  // Map<String, dynamic>? package;

  AppUser({
    this.id,
    this.fullName,
    this.profilePicture,
    this.email,
    this.isEmailVerified,
    this.address,
    this.phoneNumber,
    //    this.lastNotificationReadTime,
    // this.isPremium,
    // this.package,
  });
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}

/////////////////for dummy chat
class UserModel {
  String? username;
  int? userId;

  String? userMobile;
  String? profileImage;
  UserModel({this.username, this.userId, this.userMobile, this.profileImage});
}

final currentUser = UserModel(
    username: "Me",
    userMobile: '1119853265',
    userId: 9,
    profileImage:
        "https://cdn.pixabay.com/photo/2020/01/27/10/28/appetite-4796886__340.jpg");

final userList = <UserModel>[
  UserModel(
      profileImage:
          "https://cdn.pixabay.com/photo/2020/01/27/19/04/macbook-4798095__340.jpg",
      userId: 1,
      userMobile: '9876541230',
      username: 'Macron'),
  UserModel(
      profileImage:
          "https://cdn.pixabay.com/photo/2020/01/28/07/17/lamp-4799089__340.jpg",
      userId: 2,
      userMobile: '1234567890',
      username: 'Lita'),
  UserModel(
      profileImage:
          "https://cdn.pixabay.com/photo/2015/07/27/20/16/book-863418_960_720.jpg",
      userId: 4,
      userMobile: '8965236985',
      username: 'Sareen'),
  UserModel(
      profileImage:
          "https://cdn.pixabay.com/photo/2018/01/15/07/51/woman-3083383__340.jpg",
      userId: 5,
      userMobile: '6669855478',
      username: 'Worsee'),
  UserModel(
      profileImage:
          "https://cdn.pixabay.com/photo/2017/03/04/12/15/programming-2115930__340.jpg",
      userId: 6,
      userMobile: '9988998562',
      username: 'Provert'),
  UserModel(
      profileImage:
          "https://cdn.pixabay.com/photo/2015/07/10/17/24/hipster-839803__340.jpg",
      userId: 7,
      userMobile: '5544236999',
      username: 'Hipster'),
];
