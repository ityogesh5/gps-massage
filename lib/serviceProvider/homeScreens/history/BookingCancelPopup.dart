import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';

class CancelBooking extends StatefulWidget {
  @override
  _CancelBookingState createState() => _CancelBookingState();
}

class _CancelBookingState extends State<CancelBooking> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 350.0, // MediaQuery.of(context).size.width,
        //margin: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Center(
                child: DottedBorder(
                  dashPattern: [3, 3],
                  strokeWidth: 1,
                  color: Color.fromRGBO(232, 232, 232, 1),
                  strokeCap: StrokeCap.round,
                  borderType: BorderType.Circle,
                  radius: Radius.circular(5),
                  child: CircleAvatar(
                    maxRadius: 45,
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                    child: SvgPicture.asset(
                        'assets/images_gps/cancel_popup.svg',
                        height: 45,
                        width: 45,
                        color: Colors.black),
                  ),
                ),
              ),
              Text(
                "この予約をキャンセルしますか？",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  /*  fontWeight: FontWeight.bold */
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                // hack textfield height
                // padding: EdgeInsets.only(bottom: 40.0),
                child: TextField(
                  controller: textEditingController,
                  textInputAction: TextInputAction.done,
                  expands: false,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "キャンセルする理由を記入ください",
                    hintStyle: HealingMatchConstants.multiTextHintTextStyle,
                    border: HealingMatchConstants.multiTextFormInputBorder,
                    focusedBorder:
                        HealingMatchConstants.multiTextFormInputBorder,
                    disabledBorder:
                        HealingMatchConstants.multiTextFormInputBorder,
                    enabledBorder:
                        HealingMatchConstants.multiTextFormInputBorder,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FittedBox(
                child: Text(
                  "予約確定（支払い完了)した案件で、施術時間から\n 逆算して４８時間以内でのキャンセルはキャンセル料\nが 発生します。（詳細は利用規約をご参照ください。）",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              buildButton()
              /*  Container(
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
              ), */
            ],
          ),
        ),
      ),
    );
  }

  buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Color.fromRGBO(217, 217, 217, 1),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              'はい',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            //   minWidth: MediaQuery.of(context).size.width * 0.38,

            color: Color.fromRGBO(200, 217, 33, 1),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              'いいえ',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
