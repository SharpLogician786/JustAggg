import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Constants/Constants.dart';
import '../../DataModels/NotificationModel.dart';
import '../../DataModels/SignUpModel.dart';

class Notify extends StatefulWidget {
  NotifyState createState() => NotifyState();
}

class NotifyState extends State<Notify> {
  // ignore: prefer_typing_uninitialized_variables
  var _headerData;

  late NotificationModel notificationDataModelOBJ = NotificationModel();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 54,
                  // color: Colors.white,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const Spacer(),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Notification',
                          style: TextStyle(
                              fontFamily: Constants.fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.9,
                child: FutureBuilder(
                  future: fetchNotificationData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == true) {
                      return ListView.builder(
                          itemCount: notificationDataModelOBJ.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 8.0),
                                      child: Text(
                                        notificationDataModelOBJ
                                                .data?[index].dateTime
                                                .toString() ??
                                            "",
                                        style: const TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            color: Colors.grey),
                                      ),
                                    )),
                                ListTile(
                                    leading: InkWell(
                                      onTap: () {
                                        deleteNotification(
                                            notificationDataModelOBJ
                                                    .data?[index].id
                                                    .toString() ??
                                                "");
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ),
                                    subtitle: Text(
                                      notificationDataModelOBJ
                                              .data?[index].message
                                              .toString() ??
                                          "",
                                      style: const TextStyle(
                                          fontFamily: Constants.fontFamily,
                                          color: Colors.black,
                                          fontSize: 15),
                                    ),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        notificationDataModelOBJ
                                                .data?[index].title
                                                .toString() ??
                                            "",
                                        style: const TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )),
                                Container(
                                  height: 1,
                                  color: Colors.grey,
                                )
                              ],
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //------------------------------------Api Data-------------------------------------

  Future<NotificationModel> fetchNotificationData() async {
    //EasyLoading.show(status: 'loading...');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    var userID = user.data?.id.toString() ?? "";

    Uri url = Uri.parse(
        Constants.baseUrl.toString() + Constants.GET_NOTIFICATION.toString());

    // data = {'userID': user.data?.id.toString() ?? ""};
    _headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    final response = await http.post(
      url,
      body: {'userId': userID},
      headers: _headerData,
    );
    if (response.body.isEmpty != true) {
      NotificationModel notifyObj =
          NotificationModel.fromJson(json.decode(response.body));
      notificationDataModelOBJ = notifyObj;
    }

    return notificationDataModelOBJ;
  }

  //------------------------------------ Delete Api-------------------------------------

  Future<NotificationModel> deleteNotification(String id) async {
    //EasyLoading.show(status: 'loading...');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    Uri _url = Uri.parse(Constants.baseUrl.toString() +
        Constants.DELETE_NOTIFICATION.toString());

    // data = {'userID': user.data?.id.toString() ?? ""};
    _headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    final response = await http.post(
      _url,
      body: {'id': id},
      headers: _headerData,
    );
    if (response.body.isEmpty != true) {
      NotificationModel notifyObj =
          NotificationModel.fromJson(json.decode(response.body));
      setState(() {
        notificationDataModelOBJ = notifyObj;
      });

      //-----------------------------------Print Data------------------------------------
    }
    return notificationDataModelOBJ;
  }
}
