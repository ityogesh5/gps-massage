import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    @required this.imageUrl,
    @required this.isOnline,
    this.radius = 15,
    Key key,
    this.color,
  }) : super(key: key);

  final String imageUrl;
  final bool isOnline;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        CircleAvatar(
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
        ),
        Visibility(
          visible: isOnline,
          child: Positioned(
            right: -20.0,
            top: 35,
            left: 10.0,
            child: InkWell(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 7,
                child: CircleAvatar(
                  backgroundColor: Colors.green[400],
                  radius: 5,
                  child: Container(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
