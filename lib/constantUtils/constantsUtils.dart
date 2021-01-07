import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';

class HealingMatchConstants {
// ON-PREMISE API URLS == http://106.51.49.160:9092/api/
// DOMAIN URL'S
  //static const String DOMAIN_BASE_URL = "https://michishirube.rinclick.com/api";
  //static const String SEARCH_USER_PROFILE_DETAILS_URL = DOMAIN_BASE_URL + "/search";

  static const String ON_PREMISE_USER_BASE_URL =
      "http://106.51.49.160:9094/api";
  static const String REGISTER_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/user/register';
  static const String STATE_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/prefecture' + '/getAllPrefecture';
  static const String CITY_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/cities' + '/getCitieByPrefectureId';
  static const String ESTHETIC_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/esthetic/getAllEsthetic';
  static const String RELAXATION_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/relaxation/getAllRelaxation';
  static const String TREATMENT_PROVIDER_URL =
      ON_PREMISE_USER_BASE_URL + '/orteopathic/getAllOsteopathic';
  static const String REGISTER_PROVIDER_BANNER_UPLOAD_URL =
      ON_PREMISE_USER_BASE_URL + '/user/bannerUpload';

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

  //Register Service User Screen Constants
  static String serviceUserName = '';
  static String serviceUserDOB = '';
  static String serviceUserGender = '';
  static String serviceUserOccupation = '';
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

  //Register Service Provider Screen Constants
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

  //userDefinedScreens
  static const String UserSelectFirtTxt = 'どちらで利用しますか？';
  static const String UserSelectLastTxt = 'セラピストで登録の場合はサービス利用者と\nしてもログイン可能です。';

  //LoginServiceProvider
  static const String loginText = 'セラピストのログイン';
  static const String loginPhoneNumber = '電話番号 *';
  static const String loginPassword = 'パスワード *';
  static const String loginForgetPassword = 'パスワードを忘れた方はこちら';
  static const String loginButton = 'ログイン';
  static const String loginNewRegistrationText = '新規の方はこちら';
  static const String loginServiceUser = 'サービス利用者のログイン';

  //LoginServiceUser
  static const String loginUserText = 'サービス利用者のログイン';
  static const String loginUserSkipText = 'スキップ';
  static const String loginUserPhoneNumber = '電話番号 *';
  static const String loginUserPassword = 'パスワード *';
  static const String loginUserForgetPassword = 'パスワードを忘れた方はこちら';
  static const String loginUserButton = 'ログイン';
  static const String loginUserNewRegistrationText = '新規の方はこちら';
  static const String loginServiceProvider = 'セラピストのログイン';

  //RegistrationServiceProvider
  static const String registrationFirstText = 'セラピスト情報の入力';
  static const String registrationSecondText = '*は必項目です';
  static const String registrationFacePhtoText =
      '利用者に安心していただく為にもなるべく顔の映った写真を使用しましょう';
  static const String registrationBuisnessForm = '事業形態';
  static const String registrationBuisnessTrip = '出張でサービス提供可能';
  static const String registrationCoronaTxt = 'コロナ対策実施有無';
  static const String registrationJapanAssociationTxt =
      '*マスクの着用、アルコール消毒の徹底、体温管理等日本\nリラクゼーション協会の定める項目を遵守している\n場合のみチェックください';
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
  static const String registrationConfirmPassword = 'パスワード再確認*';
  static const String registrationStorePhnText = '店舗として登録の場合は代表者の携帯番号を入力してください';
  static const String registrationIndividualText =
      '個人で登録の方は、住所の詳細情報が利用者に開示されることはありません。';
  static const String registrationBuildingName = '建物名*';
  static const String registrationRoomNo = '部屋番号*';
  static const String registrationPointTxt =
      '*登録地点周辺のサービス利用者に優先的に検索されるようになります。';
  static const String registrationNextBtn = '次へ';

  static const String registrationIdentityVerification =
      '登録する本人確認証の種類を選択して\nください。*';
  static const String registrationIdentityUpload = '本人確認書のアップロード*';
  static const String registrationAdd = '保有資格の種類を選択し、\n証明書をアップロードしてください。*';
  static const String registrationQualificationDropdown = '保有資格を選択してください。*';
  static const String registrationQualificationUpload = 'ファイルをアップロードする';
  static const String registrationChooseServiceNavBtn = '提供サービスと料金設定*';
  static const String registrationMultiPhotoUpload = '掲載写真のアップロード';
  static const String registrationBankDetails = '売上振込先銀行口座';
  static const String registrationBankName = '銀行名*';
  static const String registrationBankBranchCode = '支店コード';
  static const String registrationBankBranchNumber = '支店番号';
  static const String registrationBankAccountNumber = '口座番号';
  static const String registrationBankAccountType = '口座種類';
  static const String registrationCompleteBtn = '登録完了';
  static const String registrationAlreadyActTxt = 'すでにアカウントをお持ちの方';

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
  static const String forgetPasswordTxt =
      "パスワードを再設定するための認証コードを\n送信しますので、ご登録の電話番号を入力の上\n「送信」ボタンをクリックしてください";

  //Change Password
  static const String changePasswordNewpass = "新しいパスワード *";
  static const String changePasswordTxt =
      "+81****に届いた認証コードと\n 新しいパスワードを入力し、「パスワードを\n 再設定する」ボタンをクリックしてください。";
  static const String changePasswordConfirmpass = "新しいパスワード(確認) *";
  static const String changePasswordBtn = 'パスワードを再設定する';
  static const String changeResendOtp = '認証コードを再送する';

  //FontStyle
  static const headersText = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: 18.0,
    color: Colors.black,
  );

  static const normalText = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: 14.0,
    color: Colors.black,
  );

  static const labelText = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: 12.0,
    color: Colors.black,
  );

  static var textFormInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: ColorConstants.formFieldBorderColor,
    ),
  );
}
