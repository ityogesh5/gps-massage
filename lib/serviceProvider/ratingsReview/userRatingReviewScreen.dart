import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserRatingReviewScreen extends StatefulWidget {
  @override
  _UserRatingReviewScreenState createState() => _UserRatingReviewScreenState();
}

class _UserRatingReviewScreenState extends State<UserRatingReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            padding:
                EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          '評価とレビュー',
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Row(
                  children: [
                    Text(
                      'AKさんについてのレビュー',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '(152 レビュー)',
                      style: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                      //color: Color.fromRGBO(251, 251, 251, 1),
                      ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'お名前',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '10月７',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
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
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 24.0,
                              itemPadding: new EdgeInsets.only(bottom: 3.0),
                              itemBuilder: (context, index) => new SizedBox(
                                  height: 20.0,
                                  width: 18.0,
                                  child: new IconButton(
                                    onPressed: () {},
                                    padding: new EdgeInsets.all(0.0),
                                    color: Colors.black,
                                    icon: index == 4
                                        ? SvgPicture.asset(
                                            "assets/images_gps/star_2.svg",
                                            height: 13.0,
                                            width: 13.0,
                                            color: Colors.black,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images_gps/star_1.svg",
                                            height: 13.0,
                                            width: 13.0,
                                            color: Colors.black,
                                          ), /*  new Icon(
                                                                Icons.star,
                                                                size: 20.0), */
                                  )),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(width: 5),
                            Text(
                              "(4.0)",
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      offset: Offset(0, 3))
                                ],
                                fontSize: 14.0,
                                color: Colors.transparent,
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
                                      fontSize: 12,
                                      color: Color.fromRGBO(51, 51, 51, 1),
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*  SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                              child:
                                  Divider(color: Colors.grey[300], height: 1)),
                        ), */
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
