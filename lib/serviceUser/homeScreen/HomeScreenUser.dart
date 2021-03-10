import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
List<String> _options = [
  'エステ',
  '脱毛（女性・全身）',
  '骨盤矯正',
  'ロミロミ（全身）',
  'ホットストーン（全身）',
  'カッピング（全身）',
  'リラクゼーション'
];

int _selectedIndex;

/*class ServiceUserHomeScreen extends StatefulWidget {
  @override
  _ServiceUserHomeScreenScreenState createState() =>
      _ServiceUserHomeScreenScreenState();
}

class _ServiceUserHomeScreenScreenState extends State<ServiceUserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ヒーリングマッチ',
      debugShowCheckedModeBanner: false,
      //home: HomeScreen(),
      home: HomeScreen(),
    );
  }
}*/

class HomeScreen extends StatefulWidget {
  @override
  State createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    NavigationRouter.switchToServiceUserSearchScreen(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      readOnly: true,
                      autofocus: false,
                      textInputAction: TextInputAction.search,
                      decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'キーワードでさがす',
                          suffixIcon: InkWell(
                            child: Image.asset(
                              "assets/images_gps/search.png",
                              color: Color.fromRGBO(225, 225, 225, 1),
                            ),
                            onTap: () {
                              NavigationRouter.switchToServiceUserSearchScreen(
                                  context);
                            },
                          ),
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(225, 225, 225, 1),
                              fontSize: 14,
                              fontFamily: 'NotoSansJP'),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          CarouselWithIndicatorDemo(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '近くのセラピスト＆お店',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: ColorConstants.fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationRouter.switchToNearByProviderAndShop(context);
                    },
                    child: Text(
                      'もっとみる',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: ColorConstants.fontFamily,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BuildMassageTypeChips(),
          BuildProviderLists(),
          ReservationList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'おすすめ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: ColorConstants.fontFamily,
                  ),
                ),
                InkWell(
                  onTap: () {
                    NavigationRouter.switchToRecommended(context);
                  },
                  child: Text(
                    'もっとみる',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: ColorConstants.fontFamily,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          RecommendLists(),
          SizedBox(
            height: 75,
          ),
        ],
      ),
    );
  }
}

//Build therapists list view

class BuildProviderLists extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuildProviderListsState();
  }
}

class _BuildProviderListsState extends State<BuildProviderLists> {
  double ratingsValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width * 0.95,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return new Card(
                color: Color.fromRGBO(242, 242, 242, 1),
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.70,
                    width: MediaQuery.of(context).size.width * 0.78,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                child: SvgPicture.asset(
                                  'assets/images_gps/gpsLogo.svg',
                                  height: 30,
                                  color: Colors.lightBlueAccent,
                                ),
                                radius: 30,
                                backgroundColor: Colors.white,
                              ),
                              FittedBox(
                                child: Text(
                                  '半径1.5km',
                                  style: TextStyle(
                                    fontFamily: ColorConstants.fontFamily,
                                    fontSize: 12,
                                    color: Color.fromRGBO(153, 153, 153, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 5),
                                  Text(
                                    'お名前',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: ColorConstants.fontFamily,
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 4),
                                  InkWell(
                                    onTap: () {
                                      NavigationRouter
                                          .switchToServiceUserReservationAndFavourite(
                                              context);
                                    },
                                    child: CircleAvatar(
                                      maxRadius: 10,
                                      backgroundColor: Colors.black26,
                                      child: CircleAvatar(
                                        maxRadius: 8,
                                        backgroundColor: Colors.white,
                                        child: SvgPicture.asset(
                                            'assets/images_gps/info.svg',
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            height: 15,
                                            width: 15),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  FavoriteButton(
                                      iconSize: 40,
                                      iconColor: Colors.red,
                                      valueChanged: (_isFavorite) {
                                        print('Is Favorite : $_isFavorite');
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.white,
                                                  Colors.white,
                                                ]),
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                              color: Colors.grey[300],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: Colors.grey[200]),
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          '店舗',
                                          style: TextStyle(
                                            fontFamily:
                                                ColorConstants.fontFamily,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.white,
                                                  Colors.white,
                                                ]),
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                              color: Colors.grey[300],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: Colors.grey[200]),
                                        child: Text(
                                          '出張',
                                          style: TextStyle(
                                            fontFamily:
                                                ColorConstants.fontFamily,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.white,
                                                  Colors.white,
                                                ]),
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                              color: Colors.grey[300],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: Colors.grey[200]),
                                        child: Text(
                                          'コロナ対策実施',
                                          style: TextStyle(
                                            fontFamily:
                                                ColorConstants.fontFamily,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    ratingsValue.toString(),
                                    style: TextStyle(
                                      fontFamily: ColorConstants.fontFamily,
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 25,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      size: 5,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        ratingsValue = rating;
                                      });
                                      print(ratingsValue);
                                    },
                                  ),
                                  Text(
                                    '(1518)',
                                    style: TextStyle(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        fontFamily: ColorConstants.fontFamily),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
                                      child: Text(
                                        '国家資格保有',
                                        style: TextStyle(
                                          fontFamily: ColorConstants.fontFamily,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      )),
                                  Spacer(),
                                  Text(
                                    '¥4,500',
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: ColorConstants.fontFamily,
                                        fontSize: 19),
                                  ),
                                  Text(
                                    '/60分',
                                    style: TextStyle(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        fontFamily: ColorConstants.fontFamily),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

//Build Carousel images for banner
class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOutCubic,
                  enlargeCenterPage: false,
                  viewportFraction: 1.02,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ]),
        ),
        Positioned(
          bottom: 5.0,
          left: 50.0,
          right: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Expanded(
                child: Container(
                  width: 45.0,
                  height: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
// shape: BoxShape.circle,
                    color: _current == index
                        ? Colors.white //Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 2000.0),
                  ],
                )),
          ),
        ))
    .toList();

