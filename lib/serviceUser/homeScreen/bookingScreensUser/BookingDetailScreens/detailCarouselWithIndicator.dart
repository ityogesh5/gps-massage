import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/customFavoriteButton/CustomHeartFavorite.dart';

class DetailCarouselWithIndicator extends StatefulWidget {
  List<String> bannerImages = List<String>();
  DetailCarouselWithIndicator(this.bannerImages);
  @override
  _DetailCarouselWithIndicatorState createState() =>
      _DetailCarouselWithIndicatorState();
}

class _DetailCarouselWithIndicatorState
    extends State<DetailCarouselWithIndicator> {
  int _currentIndex = 0;
  String defaultBannerUrl =
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: Column(children: [
            CarouselSlider(
              items: <Widget>[
                for (int i = 0; i < widget.bannerImages.length; i++)
                  Container(
                    child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          child: Stack(
                            children: <Widget>[
                              CachedNetworkImage(
                                  width: 2000.0,
                                  fit: BoxFit.cover,
                                  imageUrl: widget.bannerImages[i],
                                  placeholder: (context, url) => SpinKitWave(
                                      color: Colors.lightBlueAccent),
                                  errorWidget: (context, url, error) {
                                    return CachedNetworkImage(
                                      width: 2000.0,
                                      fit: BoxFit.cover,
                                      imageUrl: defaultBannerUrl,
                                      placeholder: (context, url) =>
                                          SpinKitWave(
                                              color: Colors.lightBlueAccent),
                                    );
                                  }),
                            ],
                          )),
                    ),
                  )
              ],
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOutCubic,
                  enlargeCenterPage: false,
                  viewportFraction: 1.02,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
            ),
          ]),
        ),
        Positioned(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleAvatar(
              maxRadius: 18,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: Colors.white,
                  child: CustomFavoriteButton(
                      iconSize: 40,
                      iconColor: Colors.red,
                      valueChanged: (_isFavorite) {
                        print('Is Favorite : $_isFavorite');
                      }),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                InkWell(
                  onTap: () {
                    DialogHelper.openReportBlockUserDialog(context);
                  },
                  child: CircleAvatar(
                    maxRadius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.report_gmailerrorred_rounded,
                      color: Colors.red,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
        Positioned(
            bottom: 5.0,
            left: 50.0,
            right: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.bannerImages.map((url) {
                int index = widget.bannerImages.indexOf(url);
                return Expanded(
                  child: Container(
                    width: 45.0,
                    height: 4.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
// shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.white //Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }
}
