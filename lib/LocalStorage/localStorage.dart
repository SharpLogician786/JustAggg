// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:obim/DataModels/SingInModel.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
//
// class Storage{
//   var data;
//   final newUserDefault = SharedPreferences.getInstance();
//   late String dataString;
//
//   storeJsonData(String key,String data) async{
//     await newUserDefault.then((value) => {
//       value.setString(key, data)
//     });
//   }
//
//   getJsonData(String key) async{
//    dataString = await newUserDefault.then((value) => {
//       value.getString(key)
//     }) as String;
//     return dataString;
//   }
// }