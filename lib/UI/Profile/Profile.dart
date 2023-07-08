import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:testtting/Constants/Constants.dart';

import 'package:testtting/UI/App%20Links%20&%20Link%20Store/AppLinks.dart';
import 'package:testtting/UI/Edit Contact/Edit Contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../DataModels/SignUpModel.dart';

import 'package:testtting/DataModels/GetUserModel.dart';

import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  File? galleryImage;
  File? dpImage;

  var userRole = 'personal';
  bool socialOrNot = true;

  late GetUserModel userDataModelOBJ = GetUserModel();
  // ignore: prefer_typing_uninitialized_variables
  var data;
  // ignore: prefer_typing_uninitialized_variables
  var _headerData;

  late SignUpModel profileUserData;

  TextEditingController nameField = TextEditingController();

  TextEditingController mobileField = TextEditingController();

  TextEditingController emailField = TextEditingController();

  bool leadModeSwitch = false;

  bool isPersonalMode = false;

  bool elseMode = false;

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

  //------------------------------------Fetch Data-------------------------------------

  Future<SignUpModel> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    profileUserData = SignUpModel.fromJson(userMap);

    return profileUserData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _yourFunction() {
    print('got it CLicked');
  }

  Widget socialButton(BuildContext context) {
    return Expanded(
        flex: 4,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50),
            child: InkWell(
              onTap: () {
                setState(() {
                  socialOrNot = !socialOrNot;
                  if (socialOrNot == true) {
                    userRole = 'personal';
                  } else {
                    userRole = 'business';
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                height: 40.0,
                width: 90,
                child: const Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                          // <-- Icon
                          Icons.person,
                          size: 24.0,
                          color: Colors.black),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Social',
                        style: TextStyle(
                            fontFamily: Constants.fontFamily,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget businessButton(BuildContext context) {
    return Expanded(
        flex: 4,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50),
            child: InkWell(
              onTap: () {
                setState(() {
                  socialOrNot = !socialOrNot;
                  if (socialOrNot == true) {
                    userRole = 'personal';
                  } else {
                    userRole = 'business';
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                height: 40.0,
                width: 90,
                child: const Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Business',
                        style: TextStyle(
                            fontFamily: Constants.fontFamily,
                            color: Colors.white,
                            fontSize: 15),
                      ), // <-- Text
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        // <-- Icon
                        Icons.person_4_rounded,
                        size: 24.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  ///////////////////////////////////////////Main Widget/////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          heroTag: null,
          elevation: 5,
          onPressed: () {
            // Applink
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const Applink(),
              ),
            );
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        // physics: const AlwaysScrollableScrollPhysics(),
        child: FutureBuilder(
          future: fetchDataFromUserApi(userRole),
          builder: (context, snapshot) {
            if (snapshot.hasData == true) {
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
                                height:
                                    MediaQuery.of(context).size.height * .35,
                                color: Colors.blue,
                                child: galleryImage != null
                                    ? Image.file(
                                        galleryImage!,
                                        fit: BoxFit.fill,
                                      )
                                    : FadeInImage.assetNetwork(
                                        placeholder: 'assets/placeholder.jpeg',
                                        image: snapshot.data?.data?.coverUrl
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
                                                      image: snapshot.data?.data
                                                              ?.profileUrl
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
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: IconButton(
                                        onPressed: () async {
                                          Uri url = Uri.parse(snapshot
                                                  .data?.data?.baseUrl
                                                  .toString() ??
                                              "");

                                          _launchUrl(url);
                                        },
                                        icon: const Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),

                                socialOrNot == true
                                    ? socialButton(context)
                                    : businessButton(context),
                                // Expanded(
                                //     flex: 4,
                                //     child: Container(
                                //       color: Colors.transparent,
                                //       height: 40.0,
                                //       child: Align(
                                //         alignment: Alignment.center,
                                //         child: FloatingActionButton.extended(
                                //           heroTag: null,
                                //           label: Text(
                                //             socialOrNot == true
                                //                 ? 'Social'
                                //                 : 'Business',
                                //             style: TextStyle(
                                //                 fontFamily:
                                //                     Constants.fontFamily,
                                //                 color: socialOrNot == true
                                //                     ? Colors.black
                                //                     : Colors.white,
                                //                 fontSize: 15),
                                //           ), // <-- Text
                                //           backgroundColor: socialOrNot == true
                                //               ? Colors.white
                                //               : Colors.black,
                                //           elevation: 0.0,
                                //           icon: Icon(
                                //             // <-- Icon
                                //             Icons.person,
                                //             size: 24.0,
                                //             color: socialOrNot == true
                                //                 ? Colors.black
                                //                 : Colors.white,
                                //           ),
                                //           onPressed: () {
                                //             setState(() {
                                //               if (userRole == 'personal') {
                                //                 socialOrNot = false;
                                //                 userRole = 'business';
                                //               } else {
                                //                 socialOrNot = true;
                                //                 userRole = 'personal';
                                //               }
                                //             });
                                //           },
                                //         ),
                                //       ),
                                //     )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      color: Colors.transparent,
                                      child: IconButton(
                                        onPressed: () {
                                          Share.share(
                                              'Hey, \n You can find my profile: \n ${snapshot.data?.data?.baseUrl.toString() ?? ""} ');
                                        },
                                        icon: const Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, right: 15.0),
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
                    height: MediaQuery.of(context).size.height * 0.02,
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
                              borderSide: const BorderSide(
                                  width: 0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            filled: true,
                            hintText:
                                userDataModelOBJ.data?.username.toString() ??
                                    "",
                            hintStyle: TextStyle(
                              color: Colors.grey[300],
                              fontFamily: Constants.fontFamily,
                            ),
                            fillColor: Colors.grey[200]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
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
                              borderSide: const BorderSide(
                                  width: 0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            filled: true,
                            hintText: '',
                            hintStyle: TextStyle(
                              color: Colors.grey[300],
                              fontFamily: Constants.fontFamily,
                            ),
                            fillColor: Colors.grey[200]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: TextField(
                      style: const TextStyle(
                          fontFamily: Constants.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      controller: emailField,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 0, color: Colors.grey),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                          hintText: '',
                          hintStyle: TextStyle(
                            color: Colors.grey[300],
                            fontFamily: Constants.fontFamily,
                          ),
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
                        widthFactor: 0.5,
                        child: SizedBox(
                          height: 50.0,
                          child: FloatingActionButton.extended(
                            heroTag: null,
                            label: const Text(
                              'Edit Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: Constants.fontFamily,
                              ),
                            ), // <-- Text
                            backgroundColor: Colors.black,
                            elevation: 2.0,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditContacts(
                                        userDataModel: userDataModelOBJ,
                                        coverImage: galleryImage,
                                        dpImage: dpImage,
                                      )));
                              // EditContacts
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 20.0, left: 20.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.builder(
                          itemExtent: 60.0,
                          itemCount: userDataModelOBJ.data?.links?.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 5.0, left: 5.0),
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
                                          height: 24,
                                          width: 24,
                                          child: Image.asset('assets/drag.png'),
                                        )),
                                    Expanded(
                                        flex: 4,
                                        child: Container(
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5.0),
                                                      child: SizedBox(
                                                        height: 24,
                                                        width: 24,
                                                        child: Image.network(
                                                            userDataModelOBJ
                                                                    .data
                                                                    ?.links?[
                                                                        index]
                                                                    .image ??
                                                                "",
                                                            scale: 1.0),
                                                      )),
                                                  Text(
                                                    userDataModelOBJ.data
                                                            ?.links?[index].name
                                                            .toString() ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontFamily: Constants
                                                            .fontFamily,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 17.0),
                                                  ),
                                                ],
                                              )),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          child: Switch.adaptive(
                                            value: elseMode,
                                            onChanged: (value) {
                                              setState(() {
                                                elseMode = value;
                                              });
                                            },
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                  //--------------------------------Real Code------------------------------//
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  ///////////////////////////////////////////Main Widget  End /////////////////////////////////////////////////////////////////

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

  //------------------------------------Get User Data Api Data-------------------------------------

  Future<GetUserModel> fetchDataFromUserApi(String userRole) async {
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

    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    prefs.setString("userRole", userRole);

    var body = {'role': userRole};

    final response = await http.post(
      url,
      body: body,
      headers: _headerData,
    );

    if (response.body.isEmpty != true) {
      GetUserModel contactObj =
          GetUserModel.fromJson(json.decode(response.body));
      userDataModelOBJ = contactObj;

      var data = json.decode(response.body);

      Map<String, dynamic> user = data;

      prefs.setString('user', jsonEncode(user));

      SignUpModel userToken = SignUpModel.fromJson(user);

      var bearerToken = userToken.data?.token.toString();

      prefs.setString('bearerToken', bearerToken.toString());

      prefs.setString('userRole', userToken.data?.role.toString() ?? "");
    }

    nameField.text = userDataModelOBJ.data?.name.toString() ?? "";

    mobileField.text = '${userDataModelOBJ.data?.designation.toString() ?? ""}'
        " "
        '${userDataModelOBJ.data?.company.toString() ?? ""}';

    emailField.text = userDataModelOBJ.data?.bio.toString() ?? "";

    userRole = userDataModelOBJ.data?.role?.toString() ?? "";

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

    var userID = user.data?.id.toString() ?? "";

    Uri url = Uri.parse(Constants.baseUrl.toString() +
        Constants.CHANGE_ACCOUNT_STATUS.toString());

    var headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    final response = await http.post(
      url,
      body: {'userId': userID},
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

    var userID = user.data?.id.toString() ?? "";

    // ignore: no_leading_underscores_for_local_identifiers
    Uri _url = Uri.parse(
        Constants.baseUrl.toString() + Constants.CHANGE_MODE.toString());

    var headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    final response = await http.post(
      _url,
      body: {'userId': userID},
      headers: headerData,
    );
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
