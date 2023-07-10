import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Constants.dart';
import '../../Constants/Utilities.dart';
import '../../DataModels/AppLinks.dart';
import '../../DataModels/SignUpModel.dart';

class CustomDialogBoxForContent extends StatefulWidget {
  final AppLinksModel appLinks;
  final int headerIndex;
  final int index;
  final bool headerSelection;
  const CustomDialogBoxForContent(
      {Key? key,
      required this.appLinks,
      required this.headerIndex,
      required this.index,
      required this.headerSelection})
      : super(key: key);

  @override
  CustomDialogBoxForContentState createState() =>
      CustomDialogBoxForContentState();
}

class CustomDialogBoxForContentState extends State<CustomDialogBoxForContent> {
  @override
  var _headerData;

  Utltity utilityOBJ = new Utltity();

  TextEditingController filename = TextEditingController();
  TextEditingController fileValue = TextEditingController();

  File? galleryImage;
  File? dpImage;

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
              padding: const EdgeInsets.only(top: 0.0),
              child: SizedBox(
                height: 54,
                child: TextField(
                  controller: fileValue,
                  style: const TextStyle(
                      fontFamily: Constants.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
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
                      const Expanded(
                        flex: 1,
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: SizedBox(height: 50.0, child: Text('')),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: FloatingActionButton.extended(
                          elevation: 2,
                          label: const Text(
                            'Upload Icon',
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
                          deleteAppsLinksData(
                              widget.appLinks.data?[widget.headerIndex]
                                  .links?[widget.index].id
                                  .toString() ??
                                  "",
                              widget.appLinks.data?[widget.headerIndex]
                                  .links?[widget.index].value
                                  .toString() ??
                                  "");
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

                          onPressed: () async {
                            String linkid = widget
                                .appLinks
                                .data?[widget.headerIndex]
                                .links?[widget.index]
                                .linkId
                                .toString() ??
                                "";
                            String linkName = filename.text;
                            String value = fileValue.text;


                            if (linkName == "")
                              {
                                utilityOBJ.showAlert(context, 'Error', 'Please enter link name.');
                              }
                            else if (value == "")
                            {
                              utilityOBJ.showAlert(context, 'Error', 'Please enter ${widget
                                  .appLinks
                                  .data?[widget.headerIndex]
                                  .links?[widget.index]
                                  .placeholder
                                  .toString() ??
                                  ""}.');
                            }
                            else if (galleryImage?.path == null)
                            {
                              utilityOBJ.showAlert(context, 'Error', 'Please select image.');
                            }
                            else{
                              var result = uploadImage(linkid, linkName, value,
                                  galleryImage?.path.toString() ?? "");
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
                        child: galleryImage != null
                            ? Image.file(
                          galleryImage!,
                          fit: BoxFit.fill,
                        )
                            : FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.jpeg',
                            image: widget
                                .appLinks
                                .data?[widget.headerIndex]
                                .links?[widget.index]
                                .image
                                .toString() ??
                                "",
                            fit: BoxFit.fill,
                            imageScale: 1.0)),
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
                          // Place textfield
                          child: SizedBox(
                            height: 20,
                            child: TextFormField(
                              controller: filename,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                              // controller: emailController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),

                                filled: true,
                                hintText: 'Enter Name',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: Constants.fontFamily,
                                ),),

                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, right: 30.0),
                          child: Container(
                            height: 0,
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

  Future pickBannerImage(ImageSource source, bool isBannerImage) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      if (source == ImageSource.gallery) {
        final imagePick =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (imagePick != null) {
          setState(() {
            final tempImage = File(imagePick.path);
            galleryImage = tempImage;
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
      String linkId, String name, String value, filename) async {
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
    var request = http.MultipartRequest('POST', url);
    request.fields['userId'] = userID;
    request.fields['linkId'] = linkId;
    request.fields['value'] = value;
    request.fields['name'] = name;
    utilityOBJ.onLoading(context);
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

  //------------------------------------Get User Social Links-------------------------------------

  void addUpdateAppsLinksData(String linkId, String value) async {
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
  }

  //------------------------------------Get User Social Links-------------------------------------

  void deleteAppsLinksData(String linkId, String value) async {
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
  }
}
