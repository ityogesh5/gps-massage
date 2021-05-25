import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

// Loader HomePage
class LoadShimmerExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadInitialHomePageState();
  }
}

class _LoadInitialHomePageState extends State<LoadShimmerExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(height: 20),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(children: [
                  Shimmer(
                    duration: Duration(milliseconds: 300),
                    //Default value
                    interval: Duration(milliseconds: 300),
                    //Default value: Duration(seconds: 0)
                    color: Colors.grey[300],
                    //Default value
                    enabled: true,
                    //Default value
                    direction: ShimmerDirection.fromLeftToRight(),
                    child: CarouselSlider(
                      items: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: new BoxDecoration(
                                    border:
                                        Border.all(color: Colors.transparent),
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.none,
                                        image: new AssetImage(
                                            'assets/images_gps/logo.png')),
                                  )),
                              Text(
                                'Healing match',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        )
                      ],
                      options: CarouselOptions(
                          autoPlay: false,
                          autoPlayCurve: Curves.easeInOutCubic,
                          enlargeCenterPage: false,
                          viewportFraction: 0.9,
                          aspectRatio: 2.0),
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer(
              duration: Duration(milliseconds: 300),
              //Default value
              interval: Duration(milliseconds: 300),
              //Default value: Duration(seconds: 0)
              color: Colors.grey[400],
              //Default value
              enabled: true,
              //Default value
              direction: ShimmerDirection.fromLTRB(),
              child: Container(
                color: Colors.grey[200],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Shimmer(
            duration: Duration(milliseconds: 300),
            //Default value
            interval: Duration(milliseconds: 300),
            //Default value: Duration(seconds: 0)
            color: Colors.grey[300],
            //Default value
            enabled: true,
            //Default value
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Card(elevation: 5),
            ),
          ),
          Shimmer(
            duration: Duration(milliseconds: 300),
            //Default value
            interval: Duration(milliseconds: 300),
            //Default value: Duration(seconds: 0)
            color: Colors.grey[400],
            //Default value
            enabled: true,
            //Default value
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Shimmer(
                duration: Duration(milliseconds: 300),
                //Default value
                interval: Duration(milliseconds: 300),
                //Default value: Duration(seconds: 0)
                color: Colors.grey[300],
                //Default value
                enabled: true,
                //Default value
                direction: ShimmerDirection.fromLTRB(),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return WidgetAnimator(
                        new Card(
                          color: Colors.grey[200],
                          semanticContainer: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.70,
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: Shimmer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.grey[200],
                                          border: Border.all(
                                              color: Colors.grey[200]),
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.none,
                                              image: new AssetImage(
                                                  'assets/images_gps/logo.png')),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer(
            duration: Duration(milliseconds: 300),
            //Default value
            interval: Duration(milliseconds: 300),
            //Default value: Duration(seconds: 0)
            color: Colors.grey[400],
            //Default value
            enabled: true,
            //Default value
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Shimmer(
                duration: Duration(milliseconds: 300),
                //Default value
                interval: Duration(milliseconds: 300),
                //Default value: Duration(seconds: 0)
                color: Colors.grey[300],
                //Default value
                enabled: true,
                //Default value
                direction: ShimmerDirection.fromLTRB(),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return WidgetAnimator(
                        new Card(
                          color: Colors.grey[200],
                          semanticContainer: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.70,
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: Shimmer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.grey[200],
                                          border: Border.all(
                                              color: Colors.grey[200]),
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.none,
                                              image: new AssetImage(
                                                  'assets/images_gps/logo.png')),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer(
            duration: Duration(milliseconds: 300),
            //Default value
            interval: Duration(milliseconds: 300),
            //Default value: Duration(seconds: 0)
            color: Colors.grey[400],
            //Default value
            enabled: true,
            //Default value
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
