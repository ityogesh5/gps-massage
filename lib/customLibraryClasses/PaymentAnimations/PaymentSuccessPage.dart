import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class PaymentSuccessPage extends StatefulWidget {
  @override
  State createState() {
    return _PaymentSuccessPageState();
  }
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                '支払い取引が成功しました... !! ',
                textStyle: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            totalRepeatCount: 5,
            displayFullTextOnTap: true,
            stopPauseOnTap: false,
          ),
          SizedBox(height: 15),
          Center(
            child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 100),
                width: MediaQuery.of(context).size.width * 0.87,
                placeholder: AssetImage('assets/images_gps/placeholder.png'),
                image:
                    new AssetImage('assets/images_gps/SuccessfulPayment.gif')),
          ),
          SizedBox(height: 15),
          AnimatedButton(
            width: 350,
            text: 'ホームページに戻る！',
            buttonTextStyle: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            color: Colors.lime,
            pressEvent: () {
              NavigationRouter.switchToServiceUserBottomBar(context);
            },
          ),
        ],
      ),
    );
  }
} //new Image(image: new AssetImage('/assets/heaven.gif')),
