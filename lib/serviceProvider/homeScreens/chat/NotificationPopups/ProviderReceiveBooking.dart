import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';

class ProviderReceiveBooking extends StatefulWidget {
  @override
  _ProviderReceiveBookingState createState() => _ProviderReceiveBookingState();
}

class _ProviderReceiveBookingState extends State<ProviderReceiveBooking> {
  TextEditingController expensesController = TextEditingController();
  String price;
  bool proposeAdditionalCosts = false;
  bool suggestAnotherTime = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            padding:
                EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'お知らせ',
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 30, left: 8.0, right: 8.0),
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
                    maxRadius: 55,
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                    child: SvgPicture.asset(
                        'assets/images_gps/booking_received.svg',
                        height: 45,
                        width: 45,
                        color: Color.fromRGBO(255, 157, 0, 1)),
                  ),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              Text(
                'サービス利用者からご予約がありました',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              buildBookingCard(),
              SizedBox(
                height: 18.0,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        proposeAdditionalCosts = !proposeAdditionalCosts;
                      });
                    },
                    child: Container(
                      height: 25.0,
                      width: 25.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: proposeAdditionalCosts
                          ? Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                              ),
                            )
                          : Container(),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '追加の費用を提案する',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              proposeAdditionalCosts
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                  enabled: false,
                                  controller: expensesController,
                                  style: HealingMatchConstants.formTextStyle,
                                  decoration: InputDecoration(
                                    labelText: '交通費',
                                    labelStyle: HealingMatchConstants
                                        .formLabelTextStyle,
                                    border: HealingMatchConstants
                                        .multiTextFormInputBorder,
                                    focusedBorder: HealingMatchConstants
                                        .multiTextFormInputBorder,
                                    disabledBorder: HealingMatchConstants
                                        .multiTextFormInputBorder,
                                    enabledBorder: HealingMatchConstants
                                        .multiTextFormInputBorder,
                                  )),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                color: Colors.white,
                                child: DropDownFormField(
                                  fillColor: Colors.white,
                                  borderColor: Colors.grey[400],
                                  contentPadding: EdgeInsets.all(1.0),
                                  titleText: null,
                                  hintText: '',
                                  onSaved: (value) {
                                    setState(() {
                                      price = value;
                                    });
                                  },
                                  value: price,
                                  onChanged: (value) {
                                    setState(() {
                                      price = value;
                                    });
                                  },
                                  dataSource: [
                                    {
                                      "display": "¥100",
                                      "value": "100",
                                    },
                                    {
                                      "display": "¥200",
                                      "value": "200",
                                    },
                                    {
                                      "display": "¥300",
                                      "value": "300",
                                    },
                                  ],
                                  textField: 'display',
                                  valueField: 'value',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  suggestAnotherTime = !suggestAnotherTime;
                                });
                              },
                              child: Container(
                                height: 25.0,
                                width: 25.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: suggestAnotherTime
                                    ? Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '別の時間を提案する',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        suggestAnotherTime
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                            enabled: true,
                                            initialValue: '09: 30',
                                            textAlign: TextAlign.center,
                                            // controller: expensesController,
                                            style: HealingMatchConstants
                                                .formTextStyle,
                                            decoration: InputDecoration(
                                              //  labelText: '交通費',
                                              labelStyle: HealingMatchConstants
                                                  .formLabelTextStyle,
                                              border: HealingMatchConstants
                                                  .multiTextFormInputBorder,
                                              focusedBorder:
                                                  HealingMatchConstants
                                                      .multiTextFormInputBorder,
                                              disabledBorder:
                                                  HealingMatchConstants
                                                      .multiTextFormInputBorder,
                                              enabledBorder:
                                                  HealingMatchConstants
                                                      .multiTextFormInputBorder,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '~',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                            enabled: true,
                                            initialValue: '10: 30',
                                            textAlign: TextAlign.center,
                                            //   controller: expensesController,
                                            style: HealingMatchConstants
                                                .formTextStyle,
                                            decoration: InputDecoration(
                                              //  labelText: '交通費',
                                              labelStyle: HealingMatchConstants
                                                  .formLabelTextStyle,
                                              border: HealingMatchConstants
                                                  .multiTextFormInputBorder,
                                              focusedBorder:
                                                  HealingMatchConstants
                                                      .multiTextFormInputBorder,
                                              disabledBorder:
                                                  HealingMatchConstants
                                                      .multiTextFormInputBorder,
                                              enabledBorder:
                                                  HealingMatchConstants
                                                      .multiTextFormInputBorder,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TextField(
                                    //controller: textEditingController,
                                    textInputAction: TextInputAction.done,
                                    expands: false,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      hintText: "距離が遠い為",
                                      hintStyle: HealingMatchConstants
                                          .formHintTextStyle,
                                      border: HealingMatchConstants
                                          .multiTextFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .multiTextFormInputBorder,
                                      disabledBorder: HealingMatchConstants
                                          .multiTextFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .multiTextFormInputBorder,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  buildButton(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '予約を受けない、または条件提示の理由',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Stack(
                                    children: [
                                      TextField(
                                        //controller: textEditingController,
                                        textInputAction: TextInputAction.done,
                                        expands: false,
                                        maxLines: 4,
                                        decoration: InputDecoration(
                                          hintText: "理由を入力してください。",
                                          hintStyle: HealingMatchConstants
                                              .formHintTextStyle,
                                          border: HealingMatchConstants
                                              .multiTextFormInputBorder,
                                          focusedBorder: HealingMatchConstants
                                              .multiTextFormInputBorder,
                                          disabledBorder: HealingMatchConstants
                                              .multiTextFormInputBorder,
                                          enabledBorder: HealingMatchConstants
                                              .multiTextFormInputBorder,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5.0,
                                        right: 5.0,
                                        child: InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.grey[400])),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: SvgPicture.asset(
                                                'assets/images_gps/comment_send.svg',
                                                height: 21,
                                                width: 21,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              )
                            : buildButton(),
                      ],
                    )
                  : buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Card buildBookingCard() {
    return Card(
      // margin: EdgeInsets.all(8.0),
      color: Color.fromRGBO(242, 242, 242, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images_gps/female.svg',
                        height: 18, width: 18, color: Colors.black),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'AK さん',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '(男性)',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(181, 181, 181, 1),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding: EdgeInsets.all(4),
                      child: Text(
                        '店舗',
                        style: TextStyle(
                          fontSize: 9.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '14:38 時',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      '(4.0)',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          shadows: [
                            Shadow(color: Colors.black, offset: Offset(0, -3))
                          ],
                          fontSize: 14,
                          color: Colors.transparent,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5.0),
                    RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 24.0,
                      itemPadding: new EdgeInsets.only(bottom: 3.0),
                      itemBuilder: (context, index) => new SizedBox(
                          height: 20.0,
                          width: 18.0,
                          child: new IconButton(
                            onPressed: () {},
                            padding: new EdgeInsets.all(0.0),
                            color: Colors.black,
                            icon: index == 4
                                ? SvgPicture.asset(
                                    "assets/images_gps/star_2.svg",
                                    height: 13.0,
                                    width: 12.5,
                                    color: Colors.black,
                                  )
                                : SvgPicture.asset(
                                    "assets/images_gps/star_1.svg",
                                    height: 13.0,
                                    width: 12.5,
                                    color: Colors.black,
                                  ), /*  new Icon(
                                                              Icons.star,
                                                              size: 20.0), */
                          )),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      '(152 レビュー)',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          shadows: [
                            Shadow(color: Colors.black, offset: Offset(0, -3))
                          ],
                          fontSize: 14,
                          color: Colors.transparent,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/calendar.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '10月17',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      ' 月曜日 ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(102, 102, 102, 1),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/clock.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '09: 00 ~ 10: 00',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' 60分 ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(102, 102, 102, 1),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding: EdgeInsets.all(4),
                      child: Text(
                        '足つぼ',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Divider(
                  // height: 50,
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/gps.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '施術をする場所',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 4.0, bottom: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text(
                          '店舗',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '埼玉県浦和区高砂4丁目4',
                      style: TextStyle(
                        color: Color.fromRGBO(102, 102, 102, 1),
                        fontSize: 17,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
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
            onPressed: () {},
            //  minWidth: MediaQuery.of(context).size.width * 0.38,
            // splashColor: Colors.grey,
            color: Color.fromRGBO(217, 217, 217, 1),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              '断る',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
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
            onPressed: () {},
            //   minWidth: MediaQuery.of(context).size.width * 0.38,
            splashColor: Colors.pinkAccent[600],
            color: Color.fromRGBO(200, 217, 33, 1),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              '受ける',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
