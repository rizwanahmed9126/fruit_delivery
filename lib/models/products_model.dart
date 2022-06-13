import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';

@JsonSerializable()
class Products {
  String? id;
  String? name;
  String? price;
  String? unit;
  int? createdOnDate;
  String? picture;
  String? backgroundColor;
  String? description;
  
  

  Products(
      {this.id,
      this.name,
      this.picture,
      this.price,
      this.unit,
      this.createdOnDate,
      this.backgroundColor,
      this.description});

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}
