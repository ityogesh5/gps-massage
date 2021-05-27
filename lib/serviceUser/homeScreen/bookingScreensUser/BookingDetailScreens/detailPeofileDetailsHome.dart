import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetUserDetails.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:readmore/readmore.dart';
import 'package:toast/toast.dart';

class DetailPeofileDetailsHome extends StatefulWidget {
  final TherapistByIdModel therapistDetails;
  final int id;
  DetailPeofileDetailsHome(this.therapistDetails, this.id);
  @override
  _DetailPeofileDetailsHomeState createState() =>
      _DetailPeofileDetailsHomeState();
}

class _DetailPeofileDetailsHomeState extends State<DetailPeofileDetailsHome> {
  Map<int, String> childrenMeasure;
  Map<int, String> serviceType;
  Map<String, String> certificateImages = Map<String, String>();
  String genderOfService;
  int _value = 0;
  var result;
  bool shopLocationSelected = false;
  var userPlaceForMassage, therapistAddress, userRegisteredAddress;
  GlobalKey<FormState> _userDetailsFormKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getProfileDetails();
    getTherapistDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Display the Service types Available
          Container(
            height: 30.0,
            width: MediaQuery.of(context).size.width - 130.0, //200.0,
            child: ListView.builder(
                itemCount: serviceType.length,
                padding: EdgeInsets.all(0.0),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  String path = getAssetPath(serviceType[index]);
                  return buildServiceType(path, context, index);
                }),
          ),

          SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Profile Image Build
              buildProfileImage(),

              //Other Details
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //name
                        Text(
                          widget.therapistDetails.data.isShop
                              ? "${widget.therapistDetails.data.storeName}"
                              : "${widget.therapistDetails.data.userName}",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5.0),

                        //shop
                        widget.therapistDetails.data.isShop
                            ? Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: buildProileDetailCard("店舗", 9.0),
                              )
                            : Container(),
                        SizedBox(width: 5.0),

                        //BusinessTrip
                        widget.therapistDetails.data.businessTrip
                            ? Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: buildProileDetailCard("出張", 9.0),
                              )
                            : Container(),
                        SizedBox(width: 5.0),

                        //Corona Measures
                        widget.therapistDetails.data.coronaMeasure
                            ? Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: buildProileDetailCard("コロナ対策実施", 9.0),
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Rating average
                        Text(
                          '(${widget.therapistDetails.reviewData.ratingAvg})',
                          style: TextStyle(
                              decorationColor: Color.fromRGBO(153, 153, 153, 1),
                              shadows: [
                                Shadow(
                                    color: Color.fromRGBO(153, 153, 153, 1),
                                    offset: Offset(0, -3))
                              ],
                              fontSize: 14,
                              color: Colors.transparent,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5.0),

                        //Ratings
                        buildRatingBar(),
                        SizedBox(width: 5.0),

                        //Number of Review Members
                        Text(
                          '(${widget.therapistDetails.reviewData.noOfReviewsMembers})',
                          style: TextStyle(
                              decorationColor: Color.fromRGBO(153, 153, 153, 1),
                              shadows: [
                                Shadow(
                                    color: Color.fromRGBO(153, 153, 153, 1),
                                    offset: Offset(0, -3))
                              ],
                              fontSize: 10,
                              color: Colors.transparent,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          //Gender of Service
          SizedBox(
            height: genderOfService != null ? 10.0 : 0.0,
          ),
          genderOfService != null
              ? buildProileDetailCard(genderOfService, 12.0)
              : Container(),

          //Children Measure
          SizedBox(
            height: childrenMeasure != null ? 10.0 : 0.0,
          ),
          childrenMeasure != null
              ? Container(
                  height: 30.0,
                  width: MediaQuery.of(context).size.width - 130.0, //200.0,
                  child: ListView.builder(
                      itemCount: childrenMeasure.length,
                      padding: EdgeInsets.all(0.0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return buildProileDetailCard(
                            childrenMeasure[index], 12.0);
                      }),
                )
              : Container(),

          //Certificate Image
          SizedBox(
            height: certificateImages != null ? 10.0 : 0.0,
          ),
          certificateImages != null
              ? Container(
                  height: 30.0,
                  width: MediaQuery.of(context).size.width - 130.0, //200.0,
                  child: ListView.builder(
                      itemCount: certificateImages.length,
                      padding: EdgeInsets.all(0.0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        String key = certificateImages.keys.elementAt(index);
                        return buildProileDetailCard(key, 12.0);
                      }),
                )
              : Container(),

          //Address and Store Time
          SizedBox(height: 15.0),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1),
                    ]),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.grey[300],
                ),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[200]),
            width: MediaQuery.of(context).size.width * 0.90,
            height: 90.0,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 12.0, bottom: 8.0, right: 8.0),
              child: Container(
                child: buildAddressClockDetails(),
              ),
            ),
          ),

          //Divider
          SizedBox(height: 10.0),
          Divider(
            color: Color.fromRGBO(217, 217, 217, 1),
          ),

          //Shift Description
          widget.therapistDetails.data.storeDescription != null &&
                  widget.therapistDetails.data.storeDescription != ''
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.0),
                      Text(
                        "メッセージ",
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 7.0),
                      ReadMoreText(
                        "${widget.therapistDetails.data.storeDescription}",
                        style: TextStyle(
                          color: Color.fromRGBO(102, 102, 102, 1),
                          fontSize: 12,
                        ),
                        trimLines: 2,
                        colorClickableText: Colors.black,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'もっとみる',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                        lessStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),

                      //Divider
                      SizedBox(height: 10.0),
                      Divider(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ],
                  ),
                )
              : Container(),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1),
                    ]),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.grey[300],
                ),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[200]),
            width: MediaQuery.of(context).size.width * 0.90,
            height: 50.0,
            child: WidgetAnimator(
              TextFormField(
                //display the address
                readOnly: true,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: HealingMatchConstants.userRegisteredAddressDetail,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                      fontSize: 12,
                      fontFamily: 'NotoSansJP',
                      color: Colors.black),
                  focusColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey[200],
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey[200],
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey[200],
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey[200],
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images_gps/gps.svg'),
                        SizedBox(width: 10),
                        Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(255, 255, 255, 1),
                                    Color.fromRGBO(255, 255, 255, 1),
                                  ]),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.grey[200],
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: shopLocationSelected
                                ? Text(
                                    '店舗',
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'NotoSansJP',
                                    ),
                                  )
                                : Text(
                                    '$userPlaceForMassage',
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'NotoSansJP',
                                    ),
                                  )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03),
                        Flexible(
                            child: shopLocationSelected
                                ? new Text(
                                    '${widget.therapistDetails.data.addresses[0].address}',
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'NotoSansJP',
                                        color: Colors.grey[500]),
                                  )
                                : new Text(
                                    '$userRegisteredAddress',
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'NotoSansJP',
                                        color: Colors.grey[500]),
                                  )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15),
                        GestureDetector(
                          onTap: () => openUserLocationSelectionDialog(),
                          child: Icon(Icons.keyboard_arrow_down_sharp,
                              size: 35, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 4.0,
              left: 14.0,
              bottom: 4.0,
            ),
            child: Text(
              "施術メニューを選んでください",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // buildServiceTypeDatas(context),
        ],
      ),
    );
  }

  getServiceAddress() {
    setState(() {
      shopLocationSelected
          ? HealingMatchConstants.confServiceAddressType = '店舗'
          : HealingMatchConstants.confServiceAddressType =
              userPlaceForMassage.toString();

      shopLocationSelected
          ? HealingMatchConstants.confServiceAddress =
              widget.therapistDetails.data.addresses[0].address
          : HealingMatchConstants.confServiceAddress =
              userRegisteredAddress.toString();
    });
  }

  void openUserLocationSelectionDialog() {
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      dialogType: DialogType.QUESTION,
      keyboardAware: true,
      width: MediaQuery.of(context).size.width,
      dismissOnTouchOutside: true,
      showCloseIcon: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'マッサージのためにセラピストの店舗に行きたいですか？',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansJP'),
            ),
            SizedBox(
              height: 10,
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.33,
              child: CustomToggleButton(
                initialValue: 0,
                elevation: 0,
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.33,
                autoWidth: false,
                buttonColor: Color.fromRGBO(217, 217, 217, 1),
                enableShape: true,
                customShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.transparent)),
                buttonLables: ["はい", "いいえ"],
                fontSize: 16.0,
                buttonValues: [
                  "Y",
                  "N",
                ],
                radioButtonValue: (value) {
                  if (value == 'Y') {
                    if (this.mounted) {
                      setState(() {
                        shopLocationSelected = true;
                        dialog.dissmiss();
                      });
                    }
                  } else {
                    dialog.dissmiss();
                    getUserAddressValues();
                  }
                  print('Radio value : $value');
                },
                selectedColor: Color.fromRGBO(200, 217, 33, 1),
              ),
            ),
          ],
        ),
      ),
    )..show();
  }

  getUserAddressValues() async {
    try {
      ProgressDialogBuilder.showOverlayLoader(context);
      var userListApiProvider = ServiceUserAPIProvider.getUserDetails(
          context, HealingMatchConstants.serviceUserID);
      userListApiProvider.then((value) {
        print('userProfileImage: ${value.data.uploadProfileImgUrl}');
        if (this.mounted) {
          setState(() {
            for (int i = 0; i < value.data.addresses.length; i++) {
              if (value.data.addresses[0].isDefault) {
                HealingMatchConstants.userAddressDetailsList =
                    value.data.addresses.cast<UserAddresses>();
                print(
                    'Address length loop : ${HealingMatchConstants.userAddressDetailsList.length}');
                HealingMatchConstants.userAddressDetailsList.removeAt(0);
                openAddressListDialog();
              } else {
                ProgressDialogBuilder.hideLoader(context);
                print('Is default false');
                return;
              }
            }
          });
        }
      });
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Details Exception : ${e.toString()}');
      return;
    }
  }

  void openAddressListDialog() {
    print('Entering... ${HealingMatchConstants.userAddressDetailsList.length}');
    if (HealingMatchConstants.userAddressDetailsList.length != 0) {
      print(
          'Address length : ${HealingMatchConstants.userAddressDetailsList.length}');
      ProgressDialogBuilder.hideLoader(context);
      AwesomeDialog dialog;
      var address, placeForMassage;
      dialog = AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        dialogType: DialogType.INFO,
        keyboardAware: true,
        width: MediaQuery.of(context).size.width,
        dismissOnTouchOutside: true,
        showCloseIcon: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                '施術を受ける場所を選択してください。',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansJP'),
              ),
              SizedBox(height: 10),
              WidgetAnimator(
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:
                        HealingMatchConstants.userAddressDetailsList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return WidgetAnimator(
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.86,
                              child: WidgetAnimator(
                                TextFormField(
                                  //display the address
                                  readOnly: true,
                                  autofocus: false,
                                  enableInteractiveSelection: true,
                                  initialValue: HealingMatchConstants
                                      .userAddressDetailsList[index].address,
                                  decoration: new InputDecoration(
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                      hintText:
                                          '${HealingMatchConstants.userAddressDetailsList[index]}',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14),
                                      focusColor: Colors.grey[100],
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      disabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          print(
                                              'Address Type Container selected...');
                                          _userDetailsFormKey.currentState
                                              .save();
                                          setState(() {
                                            address = HealingMatchConstants
                                                .userAddressDetailsList[index]
                                                .address;
                                            placeForMassage =
                                                HealingMatchConstants
                                                    .userAddressDetailsList[
                                                        index]
                                                    .userPlaceForMassage;
                                            shopLocationSelected = false;
                                            userRegisteredAddress = address;
                                            userPlaceForMassage =
                                                placeForMassage;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[100],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                              child: Text(
                                                '${HealingMatchConstants.userAddressDetailsList[index].userPlaceForMassage}',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                ),
                                              )),
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              size: 30),
                                          onPressed: () {
                                            setState(() {
                                              address = HealingMatchConstants
                                                  .userAddressDetailsList[index]
                                                  .address;
                                              placeForMassage =
                                                  HealingMatchConstants
                                                      .userAddressDetailsList[
                                                          index]
                                                      .userPlaceForMassage;

                                              print(
                                                  'Selected Place and Address : $address\n$placeForMassage');
                                            });
                                          })),
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              AnimatedButton(
                  text: 'Ok',
                  pressEvent: () {
                    if (address != null && placeForMassage != null) {
                      if (this.mounted) {
                        setState(() {
                          shopLocationSelected = false;
                          userRegisteredAddress = address;
                          userPlaceForMassage = placeForMassage;
                        });
                      }

                      dialog.dissmiss();
                    } else {
                      Toast.show("有効な住所を選択してください。", context,
                          duration: 3,
                          gravity: Toast.CENTER,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white);
                      if (this.mounted) {
                        setState(() {
                          address = null;
                          placeForMassage = null;
                        });
                      }

                      return;
                    }
                  })
            ],
          ),
        ),
      )..show();
    } else {
      print('Entering else !!');
      openNoAddressDialog(context);
    }
  }

  void openNoAddressDialog(BuildContext context) {
    ProgressDialogBuilder.hideLoader(context);
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      dialogBackgroundColor: Colors.red[200],
      context: context,
      animType: AnimType.RIGHSLIDE,
      dialogType: DialogType.WARNING,
      keyboardAware: true,
      width: MediaQuery.of(context).size.width,
      dismissOnTouchOutside: true,
      showCloseIcon: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '住所の情報！',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoSansJP'),
          ),
          SizedBox(height: 10),
          Text(
            '住所の値が見つかりません。住所を追加してください。', //住所の情報！
            style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'NotoSansJP'),
          ),
          SizedBox(height: 10),
          AnimatedButton(
              text: 'Ok',
              pressEvent: () {
                dialog.dissmiss();
              })
        ],
      ),
    )..show();
  }

  Column buildServiceTypeDatas(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: result.contains("エステ"),
              child: GestureDetector(
                //  onTap: () => setState(() => _value = 0),
                onTap: () {
                  setState(() {
                    _value = 1;
                    HealingMatchConstants.serviceType = 1;
                  });
                },
                child: Column(
                  children: [
                    Card(
                      elevation: _value == 1 ? 4.0 : 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _value == 1
                              ? Color.fromRGBO(242, 242, 242, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: _value == 1
                                ? Color.fromRGBO(102, 102, 102, 1)
                                : Color.fromRGBO(228, 228, 228, 1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeOne.svg',
                            color: _value == 1
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                            height: 29.81,
                            width: 27.61,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: result.contains("接骨・整体"),
              child: GestureDetector(
                //onTap: () => setState(() => _value = 1),
                onTap: () {
                  setState(() {
                    _value = 2;
                    HealingMatchConstants.serviceType = 2;
                  });
                },
                child: Column(
                  children: [
                    Card(
                      elevation: _value == 2 ? 4.0 : 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _value == 2
                              ? Color.fromRGBO(242, 242, 242, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: _value == 2
                                ? Color.fromRGBO(102, 102, 102, 1)
                                : Color.fromRGBO(228, 228, 228, 1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeTwo.svg',
                            color: _value == 2
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                            height: 33,
                            width: 34,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: result.contains("リラクゼーション"),
              child: GestureDetector(
                //onTap: () => setState(() => _value = 2),
                onTap: () {
                  setState(() {
                    _value = 3;
                    HealingMatchConstants.serviceType = 3;
                  });
                },
                child: Column(
                  children: [
                    Card(
                      elevation: _value == 3 ? 4.0 : 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _value == 3
                              ? Color.fromRGBO(242, 242, 242, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: _value == 3
                                ? Color.fromRGBO(102, 102, 102, 1)
                                : Color.fromRGBO(228, 228, 228, 1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeThree.svg',
                            color: _value == 3
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: result.contains("フィットネス"),
              child: GestureDetector(
                //onTap: () => setState(() => _value = 3),
                onTap: () {
                  setState(() {
                    _value = 4;
                    HealingMatchConstants.serviceType = 4;
                  });
                },
                child: Column(
                  children: [
                    Card(
                      elevation: _value == 4 ? 4.0 : 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _value == 4
                              ? Color.fromRGBO(242, 242, 242, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: _value == 4
                                ? Color.fromRGBO(102, 102, 102, 1)
                                : Color.fromRGBO(228, 228, 228, 1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeFour.svg',
                            color: _value == 4
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                            height: 35,
                            width: 27,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: result.contains("エステ"),
              child: Expanded(
                child: Text(
                  HealingMatchConstants.searchEsteticTxt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _value == 1
                        ? Color.fromRGBO(0, 0, 0, 1)
                        : Color.fromRGBO(217, 217, 217, 1),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: result.contains("接骨・整体"),
              child: Expanded(
                child: Text(
                  HealingMatchConstants.searchOsthepaticTxt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _value == 2
                        ? Color.fromRGBO(0, 0, 0, 1)
                        : Color.fromRGBO(217, 217, 217, 1),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: result.contains("リラクゼーション"),
              child: Expanded(
                child: FittedBox(
                  child: Text(
                    HealingMatchConstants.searchRelaxationTxt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: _value == 3
                          ? Color.fromRGBO(0, 0, 0, 1)
                          : Color.fromRGBO(217, 217, 217, 1),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: result.contains("フィットネス"),
              child: Expanded(
                child: Text(
                  HealingMatchConstants.searchFitnessTxt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _value == 4
                        ? Color.fromRGBO(0, 0, 0, 1)
                        : Color.fromRGBO(217, 217, 217, 1),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Row buildServiceType(String path, BuildContext context, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          maxRadius: 12,
          backgroundColor: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: CircleAvatar(
              maxRadius: 10,
              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              child: SvgPicture.asset('$path', height: 15, width: 15),
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        Center(
          child: Text(
            '${serviceType[index]}',
            style: TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(width: 10.0),
      ],
    );
  }

  Column buildAddressClockDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/images_gps/gps.svg',
                  height: 16, width: 16),
              SizedBox(width: 10),
              new Text(
                '住所:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: 'NotoSansJP'),
              ),
              SizedBox(width: 5),
              Flexible(
                child: new Text(
                  widget.therapistDetails.data.addresses[0].address,
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                      fontFamily: 'NotoSansJP'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/images_gps/clock.svg',
                  height: 14, width: 14),
              SizedBox(width: 7),
              new Text(
                '営業時間:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: 'NotoSansJP'),
              ),
              SizedBox(width: 5),
              new Text(
                '10:30 ～ 11:30',
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontFamily: 'NotoSansJP'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getTherapistDetails(userID) async {
    print('Therapist user id : $userID');
    HealingMatchConstants.userAddressDetailsList.clear();
    print(
        'List cleared : ${HealingMatchConstants.userAddressDetailsList.length})');
    try {
      ProgressDialogBuilder.showOverlayLoader(context);
      var therapistDetails =
          ServiceUserAPIProvider.getTherapistDetails(context, userID);
      therapistDetails.then((value) {
        if (this.mounted) {
          setState(() {
            userRegisteredAddress =
                HealingMatchConstants.userRegisteredAddressDetail;
            userPlaceForMassage = HealingMatchConstants.userPlaceForMassage;
            if (value.data.addresses != null) {
              for (int i = 0; i < value.data.addresses.length; i++) {
                therapistAddress = value.data.addresses[i].address;
              }
            }
          });
          ProgressDialogBuilder.hideLoader(context);
        }
      });
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Therapist details fetch Exception : ${e.toString()}');
      return;
    }
  }

  getProfileDetails() {
    //Get avail. Service Types
    var split = widget.therapistDetails.data.storeType.split(',');
    serviceType = {for (int i = 0; i < split.length; i++) i: split[i]};

    String serviceTypes = widget.therapistDetails.data.storeType;
    var splilts = serviceTypes.split(',');
    final jsonListType = splilts.map((item) => jsonEncode(item)).toList();
    final uniqueJsonListType = jsonListType.toSet().toList();
    result = uniqueJsonListType.map((item) => jsonDecode(item)).toList();

    //Get Gender of Service Data
    if (widget.therapistDetails.data.genderOfService != null &&
        widget.therapistDetails.data.genderOfService != '') {
      if (widget.therapistDetails.data.genderOfService == "男性女性両方") {
        genderOfService = "男性と女性の両方が予約できます"; //both men and women
      } else if (widget.therapistDetails.data.genderOfService == "女性のみ") {
        genderOfService = "女性のみ予約可"; //only women
      } else {
        genderOfService = "男性のみ予約可能"; //only men
      }
    }

    //Get Children Measure Data
    if (widget.therapistDetails.data.childrenMeasure != null &&
        widget.therapistDetails.data.childrenMeasure != '') {
      var split = widget.therapistDetails.data.childrenMeasure.split(',');
      childrenMeasure = {for (int i = 0; i < split.length; i++) i: split[i]};
    }

    //Get Certificate Image Data
    var certificateUpload =
        widget.therapistDetails.data.certificationUploads[0].toJson();
    certificateUpload.remove('id');
    certificateUpload.remove('userId');
    certificateUpload.remove('createdAt');
    certificateUpload.remove('updatedAt');
    certificateUpload.forEach((key, value) async {
      if (certificateUpload[key] != null) {
        String jKey = getQualififcationJaWords(key);
        if (jKey == "はり師" ||
            jKey == "きゅう師" ||
            jKey == "鍼灸師" ||
            jKey == "あん摩マッサージ指圧師" ||
            jKey == "柔道整復師" ||
            jKey == "理学療法士") {
          certificateImages["国家資格保有"] = "国家資格保有";
        } else if (jKey == "国家資格取得予定（学生）") {
          certificateImages["国家資格取得予定（学生）"] = "国家資格取得予定（学生）";
        } else if (jKey == "民間資格") {
          certificateImages["民間資格"] = "民間資格";
        } else if (jKey == "無資格") {
          certificateImages["無資格"] = "無資格";
        }
      }
    });
    if (certificateImages.length == 0) {
      certificateImages["無資格"] = "無資格";
    }
  }

  RatingBar buildRatingBar() {
    return RatingBar.builder(
      initialRating: double.parse(widget.therapistDetails.reviewData.ratingAvg),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 24.0,
      ignoreGestures: true,
      itemPadding: new EdgeInsets.only(bottom: 3.0),
      itemBuilder: (context, index) => new SizedBox(
          height: 20.0,
          width: 18.0,
          child: new IconButton(
            onPressed: () {},
            padding: new EdgeInsets.all(0.0),
            // color: Colors.white,
            icon: index >
                    (double.parse(widget.therapistDetails.reviewData.ratingAvg))
                            .ceilToDouble() -
                        1
                ? SvgPicture.asset(
                    "assets/images_gps/star_2.svg",
                    height: 13.0,
                    width: 13.0,
                  )
                : SvgPicture.asset(
                    "assets/images_gps/star_colour.svg",
                    height: 13.0,
                    width: 13.0,
                    //color: Colors.black,
                  ),
          )),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  Container buildProileDetailCard(String key, double size) {
    return Container(
        padding: EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 1),
                ]),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.grey[300],
            ),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.grey[200]),
        child: Text(
          '$key',
          style: TextStyle(fontSize: size),
        ));
  }

  Container buildProfileImage() {
    return Container(
      child: widget.therapistDetails.data.uploadProfileImgUrl != null
          ? CachedNetworkImage(
              imageUrl: widget.therapistDetails.data.uploadProfileImgUrl,
              filterQuality: FilterQuality.high,
              fadeInCurve: Curves.easeInSine,
              imageBuilder: (context, imageProvider) => Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) =>
                  SpinKitDoubleBounce(color: Colors.lightGreenAccent),
              errorWidget: (context, url, error) => Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12),
                  image: DecorationImage(
                      image: new AssetImage(
                          'assets/images_gps/placeholder_image.png'),
                      fit: BoxFit.cover),
                ),
              ),
            )
          : Container(
              width: 56.0,
              height: 56.0,
              decoration: new BoxDecoration(
                border: Border.all(color: Colors.grey),
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: new AssetImage('assets/images_gps/logo.png'),
                ),
              )),
    );
  }

  String getAssetPath(String name) {
    switch (name) {
      case 'エステ':
        return 'assets/images_gps/serviceTypeOne.svg';
        break;
      case '接骨・整体':
        return 'assets/images_gps/serviceTypeTwo.svg';
        break;
      case 'リラクゼーション':
        return 'assets/images_gps/serviceTypeThree.svg';
        break;
      case 'フィットネス':
        return 'assets/images_gps/serviceTypeFour.svg';
        break;
    }
  }

  String getQualififcationJaWords(String key) {
    switch (key) {
      case 'acupuncturist':
        return 'はり師';
        break;
      case 'moxibutionist':
        return 'きゅう師';
        break;
      case 'acupuncturistAndMoxibustion':
        return '鍼灸師';
        break;
      case 'anmaMassageShiatsushi':
        return 'あん摩マッサージ指圧師';
        break;
      case 'judoRehabilitationTeacher':
        return '柔道整復師';
        break;
      case 'physicalTherapist':
        return '理学療法士';
        break;
      case 'acquireNationalQualifications':
        return '国家資格取得予定（学生）';
        break;
      case 'privateQualification1':
        return '民間資格';
      case 'privateQualification2':
        return '民間資格';
      case 'privateQualification3':
        return '民間資格';
      case 'privateQualification4':
        return '民間資格';
      case 'privateQualification5':
        return '民間資格';
        break;
    }
  }
}
