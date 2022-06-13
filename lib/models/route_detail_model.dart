import 'dart:convert';

class RouteDetailList {
  String? id;
  String? title;
  String? subtitle;
  String? mtitle;
  bool? status;
  RouteDetailList({
    this.title,
    this.subtitle,
    this.mtitle,
    this.id,
    this.status,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'mtitle': mtitle,
      'status': status,
    };
  }

  factory RouteDetailList.fromMap(Map<String, dynamic> map) {
    return RouteDetailList(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      mtitle: map['mtitle'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteDetailList.fromJson(String source) =>
      RouteDetailList.fromMap(json.decode(source));
}
