import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../Constants/Constants.dart';
import 'package:testtting/NetworkCall/utils/dialogs.dart';

import '../Constants/Utilities.dart';
import '../DataModels/SignUpModel.dart';

class RestAPI {
  //late ProgressDialog pd;
  Utltity utilityOBJ = new Utltity();
  var header = {'Content-Type': 'application/x-www-form-urlencoded'};

  //--------------------This method gets data from API requests-------------------------
  Future<dynamic> getReq(context, url, [bool? show]) async {
    var data;
    utilityOBJ.onLoading(context);
    await http.get(url, headers: header).then((response) {
      data = json.decode(response.body);
      utilityOBJ.onLoadingDismiss(context);
      if (data['status'] == 200) {
        return data;
      } else {
        // Dialogs().alert(context,3, 'Error', data['message'],Constants.error_gif);
        if (show != false) {
          Dialogs().displayToast(context, data['message'], 0);
        }
        data = null;
      }
    });
  }

  //This method Posts data through api
  Future<dynamic> postReq(context, url, bod, title, message, bool show) async {
    // progress(context, message);

    print("_______________POST_________________");
    print(url);
    var data;
    if (show == true) {
      //pd.show();
    }
    utilityOBJ.onLoading(context);
    await http
        .post(
      url,
      body: bod,
      encoding: Encoding.getByName('utf-8'),
      headers: header,
    )
        .then((response) async {
      data = json.decode(response.body);
      utilityOBJ.onLoadingDismiss(context);
      if (data['status'] == true) {
        return data;
      } else {
        if (show == true) {
          Utltity().showAlert(context, 'Info', data['message'].toString());
        }
        data = null;
      }
    });
    return data;
  }

  //This method Posts data through api
  Future<dynamic> postReqWithAuthToken(
      context, url, title, message, bool show) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    var headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    var userRole = prefs.getString('userRole');

    var body = {'role': userRole};

    // progress(context, message);

    print("_______________POST_________________");
    var data;

    if (show == true) {
      //pd.show();
    }
    utilityOBJ.onLoading(context);
    await http
        .post(
      url,
      body: body,
      headers: headerData,
    )
        .then((response) async {
      data = json.decode(response.body);
      utilityOBJ.onLoadingDismiss(context);
      if (data['status'] == true) {
        return data;
      } else {
        if (show == true) {
          // pd.close();
          Utltity().showAlert(context, 'Info', data['message'].toString());
        }
        data = null;
      }
    });
  }

  //This method posts data with images in it
  Future<Map> upload(context, url, bod, title, message) async {
    // progress(context,message);

    Dio dio = Dio();
    var data;

    //pr.show();

    bod['api_key'] = Constants.api_key;

    // var formData = FormData.fromMap(bod);
    print('FORM DATA________________$bod');
    await dio.post(Constants.baseUrl + url).then((response) {
      // , data: formData
      data = json.decode(response.data);

      // pr.hide();
      print(data);

      if (data['status'] == 'True' || data['status'] == "TRUE") {
      } else {
        // Dialogs().alert(context,3, title, data['message'],Constants.error_gif);
        data = null;
      }
    });
    print(data);
    return data;
  }

  //-----------SEND NOTIFICATION-----------------------
  void sendNotification(String fcm, String title, String mssg) async {
    var _notification = 'https://fcm.googleapis.com/fcm/send';

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAT_DT5a0:APA91bERd_0v4DrkBChKPQ4kA-e26duCvswiQjjH0JXbahKHy5j-e9xoS808-xrxMXCXHPhMjF_kWaalm45VKTih2jow06ZgRPaTRL_WE-UJfVO9PavaUAERj9BpUugU38tqahyJ4BHZ'
    };
    final data = {
      "to": fcm,
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "sound": "default",
        "status": "done",
        "screen": "Notification",
      },
      "notification": {
        "title": title,
        "body": mssg,
      }
    };
    await http
        .post(_notification as Uri,
            body: json.encode(data),
            encoding: Encoding.getByName('utf-8'),
            headers: headers)
        .then((response) async {
      var data = json.decode(response.body);
      print(data);

      if (response.statusCode == 200) {
        // on success do sth
        print('test ok push CFM');
        return true;
      } else {
        print(' FCM error');
        // on failure do sth
        return false;
      }
    });
  }

  // Initializes progress dialog
  // progress(context,message){
  //   pd = ProgressDialog(context: context);
  //   pd.show(
  //     barrierDismissible: true,
  //     msg: message,
  //     hideValue: true,
  //   );
  // }
}
