import 'package:flutter/material.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';

void main() => runApp(StripePaymentNewTest());

class StripePaymentNewTest extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<StripePaymentNewTest> {
  String _paymentMethodId;
  String _errorMessage = "";
  final _stripePayment = FlutterStripePayment();

  @override
  void initState() {
    super.initState();
    _stripePayment.setStripeSettings(
        "pk_test_51HwMwNBL9ibeFzEEMHOV6az31lNurmBP3cvNPqaBQASqm4LrQhfJL5NHJ8fApM8twA1oxflxWUoatPKcef7ScZHS00WzhyrZFk");

    _stripePayment.onCancel = () {
      print("the payment form was cancelled");
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stripe App Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _paymentMethodId != null
                  ? Text(
                      "Payment Method Returned is $_paymentMethodId",
                      textAlign: TextAlign.center,
                    )
                  : Container(
                      child: Text(_errorMessage),
                    ),
              RaisedButton(
                child: Text("Add Card"),
                onPressed: () async {
                  await _stripePayment
                      .addPaymentMethod()
                      .then((paymentResponse) {
                    setState(() {
                      if (paymentResponse.status ==
                          PaymentResponseStatus.succeeded) {
                        _paymentMethodId = paymentResponse.paymentMethodId;
                        debugPrint(
                            'Payment Response : ${paymentResponse.paymentMethodId}');
                      } else {
                        _errorMessage = paymentResponse.errorMessage;
                        debugPrint(
                            'Error message while payment : $_errorMessage');
                      }
                    });
                  }).catchError((error) {
                    debugPrint('Payment Eroor : $error');
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
