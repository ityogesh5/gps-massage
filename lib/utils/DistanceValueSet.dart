import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/login/loginResponseModel.dart';

class DistanceSet extends StatefulWidget {
  @override
  State createState() {
    return _DistanceSetState();
  }
}

class _DistanceSetState extends State<DistanceSet> {
  var loginResponseModel = new LoginResponseModel();
  List<Address> addressList = List<Address>();

  @override
  void initState() {
    super.initState();
    //getAddressValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200.0,
        width: MediaQuery.of(context).size.width * 0.95,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: addressList.length,
            itemBuilder: (context, index) {
              return WidgetAnimator(
                Card(
                  color: Colors.grey[200],
                  semanticContainer: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 12.0),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: HealingMatchConstants
                                .userAddressesList.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return WidgetAnimator(
                                Column(
                                  children: [
                                    FittedBox(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.86,
                                            child: WidgetAnimator(
                                              TextFormField(
                                                //display the address
                                                readOnly: true,
                                                autofocus: false,
                                                initialValue:
                                                HealingMatchConstants
                                                    .userAddressesList[
                                                index]
                                                    .address,
                                                decoration:
                                                new InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                    ColorConstants
                                                        .formFieldFillColor,
                                                    hintText:
                                                    '${HealingMatchConstants.userAddressesList[index]}',
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .grey[
                                                        400],
                                                        fontSize: 14),
                                                    focusColor: Colors
                                                        .grey[100],
                                                    border: HealingMatchConstants
                                                        .textFormInputBorder,
                                                    focusedBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                                    disabledBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                                    enabledBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                                    prefixIcon:
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(
                                                          8.0),
                                                      child:
                                                      Container(
                                                          padding:
                                                          EdgeInsets.all(
                                                              8.0),
                                                          decoration:
                                                          BoxDecoration(
                                                            gradient: LinearGradient(
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                                colors: [
                                                                  Color.fromRGBO(255, 255, 255, 1),
                                                                  Color.fromRGBO(255, 255, 255, 1),
                                                                ]),
                                                            shape:
                                                            BoxShape.rectangle,
                                                            border:
                                                            Border.all(
                                                              color:
                                                              Colors.grey[100],
                                                            ),
                                                            borderRadius:
                                                            BorderRadius.circular(6.0),
                                                            color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                1),
                                                          ),
                                                          child:
                                                          Text(
                                                            '${HealingMatchConstants.userAddressesList[index].userPlaceForMassage}',
                                                            style:
                                                            TextStyle(
                                                              color: Color.fromRGBO(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  1),
                                                            ),
                                                          )),
                                                    ),
                                                    suffixIcon:
                                                    IconButton(
                                                      icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_sharp,
                                                          size: 30,
                                                          color: Colors
                                                              .black),
                                                      onPressed: () {
                                                        //Delete Value at index
                                                        /*constantUserAddressValuesList
                                                                    .removeAt(index);*/
                                                        var position =
                                                        HealingMatchConstants
                                                            .userAddressesList[
                                                        index];
                                                        print(
                                                            'Position of sub edit list position : $position');
                                                        print(
                                                            'Position of sub edit list address : ${position.address}');
                                                        openAddressEditDialog(
                                                            position
                                                                .address,
                                                            HealingMatchConstants
                                                                .userAddressesList
                                                                .indexOf(
                                                                position));
                                                      },
                                                    )),
                                                style: TextStyle(
                                                    color:
                                                    Colors.black54),
                                                onChanged: (value) {
                                                  setState(() {
                                                    HealingMatchConstants
                                                        .userAddressesList[
                                                    index]
                                                        .address = value;
                                                  });
                                                },
                                                // validator: (value) => _validateEmail(value),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  getAddressValues() async {
    setState(() {
      for (var userAddressData in loginResponseModel.data.addresses) {
        print('Address of user : ${userAddressData.toJson()}');
        print('Address of user : ${loginResponseModel.data.addresses.length}');
        addressList = loginResponseModel.data.addresses;
      }
    });
  }

  void openAddressEditDialog(String address, var position) {
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
          children: <Widget>[
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: WidgetAnimator(
                Container(
                  height: 200.0,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: HealingMatchConstants.userAddressesList.length,
                      itemBuilder: (context, index) {
                        return WidgetAnimator(
                          Card(
                            color: Colors.grey[200],
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 12.0),
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: HealingMatchConstants
                                          .userAddressesList.length,
                                      itemBuilder: (BuildContext ctxt, int index) {
                                        return WidgetAnimator(
                                          Column(
                                            children: [
                                              FittedBox(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.86,
                                                      child: WidgetAnimator(
                                                        TextFormField(
                                                          //display the address
                                                          readOnly: true,
                                                          autofocus: false,
                                                          initialValue:
                                                          HealingMatchConstants
                                                              .userAddressesList[
                                                          index]
                                                              .address,
                                                          decoration:
                                                          new InputDecoration(
                                                              filled: true,
                                                              fillColor:
                                                              ColorConstants
                                                                  .formFieldFillColor,
                                                              hintText:
                                                              '${HealingMatchConstants.userAddressesList[index]}',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey[
                                                                  400],
                                                                  fontSize: 14),
                                                              focusColor: Colors
                                                                  .grey[100],
                                                              border: HealingMatchConstants
                                                                  .textFormInputBorder,
                                                              focusedBorder:
                                                              HealingMatchConstants
                                                                  .textFormInputBorder,
                                                              disabledBorder:
                                                              HealingMatchConstants
                                                                  .textFormInputBorder,
                                                              enabledBorder:
                                                              HealingMatchConstants
                                                                  .textFormInputBorder,
                                                              prefixIcon:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child:
                                                                Container(
                                                                    padding:
                                                                    EdgeInsets.all(
                                                                        8.0),
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      gradient: LinearGradient(
                                                                          begin: Alignment.topCenter,
                                                                          end: Alignment.bottomCenter,
                                                                          colors: [
                                                                            Color.fromRGBO(255, 255, 255, 1),
                                                                            Color.fromRGBO(255, 255, 255, 1),
                                                                          ]),
                                                                      shape:
                                                                      BoxShape.rectangle,
                                                                      border:
                                                                      Border.all(
                                                                        color:
                                                                        Colors.grey[100],
                                                                      ),
                                                                      borderRadius:
                                                                      BorderRadius.circular(6.0),
                                                                      color: Color.fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1),
                                                                    ),
                                                                    child:
                                                                    Text(
                                                                      '${HealingMatchConstants.userAddressesList[index].userPlaceForMassage}',
                                                                      style:
                                                                      TextStyle(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                      ),
                                                                    )),
                                                              ),
                                                              suffixIcon:
                                                              IconButton(
                                                                icon: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down_sharp,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .black),
                                                                onPressed: () {
                                                                  //Delete Value at index
                                                                  /*constantUserAddressValuesList
                                                                    .removeAt(index);*/
                                                                  var position =
                                                                  HealingMatchConstants
                                                                      .userAddressesList[
                                                                  index];
                                                                  print(
                                                                      'Position of sub edit list position : $position');
                                                                  print(
                                                                      'Position of sub edit list address : ${position.address}');
                                                                },
                                                              )),
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black54),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              HealingMatchConstants
                                                                  .userAddressesList[
                                                              index]
                                                                  .address = value;
                                                            });
                                                          },
                                                          // validator: (value) => _validateEmail(value),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AnimatedButton(
                text: 'Ok',
                pressEvent: () {
                  dialog.dissmiss();
                })
          ],
        ),
      ),
    )..show();

  }
}
