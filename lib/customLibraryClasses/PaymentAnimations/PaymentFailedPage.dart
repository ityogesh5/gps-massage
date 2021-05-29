import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/commonScreens/payment/InitiateStripePayment.dart';

class PaymentFailedPage extends StatefulWidget {
  @override
  State createState() {
    return _PaymentFailedPageState();
  }
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                '支払い取引に失敗しました... !! ',
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
                image: new AssetImage('assets/images_gps/PaymentError.gif')),
          ),
          SizedBox(height: 15),
          AnimatedButton(
            width: 350,
            text: 'もう一度やり直してください!',
            buttonTextStyle: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            color: Colors.redAccent,
            pressEvent: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => TestPayment()));
            },
          ),
        ],
      ),
    );
  }
} //new Image(image: new AssetImage('/assets/heaven.gif')),
