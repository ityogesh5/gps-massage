import 'package:flutter/cupertino.dart';
import 'package:gps_massageapp/customLibraryClasses/progressDialogs/custom_dialog.dart';

import '../constantsUtils.dart';

class ProgressDialogBuilder {
  static ProgressDialog progressDialog = ProgressDialog();

  //Register user and Provider
  static void showRegisterProgressDialog(BuildContext context) {
    progressDialog.showProgressDialog(context,
        textToBeDisplayed: '${HealingMatchConstants.registerProgressText}',
        dismissAfter: Duration(seconds: 5));
  }

  static void hideRegisterProgressDialog(BuildContext context) {
    progressDialog.dismissProgressDialog(context);
  }

  // Getting location
  static void showLocationProgressDialog(BuildContext context) {
    progressDialog.showProgressDialog(context,
        textToBeDisplayed: '${HealingMatchConstants.locationProgressText}',
        dismissAfter: Duration(seconds: 5));
  }

  static void hideLocationProgressDialog(BuildContext context) {
    progressDialog.dismissProgressDialog(context);
  }

  // Getting Cities
  static void showGetCitiesProgressDialog(BuildContext context) {
    progressDialog.showProgressDialog(context,
        textToBeDisplayed: '${HealingMatchConstants.getCityProgressText}',
        dismissAfter: Duration(seconds: 5));
  }

  static void hideGetCitiesProgressDialog(BuildContext context) {
    progressDialog.dismissProgressDialog(context);
  }

  // Login user
  static void showLoginUserProgressDialog(BuildContext context) {
    progressDialog.showProgressDialog(context,
        textToBeDisplayed: '${HealingMatchConstants.getLoginProgressText}',
        dismissAfter: Duration(seconds: 5));
  }

  static void hideLoginUserProgressDialog(BuildContext context) {
    progressDialog.dismissProgressDialog(context);
  }

  // Login Provider
  static void showLoginProviderProgressDialog(BuildContext context) {
    progressDialog.showProgressDialog(context,
        textToBeDisplayed: '${HealingMatchConstants.getLoginProgressText}',
        dismissAfter: Duration(seconds: 5));
  }

  static void hideLoginProviderProgressDialog(BuildContext context) {
    progressDialog.dismissProgressDialog(context);
  }
}
