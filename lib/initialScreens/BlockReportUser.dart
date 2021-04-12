import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BlockReportUser extends StatefulWidget {
  String userImage;

  BlockReportUser({this.userImage});

  @override
  State createState() {
    return _BlockReportUserState();
  }
}

class _BlockReportUserState extends State<BlockReportUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context, true);
              }),
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: Center(
          child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Color.fromRGBO(243, 249, 250, 1),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 15.0, // soften the shadow
                    spreadRadius: 5, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      10.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              height: MediaQuery.of(context).size.width * 0.85,
              width: MediaQuery.of(context).size.width * 0.85,
              duration: Duration(seconds: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: (CachedNetworkImage(
                  imageUrl:
                      'https://www.google.co.in/search?q=flutter&hl=en&authuser=0&tbm=isch&sxsrf=ALeKk03cQn6rfBxgsD5t8qcH7B_2bVUyOA%3A1617281038064&source=hp&biw=1366&bih=626&ei=DsBlYN-3AcLprQHTsr8Y&oq=flutter&gs_lcp=CgNpbWcQAzIFCAAQsQMyBQgAELEDMgUIABCxAzICCAAyBQgAELEDMgIIADICCAAyAggAMgIIADICCABQnAlYlhFgohRoAHAAeACAAeoCiAGXDZIBBzAuMi4zLjKYAQCgAQGqAQtnd3Mtd2l6LWltZ7ABAA&sclient=img&ved=0ahUKEwjf9peuid3vAhXCdCsKHVPZDwMQ4dUDCAY&uact=5#imgrc=YZZYhkxsmxzvYM',
                  filterQuality: FilterQuality.high,
                  fadeInCurve: Curves.easeInSine,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) =>
                      SpinKitDoubleBounce(color: Colors.lightGreenAccent),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images_gps/user.png'),
                )),
              )),
        ));
  }
}
