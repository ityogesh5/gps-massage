import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayUserReview extends StatefulWidget {
  @override
  _DisplayUserReviewState createState() => _DisplayUserReviewState();
}

class _DisplayUserReviewState extends State<DisplayUserReview> {
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  final reviewController = new TextEditingController();
  double ratingsValue = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          '評価とレビュー',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'NotoSansJP'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '店舗についてのレビュー',
                          style: TextStyle(
                              fontFamily: 'NotoSansJP',
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '（052レビュー）',
                          style: TextStyle(
                              fontFamily: 'NotoSansJP',
                              fontSize: 12,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.20,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.grey[400], Colors.grey[400]]),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.grey[300],
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white54),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    unratedColor: Colors.grey[200],
                                    glow: true,
                                    glowColor: Colors.lime,
                                    glowRadius: 2,
                                    initialRating: 2,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      size: 5,
                                      color: Colors.black,
                                    ),
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                      setState(() {
                                        ratingsValue = rating;
                                      });
                                      print(ratingsValue);
                                    },
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    ratingsValue.toString(),
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                                    "when an unknown printer took a galley of type and scrambled "
                                    "it to make a type specimen book when an unknown printer took a galley of type and scrambled  when an unknown printer took a galley of type and scrambled .",
                                    style: TextStyle(
                                        fontFamily: 'NotoSansJP',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return new Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'お名前',
                                    style: TextStyle(
                                        fontFamily: 'NotoSansJP',
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '10月７',
                                    style: TextStyle(
                                        fontFamily: 'NotoSansJP',
                                        fontSize: 12,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBar.builder(
                                  unratedColor: Colors.grey[200],
                                  glow: true,
                                  glowColor: Colors.lime,
                                  glowRadius: 2,
                                  initialRating: 2,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    size: 5,
                                    color: Colors.black,
                                  ),
                                  onRatingUpdate: (rating) {
                                    // print(rating);
                                    setState(() {
                                      ratingsValue = rating;
                                    });
                                    print(ratingsValue);
                                  },
                                ),
                                SizedBox(width: 5),
                                Text(
                                  ratingsValue.toString(),
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                                      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                                      "when an unknown printer took a galley of type and scrambled it to make a type specimen book when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                      style: TextStyle(
                                          fontFamily: 'NotoSansJP',
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                  child: Divider(
                                      color: Colors.grey[300], height: 1)),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
