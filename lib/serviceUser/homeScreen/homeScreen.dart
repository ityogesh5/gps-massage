import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

class ServiceUserHomeScreen extends StatefulWidget {
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
}

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
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    autofocus: false,
                    textInputAction: TextInputAction.search,
                    decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'キーワードで検索',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search_rounded,
                              color: Colors.grey, size: 30),
                          onPressed: () {},
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        )),
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
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    'もっと見る',
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
          BuildMassageTypeChips(),
          BuildProviderLists(),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width * 0.70,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return new Card(
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width * 0.70,
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
                            Text(
                              '半径1.5km',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[400]),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'お名前',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 4),
                              CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                radius: 16,
                                child: IconButton(
                                  // remove default padding here
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.notifications_none_outlined),
                                  color: Colors.grey,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.20),
                              FavoriteButton(
                                  iconSize: 40,
                                  iconColor: Colors.red,
                                  valueChanged: (_isFavorite) {
                                    print('Is Favorite : $_isFavorite');
                                  }),
                            ],
                          ),
                        ],
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
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              autoPlay: true,
              autoPlayCurve: Curves.easeInOutCubic,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ]),
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
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    /*Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(200, 0, 0, 0),
              Color.fromARGB(0, 0, 0, 0)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 20.0),
        child: Text(
            //'No. ${imgList.indexOf(item)} image',
            ''),
      ),
    ),*/
                  ],
                )),
          ),
        ))
    .toList();

Widget showBanner() {
  int _current = 0;
  return Container(
    child: Column(children: [
      CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
            autoPlay: true,
            autoPlayCurve: Curves.easeInOutCubic,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              _current = index;
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.map((url) {
          int index = imgList.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]),
  );
}

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
        label: Text(_options[i], style: TextStyle(color: Colors.black)),
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
