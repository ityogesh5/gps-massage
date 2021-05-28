import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    @required this.imageUrl,
    this.radius = 15,
    Key key,
    this.color,
  }) : super(key: key);

  final String imageUrl;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color ?? Colors.white,
      backgroundImage: imageUrl == null || imageUrl == ''
          ? null
          : CachedNetworkImageProvider(imageUrl),
      child: imageUrl == null || imageUrl == ''
          ? Image.asset(
              'assets/images_gps/placeholder_image.png',
              width: 50.0,
              height: 60.0,
              color: Colors.black,
              fit: BoxFit.cover,
            )
          : null,
      radius: radius,
    );
  }
}
