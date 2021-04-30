import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class ProviderApprovedScreen extends StatefulWidget {
  @override
  _ProviderApprovedScreenState createState() => _ProviderApprovedScreenState();
}

class _ProviderApprovedScreenState extends State<ProviderApprovedScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: EdgeInsets.all(8.0),
        //  margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "サービス利用者からのリクエストにすでに回答した予約",
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(102, 102, 102, 1),
                  fontSize: 12.0,
                  fontFamily: 'NotoSansJP',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return buildBookingCard();
                }),
          ],
        ),
      ),
    );
  }

  Card buildBookingCard() {
    return Card(
      // margin: EdgeInsets.all(8.0),
      color: Color.fromRGBO(242, 242, 242, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'AK さん',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '(男性)',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(181, 181, 181, 1),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: EdgeInsets.all(4),
                        child: Text(
                          '店舗',
                          style: TextStyle(
                            fontSize: 9.0,
                            color: Colors.black,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/calendar.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '10月17',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      ' 月曜日 ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(102, 102, 102, 1),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/clock.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '09: 00 ~ 10: 00',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' 60分 ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(102, 102, 102, 1),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding: EdgeInsets.all(4),
                      child: Text(
                        '足つぼ',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Divider(
                        // height: 50,
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                    Expanded(
                      child: Text(''),
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/gps.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '施術をする場所',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 4.0, bottom: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text(
                          '店舗',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '埼玉県浦和区高砂4丁目4',
                      style: TextStyle(
                        color: Color.fromRGBO(102, 102, 102, 1),
                        fontSize: 17,
                      ),
                    )
                  ],
                )
              ],
            ),
            Positioned(
              top: 88.0,
              right: 10.0,
              child: InkWell(
                onTap: () {
                  NavigationRouter.switchToServiceProviderChatHistoryScreen(
                      context);
                },
                child: Card(
                  elevation: 4.0,
                  shape: CircleBorder(),
                  margin: EdgeInsets.all(0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      "assets/images_gps/providerChat.svg",
                      height: 15.0,
                      width: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
