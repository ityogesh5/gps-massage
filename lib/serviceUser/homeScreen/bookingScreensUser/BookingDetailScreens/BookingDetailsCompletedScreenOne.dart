import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customFavoriteButton/CustomHeartFavorite.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetUserDetails.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_type_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_bloc.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_state.dart';
import 'package:simple_tooltip/simple_tooltip.dart';
import 'package:toast/toast.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
List<String> _options = [
  'エステ',
  '脱毛（女性・全身）',
  '骨盤矯正',
  'ロミロミ（全身）',
  'ホットストーン（全身）',
  'カッピング（全身）',
  'リラクゼーション'
];
double ratingsValue = 4.0;
var certificateUpload;
var certificateUploadKeys;
Map<String, String> certificateImages = Map<String, String>();

class DetailBloc extends StatefulWidget {
  final userID;

  DetailBloc(this.userID);

  @override
  _DetailBlocState createState() => _DetailBlocState();
}

class _DetailBlocState extends State<DetailBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: BlocProvider(
        create: (context) => TherapistTypeBloc(
            getTherapistTypeRepository: GetTherapistTypeRepositoryImpl()),
        child: DetailPageListner(widget.userID),
      ),
    );
  }
}

class DetailPageListner extends StatefulWidget {
  final userID;

  DetailPageListner(this.userID);

  @override
  _DetailPageListnerState createState() => _DetailPageListnerState();
}

class _DetailPageListnerState extends State<DetailPageListner> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getTherapistDetails(widget.userID);
    getTherapist();
  }

  getTherapist() {
    try {
      BlocProvider.of<TherapistTypeBloc>(context)
          .add(DetailEvent(HealingMatchConstants.accessToken, widget.userID));
      print('AccessToken : ${HealingMatchConstants.accessToken}');
      print('UserId : ${widget.userID}');
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<TherapistTypeBloc, TherapistTypeState>(
        listener: (context, state) {
          if (state is GetTherapistTypeErrorState) {
            return DetailPageError();
          }
        },
        child: BlocBuilder<TherapistTypeBloc, TherapistTypeState>(
            builder: (context, state) {
          if (state is GetTherapistId) {
            return BookingDetailsCompletedScreenOne(
                state.getTherapistByIdModel, widget.userID);
          } else {
            print('error somewhere');
          }
        }),
      ),
    );
  }
}

class BookingDetailsCompletedScreenOne extends StatefulWidget {
  final userID;
  TherapistByIdModel getTherapistByIdModel;

  BookingDetailsCompletedScreenOne(this.getTherapistByIdModel, this.userID);

  @override
  _BookingDetailsCompletedScreenOneState createState() =>
      _BookingDetailsCompletedScreenOneState();
}

