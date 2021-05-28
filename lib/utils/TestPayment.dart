import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TestPayment extends StatefulWidget {
  @override
  State createState() {
    return _TestPaymentState();
  }
}

class _TestPaymentState extends State<TestPayment> {
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret =
      "sk_test_51HyDhJHsOI5BijsXDYBipQR7TnSU0HmgygzOHQlgENKw6krlttBN6cM2N0vNBVbm9r3kEZe3pMvgW1o5D4dG5HMV00glIPUuVm"; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;
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
            "pk_test_51HyDhJHsOI5BijsX0jpyWHCKXh7nI2WsRhiQmSNSW9UcKM6Ly4AoXDGNtwTdCSmxJhcr4sp1Dbl3EAKwyvsbB8Ab00lNFx3MsS",
        //merchantId: "Your_Merchant_id",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
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
              }).catchError(setError);
            },
          ),
        ),
      ),
    );
  }
}
