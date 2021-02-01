import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/messageServicePriceModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class HealingMatchConstants {
// ON-PREMISE API URLS == http://106.51.49.160:9092/api/
// DOMAIN URL'S
  //static const String SEARCH_USER_PROFILE_DETAILS_URL = DOMAIN_BASE_URL + "/search";

  static const String ON_PREMISE_USER_BASE_URL =
      "http://106.51.49.160:9094/api";
  static const String REGISTER_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/user/registerProvider';
  static const String STATE_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/prefecture' + '/getAllPrefecture';
  static const String CITY_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/cities' + '/getCitieByPrefectureId';
  static const String ESTHETIC_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/esthetic/getAllEsthetic';
  static const String RELAXATION_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/relaxation/getAllRelaxation';
  static const String TREATMENT_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/osteopathic/getAllOsteopathic';
  static const String FITNESS_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/fitness/getAllFitness';
  static const String REGISTER_PROVIDER_BANNER_UPLOAD_URL =
      ON_PREMISE_USER_BASE_URL + '/user/bannerUpload';
  static const String REGISTER_PROVIDER_GET_BANK_LIST_URL =
      ON_PREMISE_USER_BASE_URL + '/bankList/getAllBankList';
  static const String SEND_VERIFY_USER_URL =
      ON_PREMISE_USER_BASE_URL + '/user/sendVerify';
  static const String CHANGE_PASSWORD_VERIFY_USER_URL =
      ON_PREMISE_USER_BASE_URL + '/user/resetPassword';
  static const String CHANGE_PASSWORD_VERIFY_OTP_URL =
      ON_PREMISE_USER_BASE_URL + '/user/verifyOtp';

  // register service user
  static const String REGISTER_USER_URL =
      ON_PREMISE_USER_BASE_URL + '/user' + '/registerUser';

  // login service user
  static const String LOGIN_USER_URL =
      ON_PREMISE_USER_BASE_URL + '/user' + '/signin';

  //Common string
  static String registerProgressText = '登録中...';
  static String locationProgressText = '現在地を取得中...';
  static String getCityProgressText = '府県の市のデータを取得中。。。';
  static String getLoginProgressText = 'ログイン中。。。';
  static bool isUserRegistrationSkipped = false;
  static bool isUserRegistered = false;
  static bool isUserVerified = false;

  //UserForget Password
  static const String userPasswordPhn = "電話番号 *";
  static var userPhnNum = '';
  static var userForgetPassBtn = '送信';
  static const String userPasswordTxt =
      "パスワードを再設定するための認証コードを\n送信しますので、ご登録の電話番号を入力の上\n「送信」ボタンをクリックしてください";

  //Register Service User Screen Constants
  static String serviceUserName = '';
  static String serviceUserDOB = '';
  static String serviceUserGender = '';
  static String serviceUserOccupation = '';
  static String serviceUserAge = '';
  static String serviceUserPhoneNumber = '';
  static String serviceUserEmailAddress = '';
  static String serviceUserAddressType = '';
  static String serviceUserMassagePlace = '';
  static String serviceUserPrefecture = '';
  static String serviceUserCity = '';
  static String serviceUserBuildingName = '';
  static String serviceUserArea = '';
  static int serviceUserRoomNumber = 0; //gpsAddress
  static String userAddress = '';
  static double currentLatitude = 0.0;
  static double currentLongitude = 0.0;

  // User Register otp
  static String serviceUserOtpTxt = 'に届いた「認証コード」を入力し、\n「確認」ボタンをクリックしてください。';
  static String serviceUserOtpBtn = '確認';
  static String serviceResendOtpTxt = '認証コードを再送する';

  //Register Service Provider Screen Constants
  static PickedFile profileImage;
  static String serviceProviderUserName = '';
  static String serviceProviderStoreName = '';
  static String serviceProviderDOB = '';
  static String serviceProviderAge = '';
  static String serviceProviderGender = '';
  static String serviceProviderPhoneNumber = '';
  static String serviceProviderStorePhoneNumber = '';
  static String serviceProviderEmailAddress = '';
  static String serviceProviderAddressType = '';
  static String serviceProviderPrefecture = '';
  static String serviceProviderCity = '';
  static String serviceProviderBuildingName = '';
  static String serviceProviderArea = '';
  static String serviceProviderRoomNumber = '';
  static String serviceProviderAddress = '';
  static double serviceProviderCurrentLatitude = 0.0;
  static double serviceProviderCurrentLongitude = 0.0;
  static String serviceProviderPassword = '';
  static String serviceProviderConfirmPassword = '';
  static String serviceProviderBusinessForm = '';
  static String serviceProviderNumberOfEmpl = '';
  static List<String> serviceProviderStoreType = List<String>();
  static String serviceProviderBusinessTripService = '';
  static String serviceProviderCoronaMeasure = '';
  static String serviceProviderGenderService = '';
  static List<String> serviceProviderChildrenMeasure = List<String>();
  static List<ServicePriceModel> estheticServicePriceModel =
      List<ServicePriceModel>();
  static List<ServicePriceModel> relaxationServicePriceModel =
      List<ServicePriceModel>();
  static List<ServicePriceModel> treatmentServicePriceModel =
      List<ServicePriceModel>();
  static List<ServicePriceModel> fitnessServicePriceModel =
      List<ServicePriceModel>();
  static List<String> selectedEstheticDropdownValues = List<String>();
  static List<String> selectedRelaxationDropdownValues = List<String>();
  static List<String> selectedTreatmentDropdownValues = List<String>();
  static List<String> selectedFitnessDropdownValues = List<String>();
  static List<String> otherEstheticDropDownValues = List<String>();
  static List<String> otherTreatmentDropDownValues = List<String>();
  static List<String> otherRelaxationDropDownValues = List<String>();
  static List<String> otherFitnessDropDownValues = List<String>();
  static List<Asset> bannerImages = List<Asset>();

  //userDefinedScreens
  static const String UserSelectFirtTxt = 'どちらで利用しますか？';
  static const String UserSelectLastTxt = 'セラピストで登録の場合はサービス利用者\nとしてもログイン可能です。';

  //LoginServiceProvider
  static const String loginText = 'セラピストのログイン';
  static const String loginPhoneNumber = '電話番号 ';
  static const String loginPassword = 'パスワード ';
  static const String loginForgetPassword = 'パスワードを忘れた方はこちら';
  static const String loginButton = 'ログイン';
  static const String loginNewRegistrationText = '新規の方はこちら';
  static const String loginServiceUser = 'サービス利用者のログイン';

  //LoginServiceUser
  static const String loginUserText = 'サービス利用者のログイン';
  static const String loginUserSkipText = 'スキップ';
  static const String loginUserPhoneNumber = '電話番号 ';
  static const String loginUserPassword = 'パスワード ';
  static const String loginUserForgetPassword = 'パスワードを忘れた方はこちら';
  static const String loginUserButton = 'ログイン';
  static const String loginUserNewRegistrationText = '新規の方はこちら';
  static const String loginServiceProvider = 'セラピストのログイン';

  //RegistrationServiceProvider
  static const String registrationFirstText = 'セラピスト情報の入力';
  static const String registrationSecondText = 'は必項目です';
  static const String registrationScndText = 'は必須項目';
  static const String registrationFacePhtoText =
      '利用者に安心していただく為にもなるべく顔の映った写真を使用しましょう';
  static const String registrationBuisnessForm = '事業形態';
  static const String registrationBuisnessTrip = '出張でのサービス対応可否';
  static const String registrationStoretype = 'お店の種類表示*';
  static const String registrationCoronaTxt = 'コロナ対策実施有無';
  static const String registrationChildrenTxt = '子供向け施策有無';
  static const String registrationJapanAssociationTxt =
      'マスクの着用、アルコール消毒の徹底、体温管理等日本\nリラクゼーション協会の定める項目を遵守している\n場合のみチェックください';
  static const String registrationName = 'お名前*';
  static const String registrationStoreTxt = '店舗として登録の場合は代表者の氏名を入力してください';
  static const String registrationStoreName = '店舗名*';
  static const String registrationDob = '生年月日*';
  static const String registrationAge = '年齢';
  static const String registrationGender = '性別';
  static const String registrationPhnNum = '電話番号*';
  static const String registrationStorePhnNum = '店舗の電話番号*';
  static const String registrationMailAdress = 'メールアドレス*';
  static const String registrationPassword = 'パスワード*';
  static const String registrationPasswordInstructionText = "半角英数8~16文字以内";
  static const String registrationConfirmPassword = 'パスワード再確認*';
  static const String registrationStorePhnText = '店舗として登録の場合は代表者の携帯番号を入力してください';
  static const String registrationIndividualText =
      '個人で登録の方は、住所の詳細情報が利用者に開示されることはありません。';
  static const String registrationBuildingName = '建物名*';
  static const String registrationRoomNo = '部屋番号*';
  static const String registrationPointTxt = '登録地点周辺のサービス利用者に優先的に検索されるようになります。';
  static const String registrationNextBtn = '次へ';

  static const String registrationIdentityVerification = '本人確認証を選択してください*';
  static const String registrationIdentityUpload = '本人確認書のアップロード*';
  static const String registrationAdd = '保有資格の種類を選択し、\n証明書をアップロードしてください。';
  static const String registrationQualificationDropdown = '保有資格を選択してください。*';
  static const String registrationQualificationUpload = 'ファイルをアップロードする';
  static const String registrationChooseServiceNavBtn = '提供サービスと料金設定';
  static const String registrationMultiPhotoUpload = '掲載写真のアップロード';
  static const String registrationBankDetails = '売り上げ振込先銀行口座';
  static const String registrationBankName = '銀行名*';
  static const String registrationBankBranchCode = '支店名';
  static const String registrationBankBranchNumber = '支店番号';
  static const String registrationBankAccountNumber = '口座番号';
  static const String registrationBankAccountType = '口座種類';
  static const String registrationCompleteBtn = '登録完了';
  static const String registrationAlreadyActTxt = 'すでにアカウントをお持ちの方';
  static const String registrationBankOtherDropdownFiled = "その他";

  //ChooseServiceScreen
  static const String chooseServiceFirstText = "提供するサービスを選択し料金を設定してください。";
  static const String chooseServiceEstheticDropDown = "エステ";
  static const String chooseServiceRelaxationDropDown = "リラクゼーション";
  static const String chooseServiceTreatmentDropDown = "整骨・整体";
  static const String chooseServiceFitnessDropDown = "フィットネス";
  static const String chooseServiceOtherDropdownFiled = "その他";
  static const String chooseServiceAddTextFormField = "入力してください";
  static const String chooseServiceAddtoDropdownButton = "追加";

  //Forget Password
  static const String forgetPasswordPhn = "電話番号 *";
  static var userPhoneNumber = '';
  static const String forgetPasswordTxt =
      "パスワードを再設定するための認証コードを\n送信しますので、ご登録の電話番号を入力の上\n「送信」ボタンをクリックしてください";

  //Change Password
  static const String changePasswordNewpass = "新しいパスワード *";
  static const String changePasswordTxt =
      "に届いた「認証コード」と\n 新しいパスワードを入力し、「パスワードを\n 再設定する」ボタンをクリックしてください。";
  static const String changePasswordConfirmpass = "パスワード(確認用) *";
  static const String changePasswordBtn = 'パスワードを再設定する';
  static const String changeResendOtp = '認証コードを再送する';

  //Edit Profile
  static const String profileUpdateBtn = '更新';

  // LINE Login Channel ID
  static const String clientLineChannelID = '1655556164';
  static const String demoLineChannelID = '1620019587';
  // Profile Edit screen user
  static Uint8List userEditProfile;
  static String userEditUserName = '';
  static String userEditPhoneNumber = '';
  static String userEditEmailAddress = '';
  static String userEditDob = '';
  static String userEditUserAge = '';
  static String userEditUserGender = '';
  static String userEditUserOccupation = '';
  static String userEditUserAddress = '';
  static String userEditBuildName = '';
  static String userEditRoomNo = '';
  static String userEditPlaceForMassage = '';
  static String userEditArea = '';

  static double addedCurrentLatitude = 0.0;
  static double addedCurrentLongitude = 0.0;
  static double manualAddressCurrentLatitude = 0.0;
  static double manualAddressCurrentLongitude = 0.0;
  static String addedServiceUserPrefecture = '';
  static String addedServiceUserCity = '';
  static String manualUserAddress = '';

  // User Profile screen
  //Uint8List profile image;
  static Uint8List profileImageInBytes;
  //FontStyle
  static const headersText = TextStyle(
    fontSize: 18.0,
    color: Colors.black,
  );

  static TextStyle formTextStyle = TextStyle(
      color: ColorConstants.formTextColor, fontFamily: 'Oxygen', fontSize: 14);

  static TextStyle formLabelTextStyle = TextStyle(
    fontSize: 14.0,
    fontFamily: 'Oxygen',
    color: ColorConstants.formHintTextColor,
  );

  static TextStyle formHintTextStyle = TextStyle(
      color: ColorConstants.formHintTextColor,
      fontFamily: 'Oxygen',
      fontSize: 14);

  static var textFormInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: ColorConstants.formFieldBorderColor,
    ),
  );

  static var otherFiledTextFormInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: ColorConstants.formFieldFillColor,
    ),
  );
}
