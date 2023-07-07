import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testtting/UI/Notify/Notify.dart';
import 'package:testtting/UI/TaskStatus/TaskStatus.dart';
import 'package:http/http.dart' as http;
import 'package:testtting/UI/ManageProfile/ManageProfile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/Constants.dart';
import '../../DataModels/GetUserModel.dart';
import '../../DataModels/SignUpModel.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);
  MenuState createState() => MenuState();
}

List<String> listData = [
  " How to use JustAgg",
  " Get Justagg Device",
  " Ambassador Program",
  " Help & Support"
];

class MenuState extends State<MenuWidget> {
  late GetUserModel userDataModelOBJ = GetUserModel();

  // ignore: prefer_typing_uninitialized_variables
  var data;
  // ignore: prefer_typing_uninitialized_variables
  var _headerData;

  var percentage = 0;

  //------------------------------------Get User Data Api Data-------------------------------------

  Future<GetUserModel> fetchDataFromUserApi() async {
    //EasyLoading.show(status: 'loading...');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    // var bearerToken = '1181|MddbugrToEVjBVhZ9SF9k9BGcCXw8uwbp05WG8bI';

    Uri url =
        Uri.parse(Constants.baseUrl.toString() + Constants.GET_USER.toString());

    _headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    var role = prefs.getString("userRole");

    var body = {'role': role};

    final response = await http.post(
      url,
      body: body,
      headers: _headerData,
    );

    if (response.body.isEmpty != true) {
      GetUserModel contactObj =
          GetUserModel.fromJson(json.decode(response.body));
      userDataModelOBJ = contactObj;
    }
    percentage = userDataModelOBJ.data?.profile?.trueCount?.toInt() ?? 0;
    return userDataModelOBJ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: FutureBuilder(
          future: fetchDataFromUserApi(),
          builder: (context, snapShot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 54,
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {
                              Share.share(
                                  'Hey, \n You can find my profile: \n ${snapShot.data?.data?.baseUrl.toString() ?? ""} ');
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          color: Colors.transparent,
                          height: 54.0,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Menu',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.bold),
                            ), // <-- Text
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 54,
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Notify(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.notification_add_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      elevation: 5,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                radius: 36,
                                backgroundImage: NetworkImage(userDataModelOBJ
                                        .data?.profileUrl
                                        .toString() ??
                                    ""),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        userDataModelOBJ.data?.name
                                                .toString() ??
                                            "",
                                        style: const TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                        maxLines: 3,
                                      ),
                                      Text(
                                        userDataModelOBJ.data?.phone
                                                .toString() ??
                                            "",
                                        style: const TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                        maxLines: 3,
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  child: FloatingActionButton.extended(
                                    heroTag: null,
                                    label: const Text(
                                      'Manage',
                                      style: TextStyle(
                                          fontFamily: Constants.fontFamily,
                                          fontSize: 12),
                                    ), // <-- Text
                                    backgroundColor: Colors.black,
                                    icon: const Icon(
                                      // <-- Icon
                                      Icons.bookmark_outline_sharp,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ManageProfile(
                                            userDataModel: userDataModelOBJ,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TaskStatus(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Complete Your Profile',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17),
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          height: 5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: percentage >= 1
                                                ? Colors.grey
                                                : const Color.fromARGB(
                                                    255, 219, 214, 214),
                                          ))),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        height: 5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: percentage >= 2
                                              ? Colors.grey
                                              : const Color.fromARGB(
                                                  255, 219, 214, 214),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: percentage >= 3
                                            ? Colors.grey
                                            : const Color.fromARGB(
                                                255, 219, 214, 214),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        height: 5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: percentage >= 4
                                              ? Colors.grey
                                              : const Color.fromARGB(
                                                  255, 219, 214, 214),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          height: 5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: percentage >= 5
                                                ? Colors.grey
                                                : const Color.fromARGB(
                                                    255, 219, 214, 214),
                                          )))
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${userDataModelOBJ.data?.profile?.percentage.toString() ?? ""} ${'Completed'}',
                                  style: const TextStyle(
                                      fontFamily: Constants.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                                const Spacer(),
                                Text(
                                  '${userDataModelOBJ.data?.profile?.trueCount.toString() ?? ""}${'/'}${userDataModelOBJ.data?.profile?.totalCount.toString() ?? ""} ${'Completed'}',
                                  style: const TextStyle(
                                      fontFamily: Constants.fontFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 0.95,
                      child: SizedBox(
                          height: 50.0,
                          child: OutlinedButton(
                            onPressed: () async {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashBaord()));
                            },
                            child: Text(
                              'Activate Product',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: Constants.fontFamily,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: const StadiumBorder(),
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemExtent: 70.0,
                        itemCount: listData.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      if (index == 0) {
                                        final Uri url = Uri.parse(
                                            'https://justagg.com/how-to-use-2');
                                        launchUrl(url);
                                      } else if (index == 1) {
                                        final Uri url = Uri.parse(
                                            'https://justagg.com/shop');
                                        launchUrl(url);
                                      } else if (index == 2) {
                                        final Uri url = Uri.parse(
                                            'https://justagg.com/ambassadors/');
                                        launchUrl(url);
                                      } else {
                                        final Uri url = Uri.parse(
                                            'https://justagg.com/faq');
                                        launchUrl(url);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            listData[index],
                                            style: const TextStyle(
                                                fontFamily:
                                                    Constants.fontFamily,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.navigate_next_outlined))
                                        ],
                                      ),
                                    ),
                                  )));
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 0.95,
                      child: SizedBox(
                          height: 50.0,
                          child: OutlinedButton(
                            onPressed: () async {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashBaord()));
                            },
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                ),
                                Text(
                                  'Share Feedback',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: Constants.fontFamily,
                                  ),
                                ),
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Colors.blue,
                              shape: const StadiumBorder(),
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 0.95,
                      child: SizedBox(
                          height: 50.0,
                          child: OutlinedButton(
                            onPressed: () async {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashBaord()));
                            },
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: Constants.fontFamily,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Colors.black,
                              shape: const StadiumBorder(),
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 0.95,
                      child: SizedBox(
                          height: 50.0,
                          child: InkWell(
                            onTap: () async {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashBaord()));
                            },
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Delete Account',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: Constants.fontFamily,
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          },
        )),
      ),
    );
  }
}