//Build Chips for provider massage types
class BuildMassageTypeChips extends StatefulWidget {
  @override
  _BuildMassageTypeChipsState createState() =>
      new _BuildMassageTypeChipsState();
}

class _BuildMassageTypeChipsState extends State<BuildMassageTypeChips>
    with TickerProviderStateMixin {
  Widget _buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_options[i],
            style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: ColorConstants.fontFamily)),
        backgroundColor: Colors.white70,
        selectedColor: Colors.grey[200],
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
              print('Chip value : ${_options[_selectedIndex].toString()}');
            }
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 8), child: choiceChip));
    }

    return ListView(
      physics: BouncingScrollPhysics(),
      // This next line does the trick.

      scrollDirection: Axis.horizontal,

      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                child: _buildChips(),
              ),
            ],
          )),
    );
  }
}

class ReservationList extends StatefulWidget {
  @override
  _ReservationListState createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          NavigationRouter.switchToCalendarScreen(context);
        },
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '今後の予約',
                      style: TextStyle(
                          fontFamily: ColorConstants.fontFamily,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: SvgPicture.asset(
                      'assets/images_gps/gpsLogo.svg',
                      height: 30,
                      color: Colors.lightBlueAccent,
                    ),
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                  title: Row(
                    children: [
                      Text(
                        'お名前',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: ColorConstants.fontFamily,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.black26,
                        child: CircleAvatar(
                          maxRadius: 8,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset('assets/images_gps/info.svg',
                              color: Color.fromRGBO(0, 0, 0, 1),
                              height: 15,
                              width: 15),
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset('assets/images_gps/processing.svg',
                          color: Color.fromRGBO(255, 193, 7, 1),
                          height: 17,
                          width: 15),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '承認待ち',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 193, 7, 1),
                            fontFamily: ColorConstants.fontFamily),
                      )
                    ],
                  ),

                  // trailing: Text('承認待ち'),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '4.0',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                decoration: TextDecoration.underline,
                                fontFamily: ColorConstants.fontFamily),
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              size: 5,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          Text(
                            '(1518)',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontFamily: ColorConstants.fontFamily),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/images_gps/clock.svg',
                              color: Color.fromRGBO(26, 26, 26, 1),
                              height: 15,
                              width: 15),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '09: 00 ~ 10: 00',
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.bold,
                                fontFamily: ColorConstants.fontFamily),
                          ),
                          Text(
                            '(60分)',
                            style: TextStyle(
                                color: Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: ColorConstants.fontFamily),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/images_gps/cost.svg',
                              color: Color.fromRGBO(26, 26, 26, 1),
                              height: 20,
                              width: 20),
                          Text(
                            '¥4,500',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 19,
                                fontFamily: ColorConstants.fontFamily),
                          ),
                          Text(
                            '(交通費込み - ¥1,000)',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontFamily: ColorConstants.fontFamily),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromRGBO(153, 153, 153, 1),
                  // height: 50,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/images_gps/location.svg',
                        color: Color.fromRGBO(26, 26, 26, 1),
                        height: 20,
                        width: 15),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '施術を受ける場所',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: ColorConstants.fontFamily,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200]),
                        child: Text(
                          'オフィス',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: ColorConstants.fontFamily),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '埼玉県浦和区高砂4丁目4',
                      style: TextStyle(
                          color: Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: ColorConstants.fontFamily),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecommendLists extends StatefulWidget {
  @override
  _RecommendListsState createState() => _RecommendListsState();
}

class _RecommendListsState extends State<RecommendLists> {
  var ratingValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width * 0.85,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return new Card(
              color: Color.fromRGBO(242, 242, 242, 1),
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width * 0.79,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: SvgPicture.asset(
                                'assets/images_gps/gpsLogo.svg',
                                height: 30,
                                color: Colors.lightBlueAccent,
                              ),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            FittedBox(
                              child: Text(
                                '半径1.5km',
                                style: TextStyle(
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                  fontFamily: ColorConstants.fontFamily,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'お店名',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: ColorConstants.fontFamily,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                FavoriteButton(
                                    iconSize: 40,
                                    iconColor: Colors.red,
                                    valueChanged: (_isFavorite) {
                                      print('Is Favorite : $_isFavorite');
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FittedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        '店舗',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: ColorConstants.fontFamily,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
                                      child: Text(
                                        '出張',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: ColorConstants.fontFamily,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
                                      child: Text(
                                        'コロナ対策実施',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: ColorConstants.fontFamily,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  ratingValue.toString(),
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      decoration: TextDecoration.underline,
                                      fontFamily: ColorConstants.fontFamily),
                                ),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 25,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    size: 5,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                  onRatingUpdate: (rating) {
                                    // print(rating);
                                    setState(() {
                                      ratingValue = rating;
                                    });

                                    print(ratingValue);
                                  },
                                ),
                                Text(
                                  '(1518)',
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontFamily: ColorConstants.fontFamily),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white,
                                              Colors.white,
                                            ]),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.grey[200]),
                                    child: Text(
                                      '国家資格保有',
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontFamily: ColorConstants.fontFamily,
                                      ),
                                    )),
                                Spacer(),
                                Text(
                                  '¥4,500',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: ColorConstants.fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                Text(
                                  '/60分',
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontFamily: ColorConstants.fontFamily),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
