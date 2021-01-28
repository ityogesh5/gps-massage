import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:image_picker/image_picker.dart';

class OperationManagement extends StatefulWidget {
  @override
  _OperationManagementState createState() => _OperationManagementState();
}

class _OperationManagementState extends State<OperationManagement> {
  List<String> shiftValues = [
    "キッズスペースの完備",
    "保育士の常駐",
    "子供同伴OK",
    "ースの完備",
    "キッズスペ",
  ];
  double sizedBoxFormHeight = 15.0;
  PickedFile _shiftImage;


  bool _isLoading = true;
  List<String> _items = [];

  int _selectedIndex = -1;
  //Map<String, String> shiftImages = Map<String, String>();
  bool uploadVisible = false;
  List<String> shiftImages = List<String>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerHeight =
        51.0; //height of Every TextFormField wrapped with container
    double containerWidth =
        size.width * 0.9; //width of Every TextFormField wrapped with container
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            NavigationRouter.switchToServiceProviderBottomBar(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'マイアカウント',
          style: TextStyle(
              fontFamily: 'Oxygen',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: SizedBox(
                height: 80.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: shiftValues.length,
                    itemBuilder: (BuildContext context, int index) {
                      print('$index');
                      _selectedIndex = index;
                      String key = shiftValues[index];
                      _buildWidget(key, index);
                      return SizedBox(
                        //width: 100.0,
                        child: Center(
                            child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(10.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Text(
                            '${shiftValues[index]}',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 14.0),
                          ),
                        )),
                      );
                    }),
              ),
            ),
            SizedBox(height: sizedBoxFormHeight),
            Container(
              //height: containerHeight,
              width: containerWidth,
              child: Text('キッズスペースの完保育士の常子供同伴完保育士の常子供同伴',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10.0),
            Container(
              //height: containerHeight,
              width: containerWidth,
              child: Text('キッズスペースの完保育士の常子供同伴OK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: sizedBoxFormHeight),
            Container(
              width: containerWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "日付を選",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2, color: Colors.black12)),
                          child: Icon(
                            Icons.add,
                            size: 30.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: sizedBoxFormHeight),
            Container(
              width: containerWidth,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: shiftImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildShiftImage(
                        shiftImages[index], index);
                  }),
            ),
            //SizedBox(height: sizedBoxFormHeight),
            SizedBox(height: 0.5),
            Container(
              height: containerHeight,
              width: containerWidth,
              //margin: EdgeInsets.only(top: 1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lime,
              ),
              child: RaisedButton(
                //padding: EdgeInsets.all(15.0),
                child: Text(
                  '日付を選',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                color: Colors.lime,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                onPressed: () {
                  //!Commented for Dev purposes
                  /*  NavigationRouter.switchToServiceProviderSecondScreen(
                        context); */
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('プロフィール画像を選択してください。'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('プロフィール写真を撮ってください。'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    final image = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    setState(() {
      _shiftImage = image;
      shiftImages.add(_shiftImage.path);
      uploadVisible = false;
    });
    print('image path : ${_shiftImage.path}');
  }

  _imgFromGallery() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _shiftImage = image;
      shiftImages.add(_shiftImage.path);
      uploadVisible = false;
    });
    print('image path : ${_shiftImage.path}');
  }

  Widget buildShiftImage(String privateQualificationImage, int index) {
    Size size = MediaQuery.of(context).size;
    double containerWidth = size.width * 0.9;
    return Container(
      //padding: EdgeInsets.only(left: index == 0 ? 0.0 : 16.0),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                    width: containerWidth,
                    height: 250.0,
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(File(privateQualificationImage)),
                      ),
                    )),
              ),
              Positioned(
                  right: 10,
                  top: 10,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          shiftImages.removeAt(index);
                        });
                      },
                      child: CircleAvatar(
                        //radius: 15.0,
                        backgroundColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      )))
            ],
          ),
          SizedBox(height: sizedBoxFormHeight),
          //Text("民間資格"),
        ],
      ),
    );
  }

  _buildWidget(String language, int index) {
    bool isSelected = _selectedIndex == index;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: isSelected
                ? Colors.blue[300].withOpacity(0.8)
                : Colors.grey[700]),
        color: Colors.grey[900],
      ),
      child: Text(
        language,
        style: TextStyle(
            fontSize: 16, color: isSelected ? Colors.blue[400] : null),
      ),
    );
  }

}
