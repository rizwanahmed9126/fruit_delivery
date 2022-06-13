// import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CacheImage extends StatefulWidget {
  var imageUrl;
  double? height;
  double? width;
  double? radius;
  CacheImage({this.imageUrl, this.height, this.width, this.radius});
  @override
  _CacheImageState createState() => _CacheImageState();
}

class _CacheImageState extends State<CacheImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.radius!),
        ),
        child: CachedNetworkImage(
          height: widget.height,
          width: widget.width,
          fit: BoxFit.fill,
          imageUrl: widget.imageUrl,
          placeholder: (context, url) => Center(
            child: Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.all(5),
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
          ),
          errorWidget: (context, url, error) =>
              Image.asset("assets/images/place_holder.png"),
        ));
  }
}
