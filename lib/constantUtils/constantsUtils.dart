class HealingMatchConstants {

// ON-PREMISE API URLS == http://106.51.49.160:9092/api/
  static const String ON_PREMISE_USER_BASE_URL = "http://106.51.49.160:9094/api/user";
  static const String REGISTER_PROVIDER_URL = ON_PREMISE_USER_BASE_URL + '/register';

  // DOMAIN URL'S
  //static const String DOMAIN_BASE_URL = "https://michishirube.rinclick.com/api";
  //static const String SEARCH_USER_PROFILE_DETAILS_URL = DOMAIN_BASE_URL + "/search";

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
}
