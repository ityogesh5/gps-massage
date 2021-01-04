import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreenUser extends StatefulWidget {
  @override
  _HomeScreenUserState createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  final reservationkey = new GlobalKey<FormState>();
  final shopkey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [Text('予約')],
                          ),
                          ListTile(
                            key: reservationkey,
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[200],
                            ),
                            title: Row(
                              children: [
                                Text('お名前'),
                                Icon(Icons.ring_volume_outlined),
                                SizedBox(
                                  width: 105,
                                ),
                                Icon(
                                  Icons.access_time_sharp,
                                  color: Colors.orange,
                                ),
                                Text(
                                  '承認待ち',
                                  style: TextStyle(
                                    color: Colors.orange,
                                  ),
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
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
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
                                    Icon(Icons.timelapse),
                                    Text(
                                      '09: 00 ~ 10: 00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('(60分)')
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '¥',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      '¥4,500',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19),
                                    ),
                                    Text('(fdhgfhjgdfhjfdhj)'),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            // height: 50,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Text('fgdkgjgfjkgjkejk'),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 40,
                                child: RaisedButton(
                                  child: Text(
                                    'office',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  color: Colors.white,
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('fjkehjehjejhe')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('おすすめ'), Text('もっとみる')],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 11,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int i) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('regfhjkfdghjkfdhjfd'),
                                              SizedBox(
                                                width: 180,
                                              ),
                                              Icon(Icons.favorite),
                                            ],
                                          ),
                                          Text('kyufhjggfj'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                  /*ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3, // the length
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const ListTile(
                                  leading: FlutterLogo(size: 56.0),
                                  title: Text('Item 1'),
                                  subtitle: Text('Item 1 subtitle'),
                                  trailing: Icon(Icons.access_alarm),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
