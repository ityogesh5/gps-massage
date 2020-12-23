import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealingMatchConstants {
// ON-PREMISE API URLS == http://106.51.49.160:9092/api/
  static const String ON_PREMISE_BASE_URL = "http://106.51.49.160:9092/api";

  // DOMAIN URL'S
  static const String DOMAIN_BASE_URL = "https://michishirube.rinclick.com/api";
  static const String SEARCH_USER_PROFILE_DETAILS_URL =
      DOMAIN_BASE_URL + "/search";

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
  static String gpsAddress = '';

  //LoginServiceProvider
  static const String loginText = 'セラピストのログイン';
  static const String loginPhoneNumber = '電話番号';
  static const String loginPassword = 'パスワード';
  static const String loginForgetPassword = 'パスワードを忘れた方はこちら';
  static const String loginButton = 'パスワード';
  static const String loginNewRegistrationText = '新規の方はこちら';
  static const String loginServiceUser = 'サービス利用者のログイン';

  //RegistrationServiceProvider
  static const String registrationFirstText = 'セラピスト情報の入力';
  static const String registrationSecondText = '*は必項目です';
  static const String registrationIdentityVerification = '本人確認証';
  static const String registrationIdentityUpload = '本人確認書のアップロード';
  static const String registrationAdd = '保有資格の種類を選択し、\n証明書をアップロードしてください。';
  static const String registrationQualificationDropdown = '保有資格を選択してください。*';
  static const String registrationQualificationUpload = 'ファイルをアップロードする';
  static const String registrationChooseServiceNavBtn = '提供サービスと料金設定';
  static const String registrationMultiPhotoUpload = '掲載写真のアップロード';
  static const String registrationBankDetails = '売上振込先銀行口座';
  static const String registrationBankName = '銀行名*';
  static const String registrationBankBranchCode = '支店コード';
  static const String registrationBankBranchNumber = '支店番号';
  static const String registrationBankAccountNumber = '口座番号';
  static const String registrationBankAccountType = '口座種類';
  static const String registrationCompleteBtn = '登録完了';
  static const String registrationAlreadyActTxt = 'すでにアカウントをお持ちの方';

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
}
