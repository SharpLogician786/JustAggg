import 'dart:convert';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testtting/Constants/Utilities.dart';
import 'package:testtting/UI/Share/ProfileSignature.dart';

import '../../Constants/Constants.dart';
import '../../DataModels/GetUserModel.dart';
import 'package:http/http.dart' as http;

import '../../DataModels/SignUpModel.dart';

class ShareTab extends StatefulWidget {
  const ShareTab({Key? key}) : super(key: key);

  @override
  ShareState createState() => ShareState();
}

class User {
  String name;
  Icon icon;
  User({required this.name, required this.icon});
}

List<User> users = [
  User(name: "Share as Texts", icon: const Icon(Icons.text_decrease)),
  User(name: "Share as Email", icon: const Icon(Icons.email_outlined)),
  User(
      name: "Create Email Signature",
      icon: const Icon(Icons.add_task_outlined)),
  User(
      name: "Change Theme Color",
      icon: const Icon(Icons.format_color_fill_outlined))
];

class ShareState extends State<ShareTab> {
  bool light = true;

  late GetUserModel userDataModelOBJ = GetUserModel();

  // ignore: prefer_typing_uninitialized_variables
  var data;
  // ignore: prefer_typing_uninitialized_variables
  var headerData;

  Utltity utilityOBJ = new Utltity();

  String title = 'Color Picker';

  Color pickerColor = const Color(0xff2196f3);
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    var color =
        pickerColor.toString().replaceAll(RegExp(r'(?:_|[^\w\s])+'), '');
    var rSpaceColor = color.replaceAll(RegExp(r'(\s)'), '');

    var rcolorText = rSpaceColor.toLowerCase().replaceAll(RegExp(r'color'), '');

    var materialPrimaryvalue = 'materialprimaryvalue'.toLowerCase();
    var replaceWith = '';
    var colorCode = rcolorText.replaceAll(materialPrimaryvalue, replaceWith);

    int colorCodeInt = num.tryParse(colorCode) as int;
    Color selectedColor = Color(colorCodeInt);
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: fetchDataFromUserApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 44,
                      // color: Colors.white,
                      child: Center(
                        child: Text(
                          'Share',
                          style: TextStyle(
                              fontFamily: Constants.fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: QrImageView(
                              data: snapshot.data?.data?.baseUrl.toString() ??
                                  "",
                              version: QrVersions.auto,
                              size: 150.0,
                            ),
                          ),
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: const Icon(
                          //       Icons.download_for_offline,
                          //       size: 34,
                          //     ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              child: Text(
                                snapshot.data?.data?.baseUrl.toString() ?? "",
                                style: const TextStyle(
                                    fontFamily: Constants.fontFamily,
                                    fontWeight: FontWeight.w600),
                              )),
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text:
                                    snapshot.data?.data?.baseUrl.toString() ??
                                        ""));
                              },
                              icon: const Icon(
                                Icons.copy_sharp,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.info_outline,
                              )),
                          const SizedBox(
                              child: Text(
                                'Offline Mode',
                                style: TextStyle(
                                    fontFamily: Constants.fontFamily,
                                    fontWeight: FontWeight.w600),
                              )),
                          Switch.adaptive(
                            // This bool value toggles the switch.
                            value: light,
                            activeColor: Colors.black,
                            onChanged: (bool value) {
                              setState(() {
                                light = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0, left: 0),
                      child: SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.35,
                        child: ListView.builder(
                            itemExtent: 65.0,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: users.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                                child: InkWell(
                                  onTap: () {
                                    if (index == 0) {
                                      Share.share(
                                          'Hey, \n You can find my profile: \n ${snapshot
                                              .data?.data?.baseUrl.toString() ??
                                              ""} ');
                                    }
                                    if (index == 1) {
                                      Share.share(
                                          'Hey, \n You can find my profile: \n ${snapshot
                                              .data?.data?.baseUrl.toString() ??
                                              ""} ');
                                    }
                                    if (index == 2) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Signature(
                                                    userDataModel: userDataModelOBJ,
                                                  )));
                                      // EditContacts
                                    }
                                    if (index == 3) {
                                      colorPickerDialog();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      height: 30,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: users[index].icon,
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: SizedBox(
                                                child: Text(
                                                  users[index].name,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                      Constants.fontFamily,
                                                      fontSize: 17,
                                                      fontWeight: FontWeight
                                                          .w500),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: SizedBox(
                            height: 50.0,
                            child: OutlinedButton(
                              onPressed: () {
                                Share.share(
                                    'Hey, \n You can find my profile: \n ${snapshot
                                        .data?.data?.baseUrl.toString() ??
                                        ""} ');
                              },
                              child: Text(
                                'Share Another Way',
                                style: TextStyle(
                                    fontFamily: Constants.fontFamily,
                                    color: Colors.white),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: const StadiumBorder(),
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }
              else {
                return Container(

                );
              }
            }
          ),
        ),
      ),
    );
  }

  Future<GetUserModel> fetchDataFromUserApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // String? bearerToken = prefs.getString('bearerToken');

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    String? userRole = prefs.getString('userRole');

    Uri url =
        Uri.parse(Constants.baseUrl.toString() + Constants.GET_USER.toString());

    var bearerToken = user.data?.token.toString();

    headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    var body = {'role': userRole};

    print(body);

    print(url);
    utilityOBJ.onLoading(context);
    final response = await http.post(
      url,
      body: body,
      headers: headerData,
    );

    if (response.body.isEmpty != true) {
      GetUserModel contactObj =
          GetUserModel.fromJson(json.decode(response.body));
      userDataModelOBJ = contactObj;
    }
    utilityOBJ.onLoadingDismiss(context);
    return userDataModelOBJ;
  }

  Future colorPickerDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 54,
                color: Colors.transparent,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Pick Theme',
                    style: TextStyle(
                        fontFamily: Constants.fontFamily,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              BlockPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
