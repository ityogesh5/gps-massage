import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderRatingsAndReviewUser extends StatefulWidget {
  final int index;

  ProviderRatingsAndReviewUser(this.index);

  @override
  _ProviderRatingsAndReviewUserState createState() =>
      _ProviderRatingsAndReviewUserState();
}

class _ProviderRatingsAndReviewUserState
    extends State<ProviderRatingsAndReviewUser> {
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  final reviewController = new TextEditingController();
  double ratingsValue = 0.0;

  @override
  void initState() {
    super.initState();
    _scroll = new ScrollController();
    _focus.addListener(() {
      _scroll.jumpTo(-1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            NavigationRouter.switchToServiceProviderBottomBar(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          '評価とレビュー',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'AKさんについてのレビュー',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
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
                widget.index == 0
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.30,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.white, Colors.white]),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.grey[300],
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          RatingBar.builder(
                                            initialRating: 4,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 24.0,
                                            itemPadding: new EdgeInsets.only(
                                                bottom: 3.0),
                                            itemBuilder: (context, index) =>
                                                new SizedBox(
                                                    height: 20.0,
                                                    width: 20.0,
                                                    child: new IconButton(
                                                      onPressed: () {},
                                                      padding:
                                                          new EdgeInsets.all(
                                                              0.0),
                                                      color: Colors.black,
                                                      icon: index == 4
                                                          ? SvgPicture.asset(
                                                              "assets/images_gps/star_2.svg",
                                                              height: 15.0,
                                                              width: 15.0,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : SvgPicture.asset(
                                                              "assets/images_gps/star_1.svg",
                                                              height: 15.0,
                                                              width: 15.0,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      200,
                                                                      217,
                                                                      33,
                                                                      1),
                                                            ), /*  new Icon(
                                                                  Icons.star,
                                                                  size: 20.0), */
                                                    )),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Container(
                                            child: Divider(
                                                color: Colors.grey[300],
                                                height: 1)),
                                      ),
                                      SizedBox(height: 2),
                                      Expanded(
                                        flex: 1,
                                        child: SingleChildScrollView(
                                          child: TextField(
                                            controller: reviewController,
                                            scrollController: _scroll,
                                            scrollPhysics:
                                                BouncingScrollPhysics(),
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 8,
                                            autofocus: false,
                                            focusNode: _focus,
                                            decoration: new InputDecoration(
                                              filled: false,
                                              fillColor: ColorConstants
                                                  .formFieldFillColor,
                                              hintText: '良かった点、気づいた点などをご記入ください',
                                              hintStyle: TextStyle(
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 1),
                                              ),
                                              labelStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 14),
                                              focusColor: Colors.grey[100],
                                              border: HealingMatchConstants
                                                  .textFormInputBorder,
                                              focusedBorder:
                                                  HealingMatchConstants
                                                      .textFormInputBorder,
                                              disabledBorder:
                                                  HealingMatchConstants
                                                      .textFormInputBorder,
                                              enabledBorder:
                                                  HealingMatchConstants
                                                      .textFormInputBorder,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 60),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          NavigationRouter
                                              .switchToProviderReviewScreenSent(
                                                  context);
                                        },
                                        child: Card(
                                          shape: CircleBorder(
                                              side: BorderSide(
                                                  color: Color.fromRGBO(
                                                      216, 216, 216, 1))),
                                          elevation: 8.0,
                                          margin: EdgeInsets.all(4.0),
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                              child: SvgPicture.asset(
                                                "assets/images_gps/sending.svg",
                                                height: 25.0,
                                                width: 25.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(10.0),
                        color: Color.fromRGBO(242, 242, 242, 1),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
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
                                    itemPadding:
                                        new EdgeInsets.only(bottom: 3.0),
                                    itemBuilder: (context, index) =>
                                        new SizedBox(
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
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
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
                                        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color.fromRGBO(51, 51, 51, 1),
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(height: 10),
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
                        ],
                      );
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
