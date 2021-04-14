import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';

class NewStopWatch extends StatefulWidget {

  @override
  _NewStopWatchState createState() => _NewStopWatchState();

}

class _NewStopWatchState extends State<NewStopWatch> with WidgetsBindingObserver{


  AppLifecycleState _notification;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() { _notification = state; });
  }




  Stopwatch watch = Stopwatch();
  Timer timer;
  bool startStop = true;

  String elapsedTime = '';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        print("startstop Inside=$startStop");
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (BuildContext ctxt, int index) {
                return Column(
                  /*  mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,*/
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(8.0),
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
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: Text(
                              'オフィス',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            )),
                        SizedBox(
                          width: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                0.60,
                            child: TextFormField(
                              initialValue:
                              'Address lists',
                              readOnly: true,
                              //display the address
                              decoration: new InputDecoration(
                                  filled: true,
                                  fillColor: ColorConstants
                                      .formFieldFillColor,
                                  hintText:
                                  'Address',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14),
                                  focusColor:
                                  Colors.grey[100],
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
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.keyboard_arrow_down_sharp,size: 40),
                                    onPressed: () {
                                      setState(() {
                                        openAddressEditDialog();
                                      });
                                    },
                                  )),
                              style: TextStyle(
                                  color: Colors.black54),
                              onChanged: (value) {
                                setState(() {

                                });
                              },
                              // validator: (value) => _validateEmail(value),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                );
              }),
        ),
      )
    );
  }

  startOrStop() {
    if(startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  void openAddressEditDialog() {
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      keyboardAware: true,
      width: MediaQuery.of(context).size.width,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              '住所の編集',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: TextFormField(
                autofocus: true,
                minLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Title',
                  suffixIcon: Icon(Icons.delete),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLengthEnforced: true,
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AnimatedButton(
                text: 'Close',
                pressEvent: () {
                  dialog.dissmiss();
                })
          ],
        ),
      ),
    )..show();
  }


}