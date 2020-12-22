import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  color: Colors.grey[200],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    color: Colors.grey[200],
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            /*       child: Image.asset(
                              'assets/images/car.jpg',
                              fit: BoxFit.fitHeight,
                            ),*/
                          ),
                          title: Row(
                            children: [
                              Text('お店名'),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        'assets/images/car.jpg',
                                        width: 15.0,
                                        height: 15.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text('エステ'),
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        'assets/images/car.jpg',
                                        width: 15.0,
                                        height: 15.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text('フィットネス'),
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        'assets/images/car.jpg',
                                        width: 15.0,
                                        height: 15.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text('リラクゼーション'),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      color: Colors.white,
                                      child: Text('ijfv')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      color: Colors.white,
                                      child: Text('okdesu')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      color: Colors.white,
                                      child: Text('coronavirus')),
                                ],
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    Text(
                                      '4.0',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    Text('fgj5756'),
                                  ],
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.all(4),
                                  color: Colors.white,
                                  child: Text('ftdghy')),
                              Text('♪101-0041東京都須田町2丁目-25号'),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/images/car.jpg',
                                  width: 15.0,
                                  height: 15.0,
                                  fit: BoxFit.fill,
                                ),
                                Text('今週の売り上げ'),
                                Text('¥150,00'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/images/car.jpg',
                                  width: 15.0,
                                  height: 15.0,
                                  fit: BoxFit.fill,
                                ),
                                Text('今月の売り上げ'),
                                Text('¥ 500,000'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        color: Colors.white,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/images/car.jpg',
                                  width: 15.0,
                                  height: 15.0,
                                  fit: BoxFit.fill,
                                ),
                                Text('本年度の売り上げ'),
                                Text('¥10,876,68'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
