import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  double ratingsValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '検索結果',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        //shrinkWrap: true,
        slivers: <Widget>[
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            // Provide a standard title.
            elevation: 0.0,
            backgroundColor: Colors.white,
            // Allows the user to reveal the app bar if they begin scrolling
            // back up the list of items.
            floating: true,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.082,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Center(child: SearchResultChips()),
              ),
            ),
            // Display a placeholder widget to visualize the shrinking size.
            // Make the initial height of the SliverAppBar larger than normal.
          ),
          // Next, create a SliverList
          SliverList(
              delegate: SliverChildListDelegate([
            GestureDetector(
              onTap: () {
                NavigationRouter
                    .switchToServiceUserBookingDetailsCompletedScreenOne(
                        context);
              },
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Container(
                      // height: MediaQuery.of(context).size.height * 0.22,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: new Card(
                        color: Colors.grey[200],
                        semanticContainer: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        new Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration:
                                            new BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                  Colors.black12),
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: new AssetImage(
                                                      'assets/images_gps/placeholder_image.png')),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '店舗名',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
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
                                                child: SvgPicture.asset(
                                                    'assets/images_gps/info.svg',
                                                    height: 15,
                                                    width: 15),
                                              ),
                                            ),
                                            Spacer(),
                                            FittedBox(
                                              child: FavoriteButton(
                                                  iconSize: 40,
                                                  iconColor: Colors.red,
                                                  valueChanged: (_isFavorite) {
                                                    print(
                                                        'Is Favorite : $_isFavorite');
                                                  }),
                                            ),
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
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.white,
                                                            Colors.white,
                                                          ]),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: Colors.grey[300],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Colors.grey[200]),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    '店舗',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.white,
                                                            Colors.white,
                                                          ]),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: Colors.grey[300],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Colors.grey[200]),
                                                  child: Text(
                                                    '出張',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.white,
                                                            Colors.white,
                                                          ]),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: Colors.grey[300],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Colors.grey[200]),
                                                  child: Text(
                                                    'コロナ対策実施',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                    ),
                                                  )),
                                            ],
                                          ),
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
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.white,
                                                            Colors.white,
                                                          ]),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: Colors.grey[300],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Colors.grey[200]),
                                                  child: Text(
                                                    '女性のみ予約可',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                    ),
                                                  )),
                                            ],
                                          ),
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
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.white,
                                                            Colors.white,
                                                          ]),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: Colors.grey[300],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Colors.grey[200]),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    'キッズスペース有',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.white,
                                                            Colors.white,
                                                          ]),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: Colors.grey[300],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Colors.grey[200]),
                                                  child: Text(
                                                    '保育士常駐',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
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
                                              "  (${ratingsValue.toString()})",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                                /* decoration: TextDecoration
                                                      .underline,*/
                                              ),
                                            ),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              ignoreGestures: true,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 25,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                size: 5,
                                                color:
                                                Color.fromRGBO(
                                                    255, 217, 0, 1),
                                              ),
                                              onRatingUpdate: (rating) {
                                                // print(rating);
                                                setState(() {
                                                  ratingsValue = rating;
                                                });
                                                print(ratingsValue);
                                              },
                                            ),
                                            Text('(1518)'),
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
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.white,
                                                          Colors.white,
                                                        ]),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                      color: Colors.grey[300],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color: Colors.grey[200]),
                                                child: Text(
                                                  '国家資格保有',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                  ),
                                                )),
                                            Spacer(),
                                            Text(
                                              '¥4,500',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19),
                                            ),
                                            Text(
                                              '/60分',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images_gps/location.svg',
                                      height: 20,
                                      width: 15),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '埼玉県浦和区高砂4丁目4',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text('1.5km圏内'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ]))
        ],
      ),
    );
  }
}

class SearchResultChips extends StatefulWidget {
  @override
  _SearchResultChipsState createState() => _SearchResultChipsState();
}

class _SearchResultChipsState extends State<SearchResultChips> {
  List<String> _options = ['料金', '距離', '評価', '施術回数'];
  int _selectedIndex;

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_options[i],
            style: TextStyle(
              color: _selectedIndex == i
                  ? Color.fromRGBO(251, 251, 251, 1)
                  : Color.fromRGBO(0, 0, 0, 1),
            )),
        backgroundColor: Colors.white70,
        selectedColor: Colors.lime,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
              print('Chip value : ${_options[_selectedIndex].toString()}');
              if (selected && i == 0) {
                HealingMatchConstants.searchServiceType = 1;
              } else if (selected && i == 1) {
                HealingMatchConstants.searchServiceType = 2;
              } else if (selected && i == 2) {
                HealingMatchConstants.searchServiceType = 3;
              } else if (selected && i == 3) {
                HealingMatchConstants.searchServiceType = 4;
              } else {
                print(
                    'Chip value else loop : ${_options[_selectedIndex].toString()}');
              }
            }
          });
          /*therapistTypeBloc.add(FetchTherapistTypeEvent(
              HealingMatchConstants.accessToken,
              HealingMatchConstants.serviceTypeValue,
              _pageNumber,
              _pageSize));*/
          print('Access token : ${HealingMatchConstants.accessToken}');
          print(
              'Search Type value : ${HealingMatchConstants.searchServiceType}');
        },
      );

      chips.add(
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 2), child: choiceChip),
      );
    }

    return ListView(
      shrinkWrap: true,
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ソ－ト',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[300],
                          fontFamily: 'NotoSansJP'),
                    ),
                    _buildChips(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

