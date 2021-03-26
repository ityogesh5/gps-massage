import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerExampleLoader extends StatefulWidget {
  @override
  State createState() => _LoadingHomeScreenState();
}

class _LoadingHomeScreenState extends State<ShimmerExampleLoader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width * 0.85,
      child: new Card(
        elevation: 0.0,
        color: Colors.grey[100],
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Shimmer(
                      duration: Duration(seconds: 1),
                      //Default value
                      interval: Duration(seconds: 2),
                      //Default value: Duration(seconds: 0)
                      color: Colors.grey[300],
                      //Default value
                      enabled: true,
                      //Default value
                      direction: ShimmerDirection.fromLeftToRight(),
                      child: new Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: new BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            shape: BoxShape.circle,
                          )),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Shimmer(
                      duration: Duration(seconds: 1),
                      //Default value
                      interval: Duration(seconds: 2),
                      //Default value: Duration(seconds: 0)
                      color: Colors.grey[300],
                      //Default value
                      enabled: true,
                      //Default value
                      direction: ShimmerDirection.fromLeftToRight(),
                      child: Row(
                        children: [

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: true,
                            child: Container(
                                padding: EdgeInsets.all(4)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Visibility(
                            visible: true,
                            child: Container(
                                padding: EdgeInsets.all(4)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Visibility(
                            visible: true,
                            child: Container(
                                padding: EdgeInsets.all(4)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Shimmer(
                          duration: Duration(seconds: 1),
                          //Default value
                          interval: Duration(seconds: 2),
                          //Default value: Duration(seconds: 0)
                          color: Colors.grey[300],
                          //Default value
                          enabled: true,
                          //Default value
                          direction: ShimmerDirection.fromLeftToRight(),
                          child: RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              size: 5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(''),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Shimmer(
                      duration: Duration(seconds: 1),
                      //Default value
                      interval: Duration(seconds: 2),
                      //Default value: Duration(seconds: 0)
                      color: Colors.grey[300],
                      //Default value
                      enabled: true,
                      //Default value
                      direction: ShimmerDirection.fromLeftToRight(),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(4)),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
