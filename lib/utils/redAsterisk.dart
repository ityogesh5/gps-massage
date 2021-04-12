import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/utils/text_field_custom.dart';

class Astricks extends StatefulWidget {
  @override
  _AstricksState createState() => _AstricksState();
}

class _AstricksState extends State<Astricks> {
  double containerHeight = 48.0;
  final userNameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 20),
            child: InkWell(
              onTap: () {
                // HealingMatchConstants.isUserRegistrationSkipped = true;
                // NavigationRouter.switchToServiceUserBottomBar(context);
              },
              child: Text(
                'スキップ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansJP',
                    fontSize: 18.0,
                    decoration: TextDecoration.underline),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: containerHeight,
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextFieldCustom(
                controller: userNameController,
                autofocus: false,
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: ColorConstants.formFieldFillColor,
                  focusColor: Colors.grey[100],
                  border: HealingMatchConstants.textFormInputBorder,
                  focusedBorder: HealingMatchConstants.textFormInputBorder,
                  disabledBorder: HealingMatchConstants.textFormInputBorder,
                  enabledBorder: HealingMatchConstants.textFormInputBorder,
                  // labelText: 'お名前',
                ),
                hintText: Text.rich(
                  TextSpan(
                    text: 'お名前',
                    children: <InlineSpan>[
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ],
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontFamily: 'NotoSansJP',
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
