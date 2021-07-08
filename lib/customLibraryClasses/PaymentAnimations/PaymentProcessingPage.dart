import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';

class PaymentProcessingPage extends StatefulWidget {
  var paymentID;

  PaymentProcessingPage(this.paymentID);

  @override
  State createState() {
    return _PaymentProcessingPageState();
  }
}

class _PaymentProcessingPageState extends State<PaymentProcessingPage> {
  String _error;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _processPayment();
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        error.toString(),
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'NotoSansJP',
            color: Colors.white,
            fontWeight: FontWeight.w500),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Colors.redAccent,
    ));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                'お支払いの処理....お待ちください！',
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

  _processPayment() async {
    debugPrint('Started payment...!!');
    try {
      ServiceUserAPIProvider.chargePaymentForCustomer(
              context,
              HealingMatchConstants.serviceUserID,
              widget.paymentID,
              HealingMatchConstants.confServiceCost)
          .then((value) {
        if (value.status == 'success') {
          ServiceUserAPIProvider.paymentSuccess(
                  context, value.message.id, widget.paymentID)
              .then((value) {
            if (value.status == 'success') {
              NavigationRouter.switchToPaymentSuccessScreen(context);
            } else {
              NavigationRouter.switchToPaymentFailedScreen(context);
            }
          }).catchError((error) {
            NavigationRouter.switchToPaymentFailedScreen(context);
            setError(error);
          });
        } else {
          NavigationRouter.switchToPaymentFailedScreen(context);
        }
      }).catchError((error) {
        NavigationRouter.switchToPaymentFailedScreen(context);
        setError(error);
      }).catchError((error) {
        NavigationRouter.switchToPaymentFailedScreen(context);
        setError(error);
      });
    } catch (e) {
      NavigationRouter.switchToPaymentFailedScreen(context);
      setError(e);
    }
  }
} //new Image(image: new AssetImage('/assets/heaven.gif')),
