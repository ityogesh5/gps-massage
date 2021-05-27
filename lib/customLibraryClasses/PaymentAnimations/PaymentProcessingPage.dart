import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class PaymentProcessingPage extends StatefulWidget {
  @override
  State createState() {
    return _PaymentProcessingPageState();
  }
}

class _PaymentProcessingPageState extends State<PaymentProcessingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 100),
                placeholder: AssetImage('assets/images_gps/placeholder.png'),
                image: new AssetImage(
                    'assets/images_gps/Stripe_logo_refresh.gif')),
          ),
          SizedBox(height: 60),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Processing payment .... Please Wait',
                textStyle: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            totalRepeatCount: 5,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: false,
          ),
        ],
      ),
    );
  }
} //new Image(image: new AssetImage('/assets/heaven.gif')),
