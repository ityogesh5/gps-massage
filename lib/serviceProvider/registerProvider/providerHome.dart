import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProviderHome extends StatefulWidget {
  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    /*Container(
                      height: 30,
                      width: 30,
                      color: Colors.grey[200],
                    ),*/
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 2,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                Colors.grey[400].withOpacity(0.4),
                                child: Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.grey,
                                    size: 20
                                ),
                              ),
                              /*CircleAvatar(
                                backgroundColor: Colors.blue,
                                /*       child: Image.asset(
                              'assets/images/car.jpg',
                              fit: BoxFit.fitHeight,
                            ),*/
                              ),*/
                              title: Row(
                                children: [
                                  Text('お店名',style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(height: 10),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),
                                            child: Text(' エステ ', style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            ),)),
                                        SizedBox(width: 10,),
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),
                                            child: Text(' フィットネス ', style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            ),)),
                                        SizedBox(width: 10,),
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),
                                            child: Text(' リラクゼーション ', style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            ),)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Text(' リラクゼーション ', style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Text(' abcde ', style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Text(' fghijk ', style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Text(' lmnopqrs ', style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Text(
                                          '(3.0)',
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
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
                                          itemBuilder: (context, _) => new SizedBox(
                                              height: 18.0,
                                              width: 18.0,
                                              child: new IconButton(
                                                onPressed: (){},
                                                padding: new EdgeInsets.all(0.0),
                                                color: Colors.black,
                                                icon: new Icon(Icons.star, size: 12.0),
                                              )
                                          ),
                                              /*Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                              //size: 10.0,
                                          ),*/
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text('(1212)',style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      //color: Colors.white,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        //boxShadow: [BoxShadow(color: Colors.green, spreadRadius: 3),],
                                      ),
                                      child: Text(' tuvwxyz ',style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),)),
                                  SizedBox(height: 10),
                                  Text(' 東京都須田町丁目 ',style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(height: 10),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*Row(
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
                    )*/
                  ],
                )
              ],
            ),
          )),
    );
  }
}
