import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class UserDefineScreen extends StatefulWidget {
  @override
  _UserDefineScreenState createState() => _UserDefineScreenState();
}

class _UserDefineScreenState extends State<UserDefineScreen> {
  bool passwordVisibility = true;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final phoneNumberController = new TextEditingController();
  final passwordController = new TextEditingController();
  Size size;
  int state = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (state == 0) {
        state = 1;
        size = MediaQuery.of(context).size;
        showUserDefineDialog();
      }
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      // bottomNavigationBar: buildBottomBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: new AssetImage('assets/images_gps/user_define.png'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildBottomBar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Text(
            HealingMatchConstants.loginServiceProvider,
            style: TextStyle(color: Colors.grey, fontFamily: 'NotoSansJP'
//                            decoration: TextDecoration.underline,
                ),
          ),
        ),
      ),
    );
  }

  showUserDefineDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 16,
            child: Stack(
              children: [
                Container(
                  //height: 300.0,
                  //width: 450.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            HealingMatchConstants.UserSelectFirtTxt,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("User onTapped");
                                      NavigationRouter
                                          .switchToUserInitialTutorialScreen(
                                              context);
                                    },
                                    child: Image.asset(
                                      'assets/images_gps/user_image.png',
                                      height: 150.0,
                                      //width: 150.0,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("Provider onTapped");
                                      NavigationRouter
                                          .switchToProviderInitialTutorialScreen(
                                              context);
                                    },
                                    child: Image.asset(
                                      'assets/images_gps/Provider_image.png',
                                      height: 150.0,
                                      //width: 150.0,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: size.width * 0.9,
                          child: Text(
                            HealingMatchConstants.UserSelectLastTxt,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 40,
                  left: 27,
                  child: Text(
                    'サービス利用者',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 41,
                  child: Text(
                    'セラピスト',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
