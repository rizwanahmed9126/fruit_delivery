import 'dart:convert';

import 'package:fruit_delivery_flutter/screens/trip_detail_screen.dart';

class TimelineModel {
  String? personName;
  String? rider;
  String? personAvatar;
  String? location;
  String? time;
  String? date;
  String? stop;
  timeLine? status;
  TimelineModel({
    this.rider,
    this.personAvatar,
    this.personName,
    this.location,
    this.time,
    this.date,
    this.stop,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'personName': personName,
      'rider': rider,
      'personAvatar': personAvatar,
      'location': location,
      'time': time,
      'date': date,
      'stop': stop,
      'status': status,
    };
  }

  factory TimelineModel.fromMap(Map<String, dynamic> map) {
    return TimelineModel(
      personName: map['personName'],
      rider: map['rider'],
      personAvatar: map['personAvatar'],
      location: map['location'],
      time: map['time'],
      date: map['date'],
      stop: map['stop'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TimelineModel.fromJson(String source) => TimelineModel.fromMap(json.decode(source));
}
