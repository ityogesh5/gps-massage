import 'package:flutter/material.dart';

class ServiceAndPricing extends StatefulWidget {
  @override
  _ServiceAndPricingState createState() => _ServiceAndPricingState();
}

class _ServiceAndPricingState extends State<ServiceAndPricing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('提供するサービスを選択し料金を設定してください。')],
                ),
                SizedBox(
                  height: 10,
                ),
                /*    Form(
                  key: bankkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        color: Colors.transparent,
                        child: DropDownFormField(
                          titleText: null,
                          hintText: readonly ? bankname : 'サービス分類*',
                          onSaved: (value) {
                            setState(() {
                              bankname = value;
                            });
                          },
                          value: bankname,
                          onChanged: (value) {
                            setState(() {
                              bankname = value;
                            });
                          },
                          dataSource: [
                            {
                              "display": "賃貸",
                              "value": "賃貸",
                            },
                            {
                              "display": "販売（売買）",
                              "value": "販売（売買）",
                            },
                            {
                              "display": "賃貸",
                              "value": "賃貸",
                            },
                            {
                              "display": "販売（売買）",
                              "value": "販売（売買）",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