class _BookingDetailsCompletedScreenOneState
    extends State<BookingDetailsCompletedScreenOne> {
  int _massageValue = 0;
  var _value = '';
  int massageTipColor;
  int strechTipColor;
  int cuppingTipColor;
  int maternityTipColor;
  int babyTipColor;
  GlobalKey<FormState> _userDetailsFormKey = new GlobalKey<FormState>();
  var therapistAddress, userRegisteredAddress, userPlaceForMassage;
  bool shopLocationSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTherapistCertificate(widget.getTherapistByIdModel);
    getTherapistDetails(widget.userID);
    /*   BlocProvider.of<TherapistTypeBloc>(context)
        .add(DetailEvent(HealingMatchConstants.accessToken, widget.userID));*/
  }

  getTherapistCertificate(TherapistByIdModel getTherapistByIdModel) async {
    print('Hi');
    try {
      if (this.mounted) {
        setState(() {
          if (getTherapistByIdModel.data.certificationUploads != null) {
            for (int j = 0;
                j < getTherapistByIdModel.data.certificationUploads.length;
                j++) {
              print('Hiiii');
              print(
                  'Certificate upload type : ${certificateUpload = getTherapistByIdModel.data.certificationUploads[j].toJson()}');

              certificateUploadKeys = certificateUpload[j].toJson();
              certificateUploadKeys.remove('id');
              certificateUploadKeys.remove('userId');
              certificateUploadKeys.remove('createdAt');
              certificateUploadKeys.remove('updatedAt');
              print('Keys certificate type : $certificateUploadKeys');
            }
          }
          certificateUploadKeys.forEach((key, value) async {
            if (certificateUploadKeys[key] != null) {
              String jKey = getQualificationJPWordsForType(key);
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
          print('certificateImages data type : $certificateImages');
        });
      }
    } catch (e) {}
  }

  String getQualificationJPWordsForType(String key) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _userDetailsFormKey,
          child: Container(
            child: ListView(
              padding: MediaQuery.of(context).padding * 0.84,
              physics: BouncingScrollPhysics(),
              children: [
                CarouselWithIndicatorDemo(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 12,
                              backgroundColor: Colors.black45,
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundColor:
                                    Color.fromRGBO(255, 255, 255, 1),
                                child: SvgPicture.asset(
                                    'assets/images_gps/serviceTypeOne.svg',
                                    height: 15,
                                    width: 15),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.01),
                            Text('エステ'),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 12,
                              backgroundColor: Colors.black45,
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundColor:
                                    Color.fromRGBO(255, 255, 255, 1),
                                child: SvgPicture.asset(
                                    'assets/images_gps/serviceTypeTwo.svg',
                                    height: 15,
                                    width: 15),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.01),
                            Text('整骨・整体'),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 12,
                              backgroundColor: Colors.black45,
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundColor:
                                    Color.fromRGBO(255, 255, 255, 1),
                                child: SvgPicture.asset(
                                    'assets/images_gps/serviceTypeThree.svg',
                                    height: 15,
                                    width: 15),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.01),
                            Text('リラクゼーション'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: widget.getTherapistByIdModel.data
                                      .uploadProfileImgUrl !=
                                  null
                              ? CachedNetworkImage(
                                  imageUrl: widget.getTherapistByIdModel.data
                                      .uploadProfileImgUrl,
                                  filterQuality: FilterQuality.high,
                                  fadeInCurve: Curves.easeInSine,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      SpinKitDoubleBounce(
                                          color: Colors.lightGreenAccent),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: 80.0,
                                    height: 80.0,
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
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: new AssetImage(
                                          'assets/images_gps/logo.png'),
                                    ),
                                  )),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget
                                          .getTherapistByIdModel.data.userName,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    FittedBox(
                                      child: Row(
                                        children: [
                                          widget.getTherapistByIdModel.data
                                                      .businessForm
                                                      .contains(
                                                          '施術店舗あり 施術従業員あり') ||
                                                  widget.getTherapistByIdModel
                                                      .data.businessForm
                                                      .contains(
                                                          '施術店舗あり 施術従業員なし（個人経営）') ||
                                                  widget.getTherapistByIdModel
                                                      .data.businessForm
                                                      .contains(
                                                          '施術店舗なし 施術従業員なし（個人)')
                                              ? Visibility(
                                                  visible: true,
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                              ]),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text('店舗')),
                                                )
                                              : Container(),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Visibility(
                                            visible: widget
                                                .getTherapistByIdModel
                                                .data
                                                .businessTrip,
                                            child: Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                        ]),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                      color: Colors.grey[300],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color: Colors.grey[200]),
                                                child: Text('出張')),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Visibility(
                                            visible: widget
                                                .getTherapistByIdModel
                                                .data
                                                .coronaMeasure,
                                            child: Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                        ]),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                      color: Colors.grey[300],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color: Colors.grey[200]),
                                                child: Text('コロナ対策実施有無')),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                children: [
                                  // widget.getTherapistByIdModel.data.
                                  Text(
                                    '(${ratingsValue.toString()})',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14,
                                        fontFamily: 'NotoSansJP'),
                                  ),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 25,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      size: 5,
                                      color: Color.fromRGBO(255, 217, 0, 1),
                                    ),
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                      setState(() {
                                        ratingsValue = rating;
                                      });
                                      print(ratingsValue);
                                    },
                                  ),
                                  Text(
                                    '(1518)',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 12,
                                        fontFamily: 'NotoSansJP'),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: InkWell(
                                      onTap: () {
                                        NavigationRouter
                                            .switchToServiceUserDisplayReviewScreen(
                                                context);
                                      },
                                      child: Text(
                                        'もっとみる',
                                        style: TextStyle(
                                            fontFamily: 'NotoSansJP',
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 14),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(4),
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
                              child: Text('女性のみ予約可')),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(4),
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
                              child: Text('キッズスペース有')),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              padding: EdgeInsets.all(4),
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
                              child: Text('保育士常駐')),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(4),
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
                              child: Text('国家資格')),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              padding: EdgeInsets.all(4),
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
                              child: Text('民間資格')),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              padding: EdgeInsets.all(4),
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
                              child: Text('国家資格')),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              padding: EdgeInsets.all(4),
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
                              child: Text('民間資格')),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
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
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.grey[200]),
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.16,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset('assets/images_gps/gps.svg',
                                      height: 25, width: 25),
                                  SizedBox(width: 5),
                                  new Text(
                                    '住所:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'NotoSansJP'),
                                  ),
                                  SizedBox(width: 5),
                                  new Text(
                                    '東京都',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                        fontFamily: 'NotoSansJP'),
                                  ),
                                  SizedBox(width: 5),
                                  new Text(
                                    '墨田区',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                        fontFamily: 'NotoSansJP'),
                                  ),
                                  SizedBox(width: 5),
                                  new Text(
                                    '押上',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                        fontFamily: 'NotoSansJP'),
                                  ),
                                  SizedBox(width: 5),
                                  new Text(
                                    '1-1-2',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                        fontFamily: 'NotoSansJP'),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                      'assets/images_gps/clock.svg',
                                      height: 25,
                                      width: 25),
                                  SizedBox(width: 5),
                                  new Text(
                                    '営業時間:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'NotoSansJP'),
                                  ),
                                  SizedBox(width: 5),
                                  new Text(
                                    '10:30 ～ 11:30',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                        fontFamily: 'NotoSansJP'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Divider(),
                  )),
                ]),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'メッセージ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'NotoSansJP'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            text: new TextSpan(
                              text: '${HealingMatchConstants.sampleText}',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[400],
                                  fontFamily: 'NotoSansJP'),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'もっとみる',
                                    style: new TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: 'NotoSansJP',
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Divider(),
                  )),
                ]),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '施術を受ける場所',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSansJP'),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: WidgetAnimator(
                    TextFormField(
                      //display the address
                      readOnly: true,
                      autofocus: false,
                      decoration: new InputDecoration(
                        //hintText: HealingMatchConstants.userRegisteredAddressDetail,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.03),
                              Flexible(
                                  child: shopLocationSelected
                                      ? new Text(
                                          '$therapistAddress',
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.15),
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
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      '受けたい施術を選んでください',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'NotoSansJP'),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() {
                              _massageValue = 0;
                              _massageValue != null ? _value = '' : _value;
                            }),
                            child: Column(
                              children: [
                                Card(
                                  elevation: _massageValue == 0 ? 4.0 : 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _massageValue == 0
                                          ? Color.fromRGBO(242, 242, 242, 1)
                                          : Color.fromRGBO(255, 255, 255, 1),
                                      border: Border.all(
                                        color: _massageValue == 0
                                            ? Color.fromRGBO(102, 102, 102, 1)
                                            : Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/serviceTypeOne.svg',
                                        color: _massageValue == 0
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
                          GestureDetector(
                            onTap: () => setState(() {
                              _massageValue = 1;
                              _massageValue != null ? _value = '' : _value;
                            }),
                            //onTap: () => setState(() => _massageValue = 1),
                            child: Column(
                              children: [
                                Card(
                                  elevation: _massageValue == 1 ? 4.0 : 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _massageValue == 1
                                          ? Color.fromRGBO(242, 242, 242, 1)
                                          : Color.fromRGBO(255, 255, 255, 1),
                                      border: Border.all(
                                        color: _massageValue == 1
                                            ? Color.fromRGBO(102, 102, 102, 1)
                                            : Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/serviceTypeTwo.svg',
                                        color: _massageValue == 1
                                            ? Color.fromRGBO(0, 0, 0, 1)
                                            : Color.fromRGBO(217, 217, 217, 1),
                                        height: 33,
                                        width: 34,
                                      ),
                                    ),
                                  ),
                                ),
                                /*  Text(
                                        HealingMatchConstants.searchOsthepaticTxt,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: _value == 1
                                              ? Color.fromRGBO(0, 0, 0, 1)
                                              : Color.fromRGBO(217, 217, 217, 1),
                                        ),
                                      ), */
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() {
                              _massageValue = 2;
                              _massageValue != null ? _value = '' : _value;
                            }),
                            // onTap: () => setState(() => _massageValue = 2),
                            child: Column(
                              children: [
                                Card(
                                  elevation: _massageValue == 2 ? 4.0 : 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _massageValue == 2
                                          ? Color.fromRGBO(242, 242, 242, 1)
                                          : Color.fromRGBO(255, 255, 255, 1),
                                      border: Border.all(
                                        color: _massageValue == 2
                                            ? Color.fromRGBO(102, 102, 102, 1)
                                            : Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/serviceTypeThree.svg',
                                        color: _massageValue == 2
                                            ? Color.fromRGBO(0, 0, 0, 1)
                                            : Color.fromRGBO(217, 217, 217, 1),
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ),
                                ),
/*                                 Text(
                                        HealingMatchConstants.searchRelaxationTxt,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: _value == 2
                                              ? Color.fromRGBO(0, 0, 0, 1)
                                              : Color.fromRGBO(217, 217, 217, 1),
                                        ),
                                      ), */
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() {
                              _massageValue = 3;
                              _massageValue != null ? _value = '' : _value;
                            }),
                            // onTap: () => setState(() => _massageValue = 3),
                            child: Column(
                              children: [
                                Card(
                                  elevation: _massageValue == 3 ? 4.0 : 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _massageValue == 3
                                          ? Color.fromRGBO(242, 242, 242, 1)
                                          : Color.fromRGBO(255, 255, 255, 1),
                                      border: Border.all(
                                        color: _massageValue == 3
                                            ? Color.fromRGBO(102, 102, 102, 1)
                                            : Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/serviceTypeFour.svg',
                                        color: _massageValue == 3
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              HealingMatchConstants.searchEsteticTxt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: _massageValue == 0
                                    ? Color.fromRGBO(0, 0, 0, 1)
                                    : Color.fromRGBO(217, 217, 217, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              HealingMatchConstants.searchOsthepaticTxt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: _massageValue == 1
                                    ? Color.fromRGBO(0, 0, 0, 1)
                                    : Color.fromRGBO(217, 217, 217, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              HealingMatchConstants.searchRelaxationTxt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: _massageValue == 2
                                    ? Color.fromRGBO(0, 0, 0, 1)
                                    : Color.fromRGBO(217, 217, 217, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              HealingMatchConstants.searchFitnessTxt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: _massageValue == 3
                                    ? Color.fromRGBO(0, 0, 0, 1)
                                    : Color.fromRGBO(217, 217, 217, 1),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _value = '0'),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: SimpleTooltip(
                              show: _value == '0' ? true : false,
                              tooltipDirection: TooltipDirection.right,
                              hideOnTooltipTap: true,
                              borderWidth: 0.1,
                              borderColor: Color.fromRGBO(228, 228, 228, 1),
                              borderRadius: 10.0,
                              minHeight: 50,
                              minWidth: 305,
                              content: Stack(
                                children: [
                                  Positioned(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        /* CircleAvatar(
                                    radius: 14.0,
                                    backgroundColor: Color.fromRGBO(242, 242, 242, 1),
                                    child: Icon(Icons.close, color: Colors.black),
                                  ),*/
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => massageTipColor = 1),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: massageTipColor ==
                                                              1
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '60分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => massageTipColor = 2),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: massageTipColor ==
                                                              2
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '90分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => massageTipColor = 3),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: massageTipColor ==
                                                              3
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '120分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => massageTipColor = 4),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: massageTipColor ==
                                                              4
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '150分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => massageTipColor = 5),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: massageTipColor ==
                                                              5
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '180分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: -4,
                                    top: -4,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  217, 217, 217, 1),
                                              blurRadius:
                                                  8.0, // soften the shadow
                                              spreadRadius:
                                                  1, //extend the shadow
                                              offset: Offset(
                                                0.0,
                                                // Move to right 10  horizontally
                                                3.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          radius: 10.0,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _value == '0'
                                          ? Color.fromRGBO(242, 242, 242, 1)
                                          : Color.fromRGBO(255, 255, 255, 1),
                                      border: Border.all(
                                        color: _value == '0'
                                            ? Color.fromRGBO(102, 102, 102, 1)
                                            : Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/Massage.svg',
                                        color: _value == '0'
                                            ? Color.fromRGBO(0, 0, 0, 1)
                                            : Color.fromRGBO(217, 217, 217, 1),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'マッサージ',
                                    style: TextStyle(
                                      color: _value == '0'
                                          ? Color.fromRGBO(0, 0, 0, 1)
                                          : Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  ),
                                  Text(
                                    '（全身）',
                                    style: TextStyle(
                                      color: _value == '0'
                                          ? Color.fromRGBO(0, 0, 0, 1)
                                          : Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _value = '1'),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: SimpleTooltip(
                              show: _value.contains('1') ? true : false,
                              tooltipDirection: TooltipDirection.down,
                              hideOnTooltipTap: true,
                              borderWidth: 0.1,
                              borderColor: Color.fromRGBO(228, 228, 228, 1),
                              borderRadius: 10.0,
                              minHeight: 50,
                              minWidth: 305,
                              content: Stack(
                                children: [
                                  Positioned(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => strechTipColor = 1),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: strechTipColor == 1
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '60分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => strechTipColor = 2),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: strechTipColor == 2
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '90分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => strechTipColor = 3),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: strechTipColor == 3
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '120分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => strechTipColor = 4),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: strechTipColor == 4
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '150分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => strechTipColor = 5),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: strechTipColor == 5
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '180分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: -4,
                                    top: -4,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.1),
                                              blurRadius:
                                                  10.0, // soften the shadow
                                              spreadRadius:
                                                  2, //extend the shadow
                                              offset: Offset(
                                                0.0,
                                                // Move to right 10  horizontally
                                                3.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          radius: 10.0,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _value.contains('1')
                                          ? Color.fromRGBO(242, 242, 242, 1)
                                          : Color.fromRGBO(255, 255, 255, 1),
                                      border: Border.all(
                                        color: _value.contains('1')
                                            ? Color.fromRGBO(102, 102, 102, 1)
                                            : Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                          'assets/images_gps/stretch.svg',
                                          color: _value.contains('1')
                                              ? Color.fromRGBO(0, 0, 0, 1)
                                              : Color.fromRGBO(
                                                  217, 217, 217, 1),
                                        )),
                                  ),
                                  Text(
                                    'ストレッチ',
                                    style: TextStyle(
                                      color: _value.contains('1')
                                          ? Color.fromRGBO(0, 0, 0, 1)
                                          : Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  ),
                                  Text(
                                    '（全身）',
                                    style: TextStyle(
                                      color: _value.contains('1')
                                          ? Color.fromRGBO(0, 0, 0, 1)
                                          : Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _value = '2'),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: SimpleTooltip(
                              show: _value == '2' ? true : false,
                              tooltipDirection: TooltipDirection.down,
                              hideOnTooltipTap: true,
                              borderWidth: 0.1,
                              borderColor: Color.fromRGBO(228, 228, 228, 1),
                              borderRadius: 10.0,
                              minHeight: 50,
                              minWidth: 305,
                              content: Stack(
                                children: [
                                  Positioned(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => cuppingTipColor = 1),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: cuppingTipColor ==
                                                              1
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '60分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => cuppingTipColor = 2),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: cuppingTipColor ==
                                                              2
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '90分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => cuppingTipColor = 3),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: cuppingTipColor ==
                                                              3
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '120分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => cuppingTipColor = 4),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: cuppingTipColor ==
                                                              4
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '150分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => cuppingTipColor = 5),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: cuppingTipColor ==
                                                              5
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '180分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: -4,
                                    top: -4,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.1),
                                              blurRadius:
                                                  10.0, // soften the shadow
                                              spreadRadius:
                                                  2, //extend the shadow
                                              offset: Offset(
                                                0.0,
                                                // Move to right 10  horizontally
                                                3.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          radius: 10.0,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _value == '2'
                                          ? Color.fromRGBO(242, 242, 242, 1)
                                          : Color.fromRGBO(255, 255, 255, 1),
                                      border: Border.all(
                                        color: _value == '2'
                                            ? Color.fromRGBO(102, 102, 102, 1)
                                            : Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/Cupping.svg',
                                        color: _value == '2'
                                            ? Color.fromRGBO(0, 0, 0, 1)
                                            : Color.fromRGBO(217, 217, 217, 1),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'カッピング',
                                    style: TextStyle(
                                      color: _value == '2'
                                          ? Color.fromRGBO(0, 0, 0, 1)
                                          : Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  ),
                                  Text(
                                    '（全身）',
                                    style: TextStyle(
                                      color: _value == '2'
                                          ? Color.fromRGBO(0, 0, 0, 1)
                                          : Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _value = '3'),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: SimpleTooltip(
                              show: _value == '3' ? true : false,
                              tooltipDirection: TooltipDirection.down,
                              hideOnTooltipTap: true,
                              borderWidth: 0.1,
                              borderColor: Color.fromRGBO(228, 228, 228, 1),
                              borderRadius: 10.0,
                              minHeight: 50,
                              minWidth: 305,
                              content: Stack(
                                children: [
                                  Positioned(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () => setState(() =>
                                                    maternityTipColor = 1),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          maternityTipColor == 1
                                                              ? Color.fromRGBO(
                                                                  242,
                                                                  242,
                                                                  242,
                                                                  1)
                                                              : Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '60分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(() =>
                                                    maternityTipColor = 2),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          maternityTipColor == 2
                                                              ? Color.fromRGBO(
                                                                  242,
                                                                  242,
                                                                  242,
                                                                  1)
                                                              : Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '90分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(() =>
                                                    maternityTipColor = 3),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          maternityTipColor == 3
                                                              ? Color.fromRGBO(
                                                                  242,
                                                                  242,
                                                                  242,
                                                                  1)
                                                              : Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '120分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(() =>
                                                    maternityTipColor = 4),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          maternityTipColor == 4
                                                              ? Color.fromRGBO(
                                                                  242,
                                                                  242,
                                                                  242,
                                                                  1)
                                                              : Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '150分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(() =>
                                                    maternityTipColor = 5),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          maternityTipColor == 5
                                                              ? Color.fromRGBO(
                                                                  242,
                                                                  242,
                                                                  242,
                                                                  1)
                                                              : Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '180分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: -4,
                                    top: -4,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.1),
                                              blurRadius:
                                                  10.0, // soften the shadow
                                              spreadRadius:
                                                  2, //extend the shadow
                                              offset: Offset(
                                                0.0,
                                                // Move to right 10  horizontally
                                                3.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          radius: 10.0,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _value == '3'
                                          ? Color.fromRGBO(242, 242, 242, 1)
                                          : Color.fromRGBO(255, 255, 255, 1),
                                      border: Border.all(
                                        color: _value == '3'
                                            ? Color.fromRGBO(102, 102, 102, 1)
                                            : Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/Maternity.svg',
                                        color: _value == '3'
                                            ? Color.fromRGBO(0, 0, 0, 1)
                                            : Color.fromRGBO(217, 217, 217, 1),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'マタニティ',
                                    style: TextStyle(
                                      color: _value == '3'
                                          ? Color.fromRGBO(0, 0, 0, 1)
                                          : Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(
                                      color: _value == '3'
                                          ? Color.fromRGBO(0, 0, 0, 1)
                                          : Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _value = '4'),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: SimpleTooltip(
                              show: _value == '4' ? true : false,
                              tooltipDirection: TooltipDirection.left,
                              hideOnTooltipTap: true,
                              borderWidth: 0.1,
                              borderColor: Color.fromRGBO(228, 228, 228, 1),
                              borderRadius: 10.0,
                              minHeight: 50,
                              minWidth: 305,
                              content: Stack(
                                children: [
                                  Positioned(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => babyTipColor = 1),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: babyTipColor == 1
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '60分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => babyTipColor = 2),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: babyTipColor == 2
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '90分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => babyTipColor = 3),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: babyTipColor == 3
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '120分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => babyTipColor = 4),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: babyTipColor == 4
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '150分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () => setState(
                                                    () => babyTipColor = 5),
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: babyTipColor == 5
                                                          ? Color.fromRGBO(
                                                              242, 242, 242, 1)
                                                          : Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      border: Border.all(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images_gps/processing.svg',
                                                                  height: 25,
                                                                  width: 25,
                                                                  color: Colors
                                                                      .black),
                                                              SizedBox(
                                                                  width: 5),
                                                              new Text(
                                                                '180分',
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'NotoSansJP',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        new Text(
                                                          '\t¥4,500',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: -4,
                                    top: -4,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.1),
                                              blurRadius:
                                                  10.0, // soften the shadow
                                              spreadRadius:
                                                  2, //extend the shadow
                                              offset: Offset(
                                                0.0,
                                                // Move to right 10  horizontally
                                                3.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          radius: 10.0,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _value == '4'
                                          ? Color.fromRGBO(242, 242, 242, 1)
                                          : Color.fromRGBO(255, 255, 255, 1),
                                      border: Border.all(
                                        color: _value == '4'
                                            ? Color.fromRGBO(102, 102, 102, 1)
                                            : Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                          'assets/images_gps/Baby.svg',
                                          color: _value == '4'
                                              ? Color.fromRGBO(0, 0, 0, 1)
                                              : Color.fromRGBO(
                                                  217, 217, 217, 1),
                                        )),
                                  ),
                                  Text(
                                    'ベビーマッサ',
                                    style: TextStyle(
                                      color: _value == '4'
                                          ? Color.fromRGBO(0, 0, 0, 1)
                                          : Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(
                                      color: _value == '4'
                                          ? Color.fromRGBO(0, 0, 0, 1)
                                          : Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      '施術を受ける日時',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'NotoSansJP'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.grey[200]),
                    width: MediaQuery.of(context).size.width * 0.89,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 2,
                        ),
                        new Text(
                          'サービスを受ける日時を\nカレンダーから選択してください',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'NotoSansJP',
                              color: Colors.grey[500]),
                        ),
                        Spacer(),
                        FittedBox(
                          child: CircleAvatar(
                              maxRadius: 30,
                              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                              child: SvgPicture.asset(
                                  'assets/images_gps/calendar.svg',
                                  height: 25,
                                  width: 25,
                                  color: Colors.lime)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bookAgain(),
    );
  }

  Widget bookAgain() {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          //side: BorderSide(color: Colors.black),
        ),
        color: Colors.red,
        onPressed: () {
          /*NavigationRouter.switchToServiceUserBookingConfirmationScreen(
              context);*/
        },
        child: new Text(
          'もう一度予約する',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }

  // Edit address dialog
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
                    _userDetailsFormKey.currentState.save();
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
}

//Build Carousel images for banner
class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOutCubic,
                  enlargeCenterPage: false,
                  viewportFraction: 1.02,
                  aspectRatio: 1.5,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ]),
        ),
        Positioned(
          top: 30.0,
          left: 20.0,
          right: 20.0,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleAvatar(
              maxRadius: 18,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {
                  NavigationRouter.switchToServiceUserBottomBar(context);
                },
              ),
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: Colors.white,
                  child: CustomFavoriteButton(
                      iconSize: 40,
                      iconColor: Colors.red,
                      valueChanged: (_isFavorite) {
                        print('Is Favorite : $_isFavorite');
                      }),
                ),
              ],
            ),
          ]),
        ),
        Positioned(
          bottom: 5.0,
          left: 50.0,
          right: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: HealingMatchConstants.userBannerImages.map((url) {
              int index = HealingMatchConstants.userBannerImages.indexOf(url);
              return Expanded(
                child: Container(
                  width: 45.0,
                  height: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
// shape: BoxShape.circle,
                    color: _current == index
                        ? Colors.white //Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

final List<Widget> imageSliders = HealingMatchConstants.userBannerImages
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(40.0),
                ),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 2000.0),
                  ],
                )),
          ),
        ))
    .toList();

class DetailPageError extends StatefulWidget {
  @override
  _DetailPageErrorState createState() => _DetailPageErrorState();
}

class _DetailPageErrorState extends State<DetailPageError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Error'),
      ),
    );
  }
}
