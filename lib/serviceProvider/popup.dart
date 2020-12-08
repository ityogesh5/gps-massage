import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Popup());
}

class Popup extends StatefulWidget {
  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Testing")),
      body: Center(
        child: RaisedButton(
          child: Text("Show PopUp"),
          onPressed: () {
            //showChooseServiceAlert(context);
            showSuccessAlert(context);
          },
        ),
      ),
    );
  }

  showChooseServiceAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 16,
          child: Container(
            //height: 300.0,
            //width: 450.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "計算したい日付を選択し",
                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                //print("LAT: ${test}");
                                print("User onTapped");
                              },
                              child: Image.asset(
                                'assets/images/user.png',
                                height: 150.0,
                                //width: 150.0,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "不動産カレンダー",
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap:() {
                                print("Provider onTapped");
                              },
                              child: Image.asset(
                                'assets/images/provider.png',
                                height: 150.0,
                                //width: 150.0,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "不動産カレンダー",
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  /*Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text(
                              "不動産カレンダー",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(width: 15.0),
                            Text(
                              "不動産カレンダー",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],),*/
                  Text(
                    "不動産カレンダー不動産カレンダー",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 16,
          child: Container(
            margin: const EdgeInsets.all(0.0),
            //height: 300.0,
            //width: 450.0,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/images/successpopuptop.png',
                    height: 150.0,
                    //width: 150.0,
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      "計算したい日付を選択し",
                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                          child: RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            child: Text("OK",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            color: Colors.lime,
                            textColor: Colors.white,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Dialog Title'),
                                    content: Text('This is my content'),
                                  )
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildName({String imageAsset, String name, double score}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Container(height: 2, color: Colors.redAccent),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(imageAsset),
                radius: 30,
              ),
              SizedBox(width: 12),
              Text(name),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text("${score}"),
                decoration: BoxDecoration(
                  color: Colors.yellow[900],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showDateSelectAlert(BuildContext context) {
}
