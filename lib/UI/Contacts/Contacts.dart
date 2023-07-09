import 'dart:convert';
import 'dart:core';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testtting/DataModels/ContactModel.dart';
import 'package:testtting/DataModels/SignUpModel.dart';
import 'package:testtting/UI/Contacts/ContactDetails.dart';

import '../../Constants/Constants.dart';
import '../../DataModels/CreateGrouoModel.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);
  @override
  ContactsState createState() => ContactsState();
}

class ContactsState extends State<Contacts> {
  // ignore: prefer_typing_uninitialized_variables
  var data;

  List<Groups> groupNames = [];
  List<dynamic> selectedContactIDS = [];

  var deleteGroupId = "";
  var updateGroupId = "";
  bool groupSelection = false;

  // ignore: prefer_typing_uninitialized_variables
  var headerData;

  bool isGroupSelection = false;

  bool plusSignVisible = false;

  bool isContactAdded = false;

  var buttonTitle = 'Select';

  int groupIndexSelected = 1;

  late ContactsModel contactDataModelOBJ = ContactsModel();

  late ContactsModel groupContacts = ContactsModel();

  TextEditingController groupName = TextEditingController();

  late CreateGroupModel userDataModelOBJ = CreateGroupModel();

  late CreateGroupModel userGroupDataModelOBJ = CreateGroupModel();

  //-----------------------------Init State-----------------------------------------
  @override
  void initState() {
    super.initState();
  }

