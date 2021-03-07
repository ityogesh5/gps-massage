import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          separatorBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: index == 0 || index == 1
                      ? Color.fromRGBO(251, 251, 251, 1)
                      : Colors.white,
                  border: Border(
                    left: BorderSide(
                      color: index == 0 || index == 1
                          ? Color.fromRGBO(200, 217, 33, 1)
                          : Colors.white,
                      width: 6,
                    ),
                  ),
                  //  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Divider(
                    //color: Color.fromRGBO(251, 251, 251, 1),
                    ),
              ),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return buildNotificationCard(index);
          }),
    );
  }

  buildNotificationCard(int index) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
      decoration: BoxDecoration(
        color: index == 0 || index == 1
            ? Color.fromRGBO(251, 251, 251, 1)
            : Colors.white,
        border: Border(
          left: BorderSide(
            color: index == 0 || index == 1
                ? Color.fromRGBO(200, 217, 33, 1)
                : Colors.white,
            width: 6,
          ),
        ),
        //  borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              NavigationRouter.switchToReceiveBookingScreen(context);
            } else if (index == 1) {
              NavigationRouter.switchToOfferCancelScreen(context);
            } else if (index == 2) {
              NavigationRouter.switchToOfferConfirmedScreen(context);
            } else if (index == 3) {
              NavigationRouter.switchToOfferCancelScreenTimerUser(context);
            } else if (index == 4) {
              NavigationRouter.switchToAdminNotificationScreen(context);
            }
          },
          child: Row(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipOval(
                      child: CircleAvatar(
                        radius: 28.0,
                        backgroundColor: Colors.white,
                        child: Image.network(
                          HealingMatchConstants.userData.uploadProfileImgUrl,
                          //User Profile Pic
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Center(
                    child: Text(
                      '9時',
                      style: TextStyle(
                        color: Color.fromRGBO(153, 153, 153, 1),
                        fontSize: 10.0,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
              index == 4
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '管理者',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Lorem ipsumidolor sit amet, consetetur sadi usang\nelit, sed dia nonumy eiod tempor irviduntul labore...',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images_gps/cost.svg",
                              height: 14.77,
                              width: 16.0,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '¥5,000',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '(paid)',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        index == 3
                            ? Text(
                                '設定した希望時間が締め切れましたので、AKさんのご\n予約は自動的にキャンセルされました。',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    'AK さん',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  index == 0
                                      ? Text(
                                          'からご予約依頼がありました。',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                          ),
                                        )
                                      : index == 1
                                          ? Text(
                                              'がご予約をキャンセルしました。',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                              ),
                                            )
                                          : Text(
                                              'はご予約を確定しました。',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                              ),
                                            ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 8,
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
                          height: 8,
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
                                  color: Color.fromRGBO(242, 242, 242, 1),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
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
                      ],
                    ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Color.fromRGBO(242, 242, 242, 1),
                size: 20.0,
              ),
              /*   Center(
                child: IconButton(
                  onPressed: () {
                    if (index == 0) {
                      NavigationRouter.switchToReceiveBookingScreen(context);
                    } else if (index == 1) {
                      NavigationRouter.switchToOfferCancelScreen(context);
                    } else if (index == 2) {
                      NavigationRouter.switchToOfferConfirmedScreen(context);
                    } else if (index == 3) {
                      NavigationRouter.switchToOfferCancelScreenTimerUser(
                          context);
                    } else if (index == 4) {
                      NavigationRouter.switchToOfferCancelScreenTimerUser(
                          context);
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                  color: Color.fromRGBO(242, 242, 242, 1),
                  iconSize: 20.0,
                ),
              ) */
            ],
          ),
        ),
      ),
    );
  }
}
