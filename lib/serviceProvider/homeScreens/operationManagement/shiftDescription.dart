import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';

class ShiftDescription extends StatefulWidget {
  @override
  _ShiftDescriptionState createState() => _ShiftDescriptionState();
}

class _ShiftDescriptionState extends State<ShiftDescription> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Text(
                "PR(施術内容、特徴) 注意事項等を自由に記載できます",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                // hack textfield height
                // padding: EdgeInsets.only(bottom: 40.0),
                child: TextField(
                  expands: false,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "買問、要望なとメッセージがあれば入力してください。",
                    hintStyle: HealingMatchConstants.formHintTextStyle,
                    border: HealingMatchConstants.multiTextFormInputBorder,
                    focusedBorder:
                        HealingMatchConstants.multiTextFormInputBorder,
                    disabledBorder:
                        HealingMatchConstants.multiTextFormInputBorder,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    Text(
                      "*",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "リービス利用者に向けたPRコメントを記入してください。",
                      textAlign: TextAlign.center,
                      style: HealingMatchConstants.formHintTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "*",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "電話番号、メールアドレス、 SNSのアカウント、\n ホームページURL等の記載はお控えください。\n (詳しくは利用規をご覧ください。) ",
                      //textAlign: TextAlign.center,
                      style: HealingMatchConstants.formHintTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.9,
                //margin: EdgeInsets.only(top: 1.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.lime,
                ),
                child: RaisedButton(
                  child: Text(
                    'アップロードする',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.lime,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
