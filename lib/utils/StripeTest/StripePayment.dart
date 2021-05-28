import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripePaymentTest extends StatefulWidget {
  @override
  _PaymentState createState() => new _PaymentState();
}

class _PaymentState extends State<StripePaymentTest> {
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret =
      "sk_test_51HyDhJHsOI5BijsXDYBipQR7TnSU0HmgygzOHQlgENKw6krlttBN6cM2N0vNBVbm9r3kEZe3pMvgW1o5D4dG5HMV00glIPUuVm"; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  ScrollController _controller = ScrollController();

  final CreditCard testCard = CreditCard(
    number: '4111111111111111',
    expMonth: 08,
    expYear: 22,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51HwMwNBL9ibeFzEEMHOV6az31lNurmBP3cvNPqaBQASqm4LrQhfJL5NHJ8fApM8twA1oxflxWUoatPKcef7ScZHS00WzhyrZFk",
        //merchantId: "Your_Merchant_id",
        androidPayMode: 'test'));

    /*String t = '50,0,0,00';
    var f = int.parse(t.replaceAll(',', ''));
    print('wo comma value : ${f.truncate()}');*/
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
      backgroundColor: Colors.grey[800],
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(
          'Stripe Payment Demo',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _source = null;
                _paymentIntent = null;
                _paymentMethod = null;
                _paymentToken = null;
              });
            },
          )
        ],
      ),
      body: ListView(
        controller: _controller,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          RaisedButton(
            child: Text("Create Source"),
            onPressed: () {
              StripePayment.createSourceWithParams(SourceParams(
                type: 'ideal',
                amount: 2102,
                currency: 'eur',
                returnURL: 'example://stripe-redirect',
              )).then((source) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Received Source : ${source.toJson()}')));
                setState(() {
                  _source = source;
                  print('Received Source : ${_source.toJson()}');
                });
              }).catchError(setError);
            },
          ),
          Divider(),
          RaisedButton(
            child: Text("Create Token with Card Form"),
            onPressed: () {
              StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
                  .then((paymentMethod) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Received ${paymentMethod.toJson()}')));
                setState(() {
                  _paymentMethod = paymentMethod;
                  print('Received payment method : ${_paymentMethod.toJson()}');
                });
              }).catchError(setError);
            },
          ),
          RaisedButton(
            child: Text("Create Token with Card"),
            onPressed: () {
              StripePayment.createTokenWithCard(
                testCard,
              ).then((token) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Received tokenID : ${token.toJson()}')));
                setState(() {
                  _paymentToken = token;
                  print('Received payment token : ${_paymentToken.toJson()}');
                });
              }).catchError(setError);
            },
          ),
          Divider(),
          RaisedButton(
            child: Text("Create Payment Method with Card"),
            onPressed: () {
              StripePayment.createPaymentMethod(
                PaymentMethodRequest(
                  card: testCard,
                ),
              ).then((paymentMethod) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Received ${paymentMethod.toJson()}')));
                setState(() {
                  _paymentMethod = paymentMethod;
                  print('Received payment method : ${_paymentMethod.toJson()}');
                });
                print('Received card : ${paymentMethod.toJson()}');
              }).catchError(setError);
            },
          ),
          RaisedButton(
            child: Text("Create Payment Method with existing token"),
            onPressed: _paymentToken == null
                ? null
                : () {
                    StripePayment.createPaymentMethod(
                      PaymentMethodRequest(
                        card: CreditCard(
                          token: _paymentToken.tokenId,
                        ),
                      ),
                    ).then((paymentMethod) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Received ${paymentMethod.toJson()}')));
                      setState(() {
                        _paymentMethod = paymentMethod;
                        print(
                            'Received payment method : ${_paymentMethod.toJson()}');
                      });
                    }).catchError(setError);
                  },
          ),
          Divider(),
          RaisedButton(
            child: Text("Confirm Payment Intent"),
            onPressed: _paymentMethod == null || _currentSecret == null
                ? null
                : () {
                    StripePayment.confirmPaymentIntent(
                      PaymentIntent(
                        clientSecret: _currentSecret,
                        paymentMethodId: _paymentMethod.id,
                      ),
                    ).then((paymentIntent) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              'Received ${paymentIntent.paymentIntentId}')));
                      setState(() {
                        _paymentIntent = paymentIntent;
                        print(
                            'Received payment intent : ${_paymentIntent.toJson()}');
                      });
                    }).catchError(setError);
                  },
          ),
          RaisedButton(
            child: Text("Authenticate Payment Intent"),
            onPressed: _currentSecret == null
                ? null
                : () {
                    StripePayment.authenticatePaymentIntent(
                            clientSecret: _currentSecret)
                        .then((paymentIntent) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              'Received ${paymentIntent.paymentIntentId}')));
                      setState(() {
                        _paymentIntent = paymentIntent;
                        print(
                            'Received payment intent : ${_paymentIntent.toJson()}');
                      });
                    }).catchError(setError);
                  },
          ),
          Divider(),
          RaisedButton(
            child: Text("Native payment"),
            onPressed: () {
              if (Platform.isIOS) {
                _controller.jumpTo(450);
              }
              StripePayment.paymentRequestWithNativePay(
                androidPayOptions: AndroidPayPaymentRequest(
                  totalPrice: "2.40",
                  currencyCode: "EUR",
                ),
                applePayOptions: ApplePayPaymentOptions(
                  countryCode: 'DE',
                  currencyCode: 'EUR',
                  items: [
                    ApplePayItem(
                      label: 'Test',
                      amount: '27',
                    )
                  ],
                ),
              ).then((token) {
                setState(() {
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text('Received ${token.tokenId}')));
                  _paymentToken = token;
                });
              }).catchError(setError);
            },
          ),
          RaisedButton(
            child: Text("Complete Native Payment"),
            onPressed: () {
              StripePayment.completeNativePayRequest().then((_) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Completed successfully')));
              }).catchError(setError);
            },
          ),
          Divider(),
          Text('Current source:'),
          Text(
            JsonEncoder.withIndent('  ').convert(_source?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
          Divider(),
          Text('Current token:'),
          Text(
            JsonEncoder.withIndent('  ').convert(_paymentToken?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
          Divider(),
          Text('Current payment method:'),
          Text(
            JsonEncoder.withIndent('  ')
                .convert(_paymentMethod?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
          Divider(),
          Text('Current payment intent:'),
          Text(
            JsonEncoder.withIndent('  ')
                .convert(_paymentIntent?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
          Divider(),
          Text('Current error: $_error'),
        ],
      ),
    );
  }
}
