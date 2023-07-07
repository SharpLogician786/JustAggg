import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testtting/DataModels/GetUserModel.dart';
import 'package:http/http.dart' as http;
import 'package:testtting/DataModels/SignUpModel.dart';
import 'package:testtting/NetworkCall/NetworkCall.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constants/Constants.dart';
import '../Share/Share.dart';
import 'package:share_plus/share_plus.dart';

class ManageProfile extends StatefulWidget {
  const ManageProfile({Key? key, required this.userDataModel})
      : super(key: key);

  final GetUserModel userDataModel;

  @override
  ManageProfileState createState() => ManageProfileState();
}

class ManageProfileState extends State<ManageProfile> {
  late GetUserModel userDataModelOBJ = GetUserModel();

  bool leadModeSwitch = true;

  bool isPersonalMode = false;

  File? galleryImage;

  File? dpImage;

  // ignore: prefer_typing_uninitialized_variables
  var _headerData;

  TextEditingController nameField = TextEditingController();

  TextEditingController mobileField = TextEditingController();

  TextEditingController emailField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: fetchDataFromUserApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Stack(
                  children: <Widget>[
                    // The containers in the background
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            imageSelectionDialogue(context, true);
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * .35,
                              color: Colors.blue,
                              child: galleryImage != null
                                  ? Image.file(
                                      galleryImage!,
                                      fit: BoxFit.fill,
                                    )
                                  : FadeInImage.assetNetwork(
                                      placeholder: 'assets/placeholder.jpeg',
                                      image: userDataModelOBJ.data?.coverUrl
                                              .toString() ??
                                          "",
                                      fit: BoxFit.fill,
                                      imageScale: 1.0)),
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .3,
                            right: 0.0,
                            left: 0.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            height: 95.0,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      imageSelectionDialogue(context, false);
                                    },
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        fit: StackFit.expand,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(500.0),
                                            child: dpImage != null
                                                ? Image.file(dpImage!,
                                                    fit: BoxFit.fill)
                                                : FadeInImage.assetNetwork(
                                                    placeholder:
                                                        'assets/placeholder.jpeg',
                                                    image: userDataModelOBJ
                                                            .data?.profileUrl
                                                            .toString() ??
                                                        "",
                                                    fit: BoxFit.fill,
                                                    imageScale: 1.0,
                                                  ),
                                          ),
                                          Positioned(
                                              bottom: -10,
                                              right: -30,
                                              child: RawMaterialButton(
                                                onPressed: () {},
                                                elevation: 0.0,
                                                fillColor: Colors.black,
                                                child: Icon(Icons.edit,
                                                    size: 20,
                                                    color: Colors.white),
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                shape: const CircleBorder(),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            const Text(
                                              'Lead',
                                              style: TextStyle(
                                                  fontFamily:
                                                      Constants.fontFamily,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0),
                                            ),
                                            Switch.adaptive(
                                              value: leadModeSwitch,
                                              onChanged: (isOn) {
                                                setState(() {
                                                  leadModeSwitch = isOn;
                                                  changeMode();
                                                });
                                              },
                                            ),
                                            const Text(
                                              'Personal',
                                              style: TextStyle(
                                                  fontFamily:
                                                      Constants.fontFamily,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0),
                                            ),
                                            Switch.adaptive(
                                              value: isPersonalMode,
                                              onChanged: (value) {
                                                setState(() {
                                                  isPersonalMode = value;
                                                  changeProfileMode();
                                                });
                                              },
                                            ),
                                          ],
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SafeArea(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 0.0, right: 15.0),
                              child: Container(
                                height: 30,
                                width: 30,
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 0.0,
                                  fillColor: Colors.black,
                                  child: const Icon(Icons.edit,
                                      size: 20, color: Colors.white),
                                  padding: const EdgeInsets.all(0.0),
                                  shape: const CircleBorder(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: SizedBox(
                    height: 54,
                    child: TextField(
                      style: const TextStyle(
                          fontFamily: Constants.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      controller: nameField,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 0, color: Colors.grey),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          hintText: 'Must be atleast 6 character.',
                          hintStyle: TextStyle(
                              fontFamily: Constants.fontFamily,
                              color: Colors.grey[300]),
                          fillColor: Colors.grey[200]),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: SizedBox(
                    height: 54,
                    child: TextField(
                      style: const TextStyle(
                          fontFamily: Constants.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      controller: mobileField,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.grey),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          hintText: 'Must be atleast 6 character.',
                          hintStyle: TextStyle(
                              fontFamily: Constants.fontFamily,
                              color: Colors.grey[300]),
                          fillColor: Colors.grey[200]),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: TextField(
                    style: const TextStyle(
                        fontFamily: Constants.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                    controller: emailField,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintText: 'Must be atleast 6 character.',
                        hintStyle: TextStyle(
                            fontFamily: Constants.fontFamily,
                            color: Colors.grey[300]),
                        fillColor: Colors.grey[200]),
                    maxLines: 5, // <-- SEE HERE
                    minLines: 1, // <-- SEE HERE
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: SizedBox(
                          height: 50.0,
                          child: OutlinedButton(
                            onPressed: () async {
                              saveUserProfile(context);
                            },
                            child: const Text(
                              'Update Profile',
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: SizedBox(
                          height: 50.0,
                          child: OutlinedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: const StadiumBorder(),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      )),
    );
  }
  // --------------------------------------------------Image Selection Widget--------------------------------------------------------

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

  // -----------------fetchDataFromUserApi--------------------
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

    nameField.text = userDataModelOBJ.data?.name.toString() ?? "";

    mobileField.text = userDataModelOBJ.data?.phone.toString() ?? "";

    emailField.text = userDataModelOBJ.data?.bio.toString() ?? "";

    if (userDataModelOBJ.data?.leadMode?.toInt() == 0) {
      leadModeSwitch = true;
    } else {
      leadModeSwitch = false;
    }

    if (userDataModelOBJ.data?.directMode?.toInt() == 0) {
      isPersonalMode = true;
    } else {
      isPersonalMode = false;
    }

    return userDataModelOBJ;
  }

  Future pickBannerImage(ImageSource source, bool isBannerImage) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      if (source == ImageSource.gallery) {
        final imagePick =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (imagePick != null) {
          setState(() {
            if (isBannerImage == true) {
              final tempImage = File(imagePick.path);
              galleryImage = tempImage;

              String userID = userDataModelOBJ.data?.id.toString() ?? "";

              String url = Constants.baseUrl.toString() +
                  Constants.UPDATE_USER.toString();

              String? bearerToken = pref.getString('bearerToken');

              print(bearerToken);

              var result = uploadImage('coverUrl', bearerToken!, userID,
                  galleryImage?.path.toString() ?? "", url);

              print(result.toString());
            } else {
              final tempImage = File(imagePick.path);
              dpImage = tempImage;

              String userID = userDataModelOBJ.data?.id.toString() ?? "";

              String url = Constants.baseUrl.toString() +
                  Constants.UPDATE_USER.toString();

              String? bearerToken = pref.getString('bearerToken');

              var result = uploadImage('profileUrl', bearerToken!, userID,
                  galleryImage?.path.toString() ?? "", url);

              print(result.toString());
            }
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
              galleryImage = tempImage;
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
      String fileUrl, String token, String userId, filename, url) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['id'] = userId;
    request.headers.addAll(headers);
    print(fileUrl);
    if (fileUrl == 'coverUrl') {
      request.files
          .add(await http.MultipartFile.fromPath('coverUrl', filename));
    } else {
      request.files
          .add(await http.MultipartFile.fromPath('profileUrl', filename));
    }
    var res = await request.send();
    return res.reasonPhrase.toString();
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<GetUserModel> saveUserProfile(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    Uri url = Uri.parse(
        Constants.baseUrl.toString() + Constants.UPDATE_USER.toString());

    _headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    var bodyData = {
      'id': widget.userDataModel.data?.id?.toString() ?? "",
      'name': nameField.text,
      'phone': mobileField.text,
      'gender': 'male',
      'bio': widget.userDataModel.data?.bio.toString() ?? "",
      'username': widget.userDataModel.data?.username.toString() ?? "",
      'leadMode': widget.userDataModel.data?.leadMode.toString() ?? "",
    };

    final response = await http.post(
      url,
      body: bodyData,
      headers: _headerData,
    );

    print(response.body);

    if (response.body.isEmpty != true) {
      GetUserModel contactObj =
          GetUserModel.fromJson(json.decode(response.body));
      userDataModelOBJ = contactObj;
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }

    return userDataModelOBJ;
  }

  //------------------------------------Profile Status Api Call-------------------------------------

  Future<bool?> changeProfileMode() async {
    print(
        '----------------------------------Profile Status Api Call------------------------');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data;

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    // ignore: no_leading_underscores_for_local_identifiers
    Uri _url = Uri.parse(Constants.baseUrl.toString() +
        Constants.CHANGE_ACCOUNT_STATUS.toString());

    var headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    final response = await http.post(
      _url,
      body: {'userId': '42'},
      headers: headerData,
    );
    print(response.body);
    if (response.body.isEmpty != true) {
      data = json.decode(response.body);
      if (data['status'] == 'true') {
        isPersonalMode = true;
      } else {
        isPersonalMode = false;
      }
    }
    return isPersonalMode;
  }

  //------------------------------------Lead Mode Api Call-------------------------------------

  Future<bool?> changeMode() async {
    print(
        '----------------------------------Lead Mode Api Call------------------------');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data;

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    // ignore: no_leading_underscores_for_local_identifiers
    Uri _url = Uri.parse(
        Constants.baseUrl.toString() + Constants.CHANGE_MODE.toString());

    var headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    final response = await http.post(
      _url,
      body: {'userId': '42'},
      headers: headerData,
    );
    print(response.body);
    if (response.body.isEmpty != true) {
      data = json.decode(response.body);
      if (data['status'] == 'true') {
        leadModeSwitch = true;
      } else {
        leadModeSwitch = false;
      }
    }
    return leadModeSwitch;
  }
}
