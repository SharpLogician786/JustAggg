import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testtting/Constants/Utilities.dart';

import '../../Constants/Constants.dart';
import '../../DataModels/Analytics.dart';
import '../../DataModels/SignUpModel.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);
  @override
  AnalyticsState createState() => AnalyticsState();
}

const List<String> list = <String>['Week', 'Month', 'Year'];

class AnalyticsState extends State<Analytics> {
  String dropdownValue = "Week";
  // ignore: prefer_typing_uninitialized_variables
  var data;
  // ignore: prefer_typing_uninitialized_variables
  var _headerData;

  late AnalyticModel analyticDataModelOBJ = AnalyticModel();

  Monthly? timeData;

  List<Icon> usersdata = [
    const Icon(Icons.remove_red_eye_outlined),
    const Icon(Icons.ads_click),
    const Icon(Icons.contact_page_outlined),
    const Icon(Icons.star_rate_sharp)
  ];

//------------------------------------Init State-------------------------------------
  @override
  void initState() {
    super.initState();
    fetchAnalyticData();
  }
//------------------------------------Widget Builder-------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: FutureBuilder(
          future: fetchAnalyticData(),
          builder: (context, snapshot) {
            if (snapshot.hasData == true) {
              return Column(
                children: [
                  const SizedBox(
                    height: 44,
                    // color: Colors.white,
                    child: Center(
                      child: Text(
                        'Analytics',
                        style: TextStyle(
                            fontFamily: Constants.fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 15.0),
                            child: SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                'Past 24 Hour',
                                style: TextStyle(
                                    fontFamily: Constants.fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          analyticDataModelOBJ.data?.todayViews
                                                  .toString() ??
                                              "",
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontFamily: Constants.fontFamily,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          'Views',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: Constants.fontFamily,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          analyticDataModelOBJ.data?.todayClicks
                                                  .toString() ??
                                              "",
                                          style: const TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          'Clicks',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.3,

                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${analyticDataModelOBJ.data?.clicksRate.toString() ?? ""}%',
                                          style: const TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          'Click Rate',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 30,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: Constants.fontFamily,
                        ),
                        underline: const SizedBox(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value.toString();
                            dropdownSelection(dropdownValue);
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Column(
                        children: [
                          Padding(
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
                              height: 54,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: usersdata[0],
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${timeData?.views.toString()}${" Views"}',
                                            style: const TextStyle(
                                                fontFamily:
                                                    Constants.fontFamily,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )),
                                  const Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        child: Icon(Icons.info_outline),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
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
                              height: 54,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: usersdata[1],
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${timeData?.clicks.toString() ?? ""}${" Clicks"}',
                                            style: const TextStyle(
                                                fontFamily:
                                                    Constants.fontFamily,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )),
                                  const Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        child: Icon(Icons.info_outline),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
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
                              height: 54,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: usersdata[2],
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${timeData?.contacts.toString() ?? ""}  ${"Contacts"}',
                                            style: const TextStyle(
                                                fontFamily:
                                                    Constants.fontFamily,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )),
                                  const Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        child: Icon(Icons.info_outline),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
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
                              height: 54,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: usersdata[3],
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${timeData?.clicksRate.toString() ?? ""}${"% Click Rates"}',
                                            style: const TextStyle(
                                                fontFamily:
                                                    Constants.fontFamily,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )),
                                  const Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        child: Icon(Icons.info_outline),
                                      ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Links',
                        style: TextStyle(
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 30),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemExtent: 70.0,
                          itemCount: timeData?.links?.length,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
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
                                        child: SizedBox(
                                            child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Image.network(
                                            timeData?.links?[index].image ?? "",
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ))),
                                    Expanded(
                                        flex: 4,
                                        child: SizedBox(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              timeData?.links?[index].name
                                                      .toString() ??
                                                  "",
                                              style: const TextStyle(
                                                  fontFamily:
                                                      Constants.fontFamily,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          child: Text(timeData
                                                  ?.links?[index].clicks
                                                  .toString() ??
                                              ""),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: const LoadingIndicator(
                        indicatorType: Indicator.ballPulse, /// Required, The loading type of the widget
                        colors: const [Colors.black],       /// Optional, The color collections
                        strokeWidth: 2,            /// Optional, Background of the widget
                        pathBackgroundColor: Colors.black
                    ),
                  ),
                ),
              );
            }
          },
        ),
      )),
    );
  }

//------------------------------------Api Data-------------------------------------

  Future<AnalyticModel> fetchAnalyticData() async {
    //EasyLoading.show(status: 'loading...');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    Uri _url = Uri.parse(
        Constants.baseUrl.toString() + Constants.GET_ANALYTICS.toString());

    var userID = user.data?.id.toString() ?? "";

    data = {'userId': userID};

    _headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    final response = await http.post(
      _url,
      body: data,
      headers: _headerData,
    );

    print("before data");

    if (response.body.isEmpty != true) {
      print(response.body);

      AnalyticModel contactObj =
          AnalyticModel.fromJson(json.decode(response.body));
      analyticDataModelOBJ = contactObj;
      //-----------------------------------Print Data------------------------------------
    } else {
      Utltity().showAlertWithoutPop(context, 'Info', 'No Data Found');
    }
    dropdownSelection(dropdownValue);
    return analyticDataModelOBJ;
  }

  dropdownSelection(String selectionIndex) {
    // ignore: unrelated_type_equality_checks
    if (selectionIndex == "Week") {
      print("week selection");
      timeData = analyticDataModelOBJ.data?.weekly;
    }
    // ignore: unrelated_type_equality_checks
    else if (selectionIndex == "Month") {
      print("month selection");
      timeData = analyticDataModelOBJ.data?.monthly;
    } else {
      print("year selection");
      timeData = analyticDataModelOBJ.data?.yearly;
    }
  }
}
