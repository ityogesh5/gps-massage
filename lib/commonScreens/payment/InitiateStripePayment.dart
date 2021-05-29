import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TestPayment extends StatefulWidget {
  @override
  State createState() {
    return _TestPaymentState();
  }
}

class _TestPaymentState extends State<TestPayment> {
  Token paymentToken;
  PaymentMethod _paymentMethod;
  String error;
  final String currentSecret =
      "sk_test_51HyDhJHsOI5BijsXDYBipQR7TnSU0HmgygzOHQlgENKw6krlttBN6cM2N0vNBVbm9r3kEZe3pMvgW1o5D4dG5HMV00glIPUuVm"; //set this yourself, e.g using curl
  PaymentIntentResult paymentIntent;
  Source source;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final CreditCard testCard = CreditCard(
    number: '4111111111111111',
    expMonth: 08,
    expYear: 22,
  );

  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "${HealingMatchConstants.CLIENT_PUBLISHABLE_KEY_STRIPE}",
        //merchantId: "Your_Merchant_id",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Create Token with Card Form"),
            onPressed: () {
              StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
                  .then((paymentMethod) {
                setState(() {
                  _paymentMethod = paymentMethod;
                  print('Received payment method : ${_paymentMethod.toJson()}');
                  print('Received payment method ID : ${_paymentMethod.id}');
                });
                Future.delayed(Duration(seconds: 2), () {});
                _createCustomer(_paymentMethod);
              }).catchError(setError);
            },
          ),
        ),
      ),
    );
  }

  _createCustomer(PaymentMethod paymentMethod) async {
    NavigationRouter.switchToPaymentProcessingScreen(context, _paymentMethod);
  }
}
