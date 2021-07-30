import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/customFavoriteButton/CustomHeartFavorite.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';

class DetailCarouselWithIndicator extends StatefulWidget {
  final TherapistByIdModel therapistDetails;
  final int id;

  DetailCarouselWithIndicator(this.therapistDetails, this.id);

  @override
  _DetailCarouselWithIndicatorState createState() =>
      _DetailCarouselWithIndicatorState();
}

class _DetailCarouselWithIndicatorState
    extends State<DetailCarouselWithIndicator> {
  List<String> bannerImages = List<String>();
  int _currentIndex = 0;
  String defaultBannerUrl =
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBanners();
  }

  getBanners() {
    if (widget.therapistDetails.data.banners[0].bannerImageUrl1 != null) {
      bannerImages.add(widget.therapistDetails.data.banners[0].bannerImageUrl1);
    }
    if (widget.therapistDetails.data.banners[0].bannerImageUrl2 != null) {
      bannerImages.add(widget.therapistDetails.data.banners[0].bannerImageUrl2);
    }
    if (widget.therapistDetails.data.banners[0].bannerImageUrl3 != null) {
      bannerImages.add(widget.therapistDetails.data.banners[0].bannerImageUrl3);
    }
    if (widget.therapistDetails.data.banners[0].bannerImageUrl4 != null) {
      bannerImages.add(widget.therapistDetails.data.banners[0].bannerImageUrl4);
    }
    if (widget.therapistDetails.data.banners[0].bannerImageUrl5 != null) {
      bannerImages.add(widget.therapistDetails.data.banners[0].bannerImageUrl5);
    }
    if (bannerImages.length == 0) {
      bannerImages.add(defaultBannerUrl);
    }
  }

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
                for (int i = 0; i < bannerImages.length; i++)
                  Container(
                    child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(40.0),
                          ),
                          child: Stack(
                            fit: StackFit.loose,
                            children: <Widget>[
                              CachedNetworkImage(
                                  width: 2000.0,
                                  height: 250.0,
                                  fit: BoxFit.fill,
                                  imageUrl: bannerImages[i].toString(),
                                  placeholder: (context, url) => SpinKitWave(
                                      color: Colors.lightBlueAccent),
                                  errorWidget: (context, url, error) {
                                    return CachedNetworkImage(
                                      width: 2000.0,
                                      fit: BoxFit.fill,
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
                  aspectRatio: 1.5,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
            ),
          ]),
        ),
        Positioned(
          top: 30.0,
          left: 20.0,
          right: 20.0,
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
                      isFavorite: widget.therapistDetails.favouriteDataResponse
                              .favouriteToTherapist ==
                          1,
                      iconSize: 40,
                      iconColor: Colors.red,
                      valueChanged: (_isFavorite) {
                        print('Is Favorite : $_isFavorite');
                        if (_isFavorite != null && _isFavorite) {
                          // call favorite therapist API
                          ServiceUserAPIProvider.favouriteTherapist(widget.id);
                        } else {
                          // call un-favorite therapist API
                          ServiceUserAPIProvider.unFavouriteTherapist(
                              widget.id);
                        }
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
              children: bannerImages.map((url) {
                int index = bannerImages.indexOf(url);
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
