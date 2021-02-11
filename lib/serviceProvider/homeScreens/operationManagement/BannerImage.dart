import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/loginResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BannerImage extends StatefulWidget {
  @override
  _BannerImageState createState() => _BannerImageState();
}

class _BannerImageState extends State<BannerImage> {
  double sizedBoxFormHeight = 15.0;
  PickedFile _shiftImage;
  bool uploadVisible = false;
  var bannerUpload;
  Map<String, String> shiftImages = Map<String, String>();
  Data userData;
  int status = 0;

  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerHeight =
        45.0; //height of Every TextFormField wrapped with container
    double containerWidth =
        size.width * 0.9; //width of Every TextFormField wrapped with container
    return status == 0
        ? Container(color: Colors.white)
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: sizedBoxFormHeight),
                Container(
                  //height: containerHeight,
                  width: containerWidth,
                  child: Text('掲載する店舗・施術風景等の写真をアレンジできます。\n アップロードできる写真は5枚までです。',
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
                                  border: Border.all(
                                      width: 2, color: Colors.black12)),
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
                        String key = shiftImages.keys.elementAt(index);
                        return buildShiftImage(key, index);
                      }),
                ),
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
                    child: Text(
                      '日付を選',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.lime,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 100.0),
              ],
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
      //  shiftImages.add(_shiftImage.path);
      uploadVisible = false;
    });
    print('image path : ${_shiftImage.path}');
  }

  _imgFromGallery() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _shiftImage = image;
      //  shiftImages.add(_shiftImage.path);
      uploadVisible = false;
    });
    print('image path : ${_shiftImage.path}');
  }

  Widget buildShiftImage(String bannerImage, int index) {
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
                        image: NetworkImage(shiftImages[bannerImage]),
                      ),
                    )),
              ),
              Positioned(
                  right: 10,
                  top: 10,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          //  shiftImages.removeAt(index);
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

  getProfileDetails() async {
    if (HealingMatchConstants.userData != null) {
      userData = HealingMatchConstants.userData;
      bannerUpload = userData.banners[0].toJson();
      bannerUpload.remove('id');
      bannerUpload.remove('userId');
      bannerUpload.remove('createdAt');
      bannerUpload.remove('updatedAt');
      bannerUpload.forEach((key, value) async {
        if (bannerUpload[key] != null) {
          shiftImages[key] = value;
        }
      });
      print('a');
      setState(() {
        status = 1;
      });
    } else {
      ProgressDialogBuilder.showCommonProgressDialog(context);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userData =
          Data.fromJson(json.decode(sharedPreferences.getString("userData")));
      bannerUpload = userData.banners[0].toJson();
      bannerUpload.remove('id');
      bannerUpload.remove('userId');
      bannerUpload.remove('createdAt');
      bannerUpload.remove('updatedAt');
      bannerUpload.forEach((key, value) async {
        if (bannerUpload[key] != null) {
          shiftImages[key] = value;
        }
      });
      setState(() {
        status = 1;
      });
      ProgressDialogBuilder.hideCommonProgressDialog(context);
    }
  }
}
