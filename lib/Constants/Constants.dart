import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testtting/DataModels/GetUserModel.dart';

import '../DataModels/SignUpModel.dart';

class Constants {
  static const double padding = 20;
  static const double avatarRadius = 30;
  //-------------Text-------------------
  static final String rightReserved = "2020 \u00a9 OptimX. All Rights Reserved";

  static final String password = "Forgot Password?";

  static final String meeting_0 = "Meeting request";
  static final String meeting_1 = "Meeting list";
  static final String meeting_2 = "Meeting History";

  static String LOREM_IPSUM =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  //-------------Animation Tag-------------------
  static final String tag = "logo000";

  //-------------Connectivity Tag-------------------
  static final String conn_mobile = "ConnectivityResult.mobile";
  static final String conn_wifi = "ConnectivityResult.wifi";
  static final String calendar = "assets/images/calendar.gif";
  static final String conn_uknown = "Unknown";

  static const fontFamily = 'Montserrat';

  //------------------GIF Images for dialogs---------------------
  static final String error_gif = "assets/images/error.gif";
  static final String success_gif = "assets/images/success.gif";
  static final String logout = "assets/images/logout.gif";
  static final String wifi = "assets/images/wifi.gif";

  //-------------Month List-------------------
  static final Map<int, String> months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };

  //-------------API Calls-------------------
  // ignore: constant_identifier_names
  static const String api_key = "8008c3bdfbd84787e777ae3dfdb89764";

  static const String baseUrl = "https://apis.justagg.com/api/";

// ignore: constant_identifier_names
  static const String Signup = "register";

  static const String login = "login";

  static const String forgotPassword = "forgot_password";

  // ignore: constant_identifier_names
  static const String contact_List = "get_contacts";

  // ignore: constant_identifier_names
  static const String GET_ANALYTICS = "get_analytics";

  // ignore: constant_identifier_names
  static const String GET_NOTIFICATION = "get_notifications";

  // ignore: constant_identifier_names
  static const String DELETE_NOTIFICATION = "delete_notifications";

  // ignore: constant_identifier_names
  static const String GET_ALL_SOCIAL_LINKS = "get_all_social_links";

  // ignore: constant_identifier_names
  static const String GET_USER_SOCIAL_LINKS = "get_user_links";

  // ignore: constant_identifier_names
  static const String ADD_USER_LINK = "add_user_link";

  // ignore: constant_identifier_names
  static const String DELETE_USER_LINK = "delete_user_link";

  // ignore: constant_identifier_names
  static const String CHANGE_MODE = "change_lead_mode";

  // ignore: constant_identifier_names
  static const String CHANGE_ACCOUNT_STATUS = "change_profile_status";

  // ignore: constant_identifier_names
  static const String GET_USER = "get_user";

  // ignore: constant_identifier_names
  static const String UPDATE_USER = "update_user";

  // ignore: constant_identifier_names
  static const String CREATE_GROUP = "create_group";

  // ignore: constant_identifier_names
  static const String GET_USER_GROUP = "get_user_groups";

// ignore: constant_identifier_names
  static const String DELETE_GROUP = "delete_group";

  // ignore: constant_identifier_names
  static const String UPDATE_GROUP_CONTACTS = "update_group_contact";

  // ignore: constant_identifier_names
  static const String GET_GROUP_CONTACTS = "get_group_contacts";
}

class GetSharedPreferencesData {
  Future<SignUpModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    return user;
  }
}


