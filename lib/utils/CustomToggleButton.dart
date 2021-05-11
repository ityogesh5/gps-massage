import 'package:flutter/material.dart';
import 'package:gps_massageapp/customLibraryClasses/customSwitch/custom_dialog_switch.dart';

class CustomSwitchButton extends StatefulWidget {
  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<CustomSwitchButton> {
  bool enableSwitch = false;

  void _toggle() {
    setState(() {
      enableSwitch = !enableSwitch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text("Flutter Animated Custom Switch Demo"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: _toggle,
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Enable Custom Switch",
                  textScaleFactor: 1.2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomDialogSwitch(switched: enableSwitch),
            ],
          ),
        ),
      ),
    );
  }
}
