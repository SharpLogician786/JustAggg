import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:testtting/Constants/Utilities.dart';
import '../../Constants/Constants.dart';
import '../../DataModels/AppLinks.dart';
import '../../DataModels/SignUpModel.dart';
import 'package:testtting/DataModels/UserSocialLinks';

import 'package:sticky_headers/sticky_headers.dart';

import 'ApplinkAlertDialogue.dart';

class Applink extends StatefulWidget {
  const Applink({Key? key}) : super(key: key);

  @override
  ApplinkState createState() => ApplinkState();
}

class ApplinkState extends State<Applink> {
  // ignore: prefer_typing_uninitialized_variables
  var _headerData;

  Utltity utilityOBJ = new Utltity();

  final TextEditingController _searchController = TextEditingController();

  late AppLinksModel appLinkDataModelOBJ = AppLinksModel();
  late UserSocialLinkModel socialLinkModelOBJ = UserSocialLinkModel();
  List<int> appLinkIds = [];

  final TextEditingController valueField = TextEditingController();

  String capitalize(String value) {
    var result = value[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " " && cap == true) {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
        cap = false;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Apps & Links Store',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: Constants.fontFamily,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
              child: TextField(
                style: const TextStyle(
                    fontFamily: Constants.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  // Add a clear button to the search bar
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _searchController.clear(),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20),
              child: FutureBuilder(
                future: fetchAppsLinksData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData == true) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                        itemCount: appLinkDataModelOBJ.data?.length,
                        itemBuilder: (context, index) {
                          return StickyHeader(
                            header: Container(
                              height: 54.0,
                              color: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                capitalize(appLinkDataModelOBJ
                                        .data?[index].category
                                        .toString() ??
                                    ""),
                                style: const TextStyle(
                                    fontFamily: Constants.fontFamily,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            content: SizedBox(
                              height: 150,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: appLinkDataModelOBJ
                                    .data?[index].links?.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 110,
                                ),
                                itemBuilder: (contxt, indx) {
                                  if (appLinkIds.contains(appLinkDataModelOBJ
                                      .data?[index].links?[indx].linkId)) {
                                    return ContnetBuilder(
                                        contxt, index, indx, true);
                                  } else {
                                    return ContnetBuilder(
                                        contxt, index, indx, false);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                      ),
                    );
                  } else {
                   return Container(

                   );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//------------------------------------GridView Cell-------------------------------------
  // ignore: non_constant_identifier_names
  Widget ContnetBuilder(
      // ignore: non_constant_identifier_names
      BuildContext context,
      int headerIndex,
      int index,
      bool ContentShow) {
    return Container(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // ignore: unused_local_variable
          bool headerSelection = false;
          bool contentSelection = false;
          if (appLinkDataModelOBJ.data?[headerIndex].category == 'payment') {
            headerSelection = true;
          } else {
            headerSelection = false;
          }

          if (appLinkDataModelOBJ.data?[headerIndex].category == 'content') {
            if (appLinkDataModelOBJ.data?[headerIndex].links?[index].name ==
                'Link') {
              contentSelection = true;
            } else {
              contentSelection = false;
            }
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBoxForContent(
                    appLinks: appLinkDataModelOBJ,
                    headerIndex: headerIndex,
                    index: index,
                    headerSelection: contentSelection,
                  );
                });
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    appLinks: appLinkDataModelOBJ,
                    headerIndex: headerIndex,
                    index: index,
                    headerSelection: headerSelection,
                  );
                });
          }
        },
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Image.network(appLinkDataModelOBJ
                              .data?[headerIndex].links?[index].image
                              .toString() ??
                          "")),
                  Expanded(
                    flex: 1,
                    child: FractionallySizedBox(
                        widthFactor: 1,
                        child: Center(
                          child: Text(
                            appLinkDataModelOBJ
                                    .data?[headerIndex].links?[index].name
                                    .toString() ??
                                "",
                            style: const TextStyle(
                                fontFamily: Constants.fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        )),
                  )
                ],
              ),
              Visibility(
                visible: ContentShow,
                child: Positioned(
                    top: -5,
                    right: 0,
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 0.0,
                        fillColor: Colors.black,
                        child: Icon(Icons.check, size: 20, color: Colors.white),
                        padding: EdgeInsets.all(0.0),
                        shape: CircleBorder(),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //------------------------------------All Social Links-------------------------------------

  Future<AppLinksModel> fetchAppsLinksData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    // ignore: no_leading_underscores_for_local_identifiers
    Uri _url = Uri.parse(Constants.baseUrl.toString() +
        Constants.GET_ALL_SOCIAL_LINKS.toString());

    _headerData = {
      'Authorization': 'Bearer $bearerToken',
    };


    utilityOBJ.onLoading(context);

    final response = await http.get(
      _url,
      headers: _headerData,
    );
    utilityOBJ.onLoadingDismiss(context);
    if (response.body.isEmpty != true) {
      AppLinksModel notifyObj =
          AppLinksModel.fromJson(json.decode(response.body));
      appLinkDataModelOBJ = notifyObj;
    }
    fetchUserAppsLinksData();
    return appLinkDataModelOBJ;
  }
//------------------------------------Get User Social Links-------------------------------------

  Future<AppLinksModel> fetchUserAppsLinksData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    // ignore: no_leading_underscores_for_local_identifiers
    Uri _url = Uri.parse(Constants.baseUrl.toString() +
        Constants.GET_USER_SOCIAL_LINKS.toString());

    var userID = user.data?.id.toString() ?? "";

    _headerData = {
      'Authorization': 'Bearer $bearerToken',
    };
    utilityOBJ.onLoading(context);
    final response = await http.post(
      _url,
      headers: _headerData,
      body: {'userId': userID},
    );
    utilityOBJ.onLoadingDismiss(context);
    if (response.body.isEmpty != true) {
      UserSocialLinkModel userLinkObj =
          UserSocialLinkModel.fromJson(json.decode(response.body));
      socialLinkModelOBJ = userLinkObj;
    }
    print(socialLinkModelOBJ.data!.length);
    for (int i = 0; i < socialLinkModelOBJ.data!.length; i++) {
      print('go');
      print(socialLinkModelOBJ.data?[i].linkId ?? 0);
      appLinkIds.add(socialLinkModelOBJ.data?[i].linkId ?? 0);
    }
    // print(appLinkIds);
    return appLinkDataModelOBJ;
  }
}

class CustomDialogBox extends StatefulWidget {
  final AppLinksModel appLinks;
  final int headerIndex;
  final int index;
  final bool headerSelection;
  const CustomDialogBox(
      {Key? key,
      required this.appLinks,
      required this.headerIndex,
      required this.index,
      required this.headerSelection})
      : super(key: key);

  @override
  CustomDialogBoxState createState() => CustomDialogBoxState();
}

class CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  var _headerData;
  File? galleryImaage;
  File? dpImage;
  TextEditingController fileValue = TextEditingController();
  Utltity utilityOBJ = new Utltity();
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(
    context,
  ) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: 20,
              bottom: Constants.padding),
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  height: 44,
                  child: TextField(
                    controller: fileValue,
                    style: const TextStyle(
                        fontFamily: Constants.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintText: widget.appLinks.data?[widget.headerIndex]
                            .links?[widget.index].placeholder,
                        hintStyle: TextStyle(
                          color: Colors.grey[300],
                          fontFamily: Constants.fontFamily,
                        ),
                        fillColor: Colors.white70),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Visibility(
                  visible: widget.headerSelection,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Row(
                      children: [
                         Expanded(
                          flex: 1,
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: SizedBox(height: 50.0, child: galleryImaage != null
                                ? Image.file(
                              galleryImaage!,
                              fit: BoxFit.fill) : FlutterLogo()
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FloatingActionButton.extended(
                            elevation: 2,
                            label: const Text(
                              'QR Code',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  color: Colors.black),
                            ), // <-- Text
                            backgroundColor: Colors.white,
                            icon: const Icon(
                              // <-- Icon
                              Icons.edit,
                              color: Colors.black,
                              size: 24.0,
                            ),
                            onPressed: () {
                              imageSelectionDialogue(context, false);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: FloatingActionButton.extended(
                          elevation: 2,
                          label: const Text(
                            'Delete',
                            style: TextStyle(
                                fontFamily: Constants.fontFamily,
                                color: Colors.black),
                          ), // <-- Text
                          backgroundColor: Colors.white,
                          icon: const Icon(
                            // <-- Icon
                            Icons.edit,
                            color: Colors.black,
                            size: 24.0,
                          ),
                          onPressed: () {
                            setState(() {
                              deleteAppsLinksData(
                                  widget.appLinks.data?[widget.headerIndex]
                                      .links?[widget.index].id
                                      .toString() ??
                                      "",
                                  widget.appLinks.data?[widget.headerIndex]
                                      .links?[widget.index].value
                                      .toString() ??
                                      "");
                            });

                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: SizedBox(
                          height: 50.0,
                          child: FloatingActionButton.extended(
                            elevation: 2,
                            label: const Text(
                              'Save',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  color: Colors.white),
                            ), // <-- Text
                            backgroundColor: Colors.black,
                            onPressed: () {
                              String linkid = widget
                                  .appLinks
                                  .data?[widget.headerIndex]
                                  .links?[widget.index]
                                  .linkId
                                  .toString() ??
                                  "";
                              String linkName = widget
                                  .appLinks
                                  .data?[widget.headerIndex]
                                  .links?[widget.index]
                                  .name
                                  .toString() ??
                                  "";
                              String value = fileValue.text;
                              String fileName = "";
                              print((galleryImaage?.path));
                              print('path');
                               if (value == "")
                              {
                                utilityOBJ.showAlert(context, 'Error', 'Please enter ${widget
                                    .appLinks
                                    .data?[widget.headerIndex]
                                    .links?[widget.index]
                                    .placeholder
                                    .toString() ??
                                    ""}.');
                              }else{
                                 if (galleryImaage?.path == null)
                                 {
                                   print('Roger');
                                   addUpdateAppsLinksData(linkid, value);
                                 }else{
                                   fileName = galleryImaage?.path.toString() ?? "";
                                   var result = uploadImage(linkid, linkName, value,fileName
                                   );
                                   print(result);
                               }
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            left: -10,
            child: Container(
              height: 74,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(Constants.avatarRadius)),
                          child: Image.network(widget
                                  .appLinks
                                  .data?[widget.headerIndex]
                                  .links?[widget.index]
                                  .image
                                  .toString() ??
                              "")),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              widget.appLinks.data?[widget.headerIndex]
                                      .links?[widget.index].name
                                      .toString() ??
                                  "",
                              style: const TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, right: 30.0),
                            child: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }

  //------------------------------------Get User Social Links-------------------------------------

  void addUpdateAppsLinksData(String linkId, String value) async {

    Utltity utilityOBJ = new Utltity();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    var userID = user.data?.id.toString() ?? "";
    // ignore: no_leading_underscores_for_local_identifiers
    Uri _url = Uri.parse(
        Constants.baseUrl.toString() + Constants.ADD_USER_LINK.toString());

    _headerData = {
      'Authorization': 'Bearer $bearerToken',
    };
    var bodyData = {'userId': userID, 'linkId': linkId, 'value': value};

    print(bodyData);
    utilityOBJ.onLoading(context);
    final response = await http.post(
      _url,
      headers: _headerData,
      body: bodyData,
    );
    utilityOBJ.onLoadingDismiss(context);
    if (response.body.isEmpty != true)
      {
        Navigator.pop(context);
      }
  }
  //------------------------------------Get User Social Links-------------------------------------

  void deleteAppsLinksData(String linkId, String value) async {

    Utltity utilityOBJ = new Utltity();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    var userID = user.data?.id.toString() ?? "";

    // ignore: no_leading_underscores_for_local_identifiers
    Uri _url = Uri.parse(
        Constants.baseUrl.toString() + Constants.DELETE_USER_LINK.toString());

    _headerData = {
      'Authorization': 'Bearer $bearerToken',
    };
    var bodyData = {'userId': userID, 'linkId': linkId, 'value': value};

    print(bodyData);
    utilityOBJ.onLoading(context);
    final response = await http.post(
      _url,
      headers: _headerData,
      body: bodyData,
    );
    utilityOBJ.onLoadingDismiss(context);
    Navigator.pop(context);
  }


  Future pickBannerImage(ImageSource source, bool isBannerImage) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      if (source == ImageSource.gallery) {
        final imagePick =
        await ImagePicker().pickImage(source: ImageSource.gallery);
        if (imagePick != null) {
          setState(() {
            final tempImage = File(imagePick.path);
            galleryImaage = tempImage;
          });
        } else {
          return;
        }
      } else {
        final imagePick =
        await ImagePicker().pickImage(source: ImageSource.camera);
        if (imagePick != null) {
          setState(() {
            if (isBannerImage == true) {
              final tempImage = File(imagePick.path);
              galleryImaage = tempImage;
            } else {
              final tempImage = File(imagePick.path);
              dpImage = tempImage;
            }
          });
        } else {
          return;
        }
      }
    } on Exception catch (e) {
      print('Failed to pickImage,$e');
    }
  }

  Future<String> uploadImage(
      String linkId, String name, String value, filename) async {
    Utltity utilityOBJ = new Utltity();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    var userID = user.data?.id.toString() ?? "";
    // ignore: no_leading_underscores_for_local_identifiers
    Uri url = Uri.parse(
        Constants.baseUrl.toString() + Constants.ADD_USER_LINK.toString());

    Map<String, String> headers = {
      "Accept": "application/json",
      'Authorization': 'Bearer $bearerToken',
    };
    utilityOBJ.onLoading(context);
    var request = http.MultipartRequest('POST', url);
    request.fields['userId'] = userID;
    request.fields['linkId'] = linkId;
    request.fields['value'] = value;
    request.fields['name'] = name;

    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    var res = await request.send();
    utilityOBJ.onLoadingDismiss(context);
    return res.reasonPhrase.toString();
  }

  Future imageSelectionDialogue(BuildContext context, bool isBannerImage) {
    // show the dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: dialogueBox(isBannerImage),
          actions: const <Widget>[],
        );
      },
    );
  }

  Widget dialogueBox(bool isBannerImage) {
    return Container(
      height: 230,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Select Image',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              fontFamily: Constants.fontFamily,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 2,
              color: const Color.fromARGB(255, 219, 216, 216),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    pickBannerImage(ImageSource.gallery, isBannerImage);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: SizedBox(
                    height: 105,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/gallery.png',
                            height: 44,
                            width: 44,
                          ),
                        ),
                        const Text(
                          'Gallery',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: Constants.fontFamily,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    pickBannerImage(ImageSource.camera, isBannerImage);
                  },
                  child: SizedBox(
                    height: 105,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/camera.png',
                            height: 44,
                            width: 44,
                          ),
                        ),
                        const Text(
                          'Camera',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: Constants.fontFamily,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 20.0),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: SizedBox(height: 50.0, child: Text('')),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FloatingActionButton.extended(
                      elevation: 2,
                      label: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontFamily: Constants.fontFamily,
                            color: Colors.white),
                      ), // <-- Text
                      backgroundColor: Colors.black,

                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
