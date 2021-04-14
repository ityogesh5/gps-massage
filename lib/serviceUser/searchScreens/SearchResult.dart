import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  double ratingsValue = 3.0;
  List<String> _options = ['料金', '距離', '評価', '施術回数'];
  int _selectedIndex;

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_options[i], style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white70,
        selectedColor: Colors.lime,
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  NavigationRouter.switchToUserSearchDetailPageOne(context);
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
                                          CircleAvatar(
                                            child: SvgPicture.asset(
                                              'assets/images_gps/gpsLogo.svg',
                                              height: 40,
                                              color: Colors.blue,
                                            ),
                                            radius: 45,
                                            backgroundColor: Colors.white,
                                          ),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    valueChanged:
                                                        (_isFavorite) {
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color:
                                                            Colors.grey[200]),
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
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color:
                                                            Colors.grey[200]),
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
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color:
                                                            Colors.grey[200]),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color:
                                                            Colors.grey[200]),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color:
                                                            Colors.grey[200]),
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
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color:
                                                            Colors.grey[200]),
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
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  size: 5,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
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
                                                style: TextStyle(
                                                    color: Colors.grey),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 50,
            left: 50,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.074,
              width: MediaQuery.of(context).size.width * 0.07,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black38,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: Container(
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
                ),
              ),
            ),
          ),
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
        label: Text(_options[i], style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white70,
        selectedColor: Colors.lime,
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
