import 'package:flutter/material.dart';



class NoTherapists extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NoTherapistsState();
  }

}

class _NoTherapistsState extends State<NoTherapists>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                border: Border.all(color: Color.fromRGBO(217, 217, 217, 1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'セラピストに関する情報',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NotoSansJP',
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: new Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: new BoxDecoration(
                              border: Border.all(
                                  color: Colors.black12),
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage(
                                      'assets/images_gps/appIcon.png')),
                            )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '残念ながらお近くにはラピスト・店舗の登録がまだありません。',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'NotoSansJP',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}