  //-----------------------------Design-----------------------------------------
  @override
  Widget build(BuildContext context) {
    Color mainColor = groupIndexSelected > 0 ? Colors.white : Colors.black;
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: 44,
                // color: Colors.white,
                child: const Center(
                  child: Text(
                    'Contacts',
                    style: TextStyle(
                        fontFamily: Constants.fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, right: 20.0, left: 20.0),
              child: Container(
                child: Row(children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        style: const TextStyle(
                            fontFamily: Constants.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                        // controller: usernameController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.grey)),
                            filled: true,
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                fontFamily: Constants.fontFamily,
                                color: Colors.grey[300]),
                            fillColor: Colors.white70),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          // date();
                        },
                        icon: const Icon(Icons.refresh_outlined),
                        iconSize: 36,
                      ))
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: 44,
                width: MediaQuery.of(context).size.width * 0.9,
                child: FutureBuilder(
                  future: getUserGroupApi(),
                  builder: (context, snapshot) {
                    return GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: groupNames.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 110,
                      ),
                      itemBuilder: (contxt, index) {
                        if (index == 0) {
                          plusSignVisible = true;
                        } else {
                          plusSignVisible = false;
                        }
                        return SizedBox(
                          height: 44,
                          child: FloatingActionButton.extended(
                            icon: Visibility(
                              visible: plusSignVisible,
                              child: const Icon(
                                Icons.add,
                                size: 24.0,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              if (index > 0) {
                                groupIndexSelected = index;
                              } else {
                                print('');
                              }
                              buttonTitle = "";
                              if (index == 0) {
                                setState(() {
                                  isGroupSelection = false;
                                  groupSelection = false;
                                  addGroup(context);
                                });
                              } else if (index == 1) {
                                setState(() {
                                  isGroupSelection = false;
                                  groupSelection = false;
                                });
                              } else {
                                setState(() {
                                  groupSelection = true;
                                  buttonTitle = 'Select';
                                  deleteGroupId =
                                      groupNames[index].id?.toString() ?? "";
                                  updateGroupId =
                                      groupNames[index].id?.toString() ?? "";
                                  isGroupSelection = true;
                                  getGroupContactsApi(updateGroupId);
                                });
                              }
                            },
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(100)),
                            label: Text(
                              groupNames[index].groupName.toString(),
                              style: TextStyle(
                                color: index == groupIndexSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: Constants.fontFamily,
                              ),
                            ),
                            backgroundColor: index == groupIndexSelected
                                ? Colors.black
                                : Colors.white,
                            elevation: 0,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: isGroupSelection,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      SizedBox(
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            setState(() {
                              groupNames.clear();
                              deleteUserGroupApi(deleteGroupId);
                            });
                          },
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(100)),
                          label: const Text(
                            'Delete',
                            style: TextStyle(
                                fontFamily: Constants.fontFamily,
                                color: Colors.black),
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 40,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            setState(() {
                              if (buttonTitle == 'Select') {
                                groupSelection = false;
                                buttonTitle = 'Done';
                              } else {
                                addUsersInGroupApi(
                                    updateGroupId, selectedContactIDS);
                                groupSelection = true;
                                buttonTitle = 'Select';
                              }
                            });
                          },
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(100)),
                          label: Text(
                            buttonTitle,
                            style: const TextStyle(
                                fontFamily: Constants.fontFamily,
                                color: Colors.black),
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: FutureBuilder(
                      future: groupSelection == false
                          ? fetchContactList()
                          : getGroupContactsApi(updateGroupId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == true) {
                          return ListView.builder(
                              itemCount: contactDataModelOBJ.data?.length,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if (buttonTitle == 'Select') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ContactDetails(),
                                        ),
                                      );
                                    } else {
                                      selectedContactIDS.add(contactDataModelOBJ
                                              .data?[index].id
                                              .toString() ??
                                          "");
                                    }
                                  },
                                  child: SizedBox(
                                    height: 84,
                                    child: Card(
                                      elevation: 0,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  radius: 20.0,
                                                  backgroundImage: NetworkImage(
                                                      contactDataModelOBJ
                                                              .data?[index]
                                                              .image
                                                              .toString() ??
                                                          ""),
                                                )),
                                            title: Text(
                                              contactDataModelOBJ
                                                      .data?[index].name
                                                      .toString() ??
                                                  "",
                                              style: const TextStyle(
                                                  fontFamily:
                                                      Constants.fontFamily,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            trailing: Text(
                                              contactDataModelOBJ
                                                      .data?[index].createdAt
                                                      .toString() ??
                                                  "",
                                              style: const TextStyle(
                                                  fontFamily:
                                                      Constants.fontFamily,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
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
                      })),
            ),
          ],
        ),
      ),
    );
  }

  //---------------------------------------------Custom Add Group Popup-----------------------------------------------------

  Future addGroup(BuildContext context) {
    // show the dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: dialogueBox(),
          actions: const <Widget>[],
        );
      },
    );
  }

  Widget dialogueBox() {
    return SizedBox(
      height: 174,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Please Enter a group name',
                  style: TextStyle(
                      fontFamily: Constants.fontFamily,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              child: Center(
                child: SizedBox(
                  height: 44,
                  child: TextField(
                    style: const TextStyle(
                        fontFamily: Constants.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                    controller: groupName,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintText: 'Enter group name.',
                        hintStyle: TextStyle(
                          color: Colors.grey[300],
                          fontFamily: Constants.fontFamily,
                        ),
                        fillColor: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: SizedBox(
                      height: 50.0,
                      child: OutlinedButton(
                        onPressed: () {
                          createGroupApi(groupName.text.toString());
                        },
                        child: Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: Constants.fontFamily,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const StadiumBorder(),
                        ),
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

//---------------------------------------------Fetch Contact List-----------------------------------------------------

  Future<ContactsModel> fetchContactList() async {
    print('fetchContactList');
    //EasyLoading.show(status: 'loading...');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    Uri _url = Uri.parse(
        Constants.baseUrl.toString() + Constants.contact_List.toString());

    data = {'userId': user.data?.id.toString() ?? ""};

    print(data);

    headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    final response = await http.post(
      _url,
      body: data,
      headers: headerData,
    );

    print(response.body);
    if (response.body.isEmpty != true) {
      ContactsModel contactObj =
          ContactsModel.fromJson(json.decode(response.body));
      contactDataModelOBJ = contactObj;
    }
    return contactDataModelOBJ;
  }
  //---------------------------------------------Create Group Api Call-----------------------------------------------------

  Future<CreateGroupModel> createGroupApi(String groupName) async {
    //EasyLoading.show(status: 'loading...');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    var userId = user.data?.id.toString();

    Uri url = Uri.parse(
        Constants.baseUrl.toString() + Constants.CREATE_GROUP.toString());

    headerData = {
      'Authorization': 'Bearer $bearerToken',
    };
    var body = {'userId': userId, 'name': groupName};

    final response = await http.post(
      url,
      body: body,
      headers: headerData,
    );

    if (response.body.isEmpty != true) {
      CreateGroupModel contactObj =
          CreateGroupModel.fromJson(json.decode(response.body));
      userDataModelOBJ = contactObj;
    }

    return userDataModelOBJ;
  }

  //---------------------------------------------Group Group Api Call-----------------------------------------------------

  Future<CreateGroupModel> getUserGroupApi() async {
    //EasyLoading.show(status: 'loading...');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    var userId = user.data?.id.toString();

    Uri url = Uri.parse(
        Constants.baseUrl.toString() + Constants.GET_USER_GROUP.toString());

    Groups? group1 = Groups();
    group1.id = 1;
    group1.groupName = 'New';

    groupNames.add(group1);

    Groups? group2 = Groups();
    group2.id = 2;
    group2.groupName = 'All';

    groupNames.add(group2);

    headerData = {
      'Authorization': 'Bearer $bearerToken',
    };
    var body = {'userId': userId};

    final response = await http.post(
      url,
      body: body,
      headers: headerData,
    );

    if (response.body.isEmpty != true) {
      CreateGroupModel contactObj =
          CreateGroupModel.fromJson(json.decode(response.body));
      userGroupDataModelOBJ = contactObj;
    }

    for (int i = 0; i < userGroupDataModelOBJ.data!.length; i++) {
      Groups? group = Groups();
      group.id = userGroupDataModelOBJ.data?[i].id?.toInt() ?? 0;
      group.groupName =
          userGroupDataModelOBJ.data?[i].groupName?.toString() ?? "";

      groupNames.add(group);
    }

    return userDataModelOBJ;
  }

  //-----------------------------------------Delete Group Api-------------------------------------

  Future<CreateGroupModel> deleteUserGroupApi(String groupId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    var userId = user.data?.id.toString();

    Uri url = Uri.parse(
        Constants.baseUrl.toString() + Constants.DELETE_GROUP.toString());

    headerData = {
      'Authorization': 'Bearer $bearerToken',
    };
    var body = {'userId': userId, 'groupId': groupId};

    final response = await http.post(
      url,
      body: body,
      headers: headerData,
    );

    if (response.body.isEmpty != true) {
      CreateGroupModel contactObj =
          CreateGroupModel.fromJson(json.decode(response.body));
      userGroupDataModelOBJ = contactObj;
    }

    return userDataModelOBJ;
  }

  //-----------------------------------------Add User In Group-------------------------------------

  Future<CreateGroupModel> addUsersInGroupApi(
      String groupId, List<dynamic> contactsID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    Uri url = Uri.parse(Constants.baseUrl.toString() +
        Constants.UPDATE_GROUP_CONTACTS.toString());

    headerData = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    var body = jsonEncode({'groupId': groupId, 'contactIds': contactsID});

    final response = await http.post(
      url,
      body: body,
      headers: headerData,
    );

    if (response.body.isEmpty != true) {
      CreateGroupModel contactObj =
          CreateGroupModel.fromJson(json.decode(response.body));
      userGroupDataModelOBJ = contactObj;
    }

    return userDataModelOBJ;
  }

  //-----------------------------------------Get Group Contacts-------------------------------------

  Future<ContactsModel> getGroupContactsApi(String groupId) async {
    print('getGroupContactsApi');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    Uri url = Uri.parse(
        Constants.baseUrl.toString() + Constants.GET_GROUP_CONTACTS.toString());

    headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    var body = {'groupId': groupId};

    final response = await http.post(
      url,
      body: body,
      headers: headerData,
    );

    // setState(() {
    if (response.body.isEmpty != true) {
      ContactsModel contactObj =
          ContactsModel.fromJson(json.decode(response.body));
      contactDataModelOBJ = contactObj;
    }
    // });

    return contactDataModelOBJ;
  }
}

class Groups {
  int? id;
  String? groupName;

  Groups({
    this.id,
    this.groupName,
  });
}
