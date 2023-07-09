import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testtting/DataModels/GetUserModel.dart';

import '../../Constants/Constants.dart';
import '../../Constants/Utilities.dart';
import '../../DataModels/SignUpModel.dart';

class EditContacts extends StatefulWidget {
  const EditContacts(
      {Key? key, required this.userDataModel, this.coverImage, this.dpImage})
      : super(key: key);

  final GetUserModel userDataModel;

  final File? coverImage;
  final File? dpImage;

  @override
  EditContactState createState() => EditContactState();
}

class EditContactState extends State<EditContacts> {
  //------------------------------------Varibles and Controllers-------------------------------------
  // ignore: prefer_typing_uninitialized_variables
  var headerData;

  Utltity utilityOBJ = new Utltity();

  late SignUpModel profileUserData;

  late GetUserModel userDataModelOBJ = GetUserModel();

  final nameField = TextEditingController();

  final mobileField = TextEditingController();

  final emailField = TextEditingController();

  final jobTitleField = TextEditingController();

  final companyField = TextEditingController();

  final locationField = TextEditingController();

  final mobilePopField = TextEditingController();

  final emailPopField = TextEditingController();

  final locationPopField = TextEditingController();

  final linkPopField = TextEditingController();

  final customLinkField = TextEditingController();

  File? profileImage;

  File? dpImage;
//------------------------------------Fetch Data-------------------------------------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignValues();
  }

  void assignValues() {
    nameField.text = widget.userDataModel.data?.name.toString() ?? "";

    mobileField.text = widget.userDataModel.data?.phone.toString() ?? "";

    emailField.text = widget.userDataModel.data?.email.toString() ?? "";

    jobTitleField.text =
        widget.userDataModel.data?.designation.toString() ?? "";

    locationField.text = widget.userDataModel.data?.address.toString() ?? "";

    mobilePopField.text =
        widget.userDataModel.data?.secondaryPhone.toString() ?? "";

    emailPopField.text =
        widget.userDataModel.data?.secondaryEmail.toString() ?? "";

    companyField.text = widget.userDataModel.data?.company.toString() ?? "";

    locationField.text = widget.userDataModel.data?.address.toString() ?? "";

    linkPopField.text = widget.userDataModel.data?.contactLink.toString() ?? "";

    customLinkField.text =
        widget.userDataModel.data?.profileUrl.toString() ?? "";
  }

  //------------------------------------Widgets-------------------------------------
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contacts',
            style: TextStyle(
                fontFamily: Constants.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 15, left: 20, bottom: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'First & Last Name',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 0, left: 0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  transform:
                                      Matrix4.translationValues(0.0, 15.0, 0.0),
                                  width: double.infinity,
                                  height: 44,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      // color: Colors.grey,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextField(
                                        style: const TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                        controller: nameField,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'First Name & Last Name',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 20,
                                      color: Colors.white,
                                      child: const Center(
                                        child: Text(
                                          'First & Last Name',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  //Mobile Number Text and text field
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Mobile Number',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 0, left: 0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  transform:
                                      Matrix4.translationValues(0.0, 15.0, 0.0),
                                  width: double.infinity,
                                  height: 44,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      // color: Colors.grey,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextField(
                                        style: const TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                        controller: mobileField,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Mobile',
                                          // labelText: 'Frist Name',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height: 20,
                                      color: Colors.white,
                                      child: const Center(
                                        child: Text(
                                          'Mobile',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //Email Text and Text Feild
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 0, left: 0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  transform:
                                      Matrix4.translationValues(0.0, 15.0, 0.0),
                                  width: double.infinity,
                                  height: 44,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      // color: Colors.grey,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextField(
                                        style: const TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                        controller: emailField,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Email',
                                          // labelText: 'Frist Name',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height: 20,
                                      color: Colors.white,
                                      child: const Center(
                                        child: Text(
                                          'Email',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  //Jbb Title Text and Textfield
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Job Title',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 0, left: 0),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  transform:
                                      Matrix4.translationValues(0.0, 15.0, 0.0),
                                  width: double.infinity,
                                  height: 44,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      // color: Colors.grey,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextField(
                                        style: const TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                        controller: jobTitleField,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'JobTitle',
                                          // labelText: 'Frist Name',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      height: 20,
                                      color: Colors.white,
                                      child: const Center(
                                        child: Text(
                                          'Job Title',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //Organization and company text and textfield
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Organization/Company',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 0, left: 0),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  transform:
                                      Matrix4.translationValues(0.0, 15.0, 0.0),
                                  width: double.infinity,
                                  height: 44,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      // color: Colors.grey,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextField(
                                        style: const TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                        controller: companyField,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Organization/Company',
                                          // labelText: 'Frist Name',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      height: 20,
                                      color: Colors.white,
                                      child: const Center(
                                        child: Text(
                                          'Organization / Company',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //Location Text and textfield
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Location',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 0, left: 0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  transform:
                                      Matrix4.translationValues(0.0, 15.0, 0.0),
                                  width: double.infinity,
                                  height: 44,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      // color: Colors.grey,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextField(
                                        style: const TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                        controller: locationField,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Location',
                                          // labelText: 'Frist Name',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      height: 20,
                                      color: Colors.white,
                                      child: const Center(
                                        child: Text(
                                          'Location',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Add More Detail Button
                  const SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: SizedBox(
                            height: 50.0,
                            child: OutlinedButton(
                              onPressed: () async {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    builder: (context) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                topRight:
                                                    Radius.circular(20.0))),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0,
                                              right: 20,
                                              top: 0,
                                              bottom: 30),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                AppBar(
                                                  title: const Text(
                                                      'Add Contact Info',
                                                      style: TextStyle(
                                                          fontFamily: Constants
                                                              .fontFamily,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0,
                                                          color: Colors.black)),
                                                  elevation: 0.0,
                                                  backgroundColor: Colors.white,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, left: 0),
                                                  child: Container(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: Stack(
                                                      clipBehavior: Clip.none,
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Container(
                                                          transform: Matrix4
                                                              .translationValues(
                                                                  0.0,
                                                                  15.0,
                                                                  0.0),
                                                          width:
                                                              double.infinity,
                                                          height: 44,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  // color: Colors.grey,
                                                                  borderRadius: const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          50))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20.0),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: TextField(
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        Constants
                                                                            .fontFamily,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                                controller:
                                                                    mobilePopField,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  prefixIcon:
                                                                      Icon(Icons
                                                                          .phone),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      'Mobile',
                                                                  // labelText: 'Frist Name',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.3,
                                                              height: 20,
                                                              color:
                                                                  Colors.white,
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  'Mobile',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          Constants
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0,
                                                          left: 0,
                                                          top: 20),
                                                  child: Container(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: Stack(
                                                      clipBehavior: Clip.none,
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Container(
                                                          transform: Matrix4
                                                              .translationValues(
                                                                  0.0,
                                                                  15.0,
                                                                  0.0),
                                                          width:
                                                              double.infinity,
                                                          height: 44,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  // color: Colors.grey,
                                                                  borderRadius: const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          50))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20.0),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: TextField(
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        Constants
                                                                            .fontFamily,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                                controller:
                                                                    emailPopField,
                                                                obscureText:
                                                                    true,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  prefixIcon:
                                                                      Icon(Icons
                                                                          .email),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      'Email',
                                                                  // labelText: 'Frist Name',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.3,
                                                              height: 20,
                                                              color:
                                                                  Colors.white,
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  'Email',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          Constants
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0,
                                                          left: 0,
                                                          top: 20),
                                                  child: Container(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: Stack(
                                                      clipBehavior: Clip.none,
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Container(
                                                          transform: Matrix4
                                                              .translationValues(
                                                                  0.0,
                                                                  15.0,
                                                                  0.0),
                                                          width:
                                                              double.infinity,
                                                          height: 44,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  // color: Colors.grey,
                                                                  borderRadius: const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          50))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20.0),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: TextField(
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        Constants
                                                                            .fontFamily,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                                controller:
                                                                    locationPopField,
                                                                obscureText:
                                                                    true,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  prefixIcon:
                                                                      Icon(Icons
                                                                          .location_on),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      'Location',
                                                                  // labelText: 'Frist Name',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.3,
                                                              height: 20,
                                                              color:
                                                                  Colors.white,
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  'Location',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          Constants
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20.0,
                                                ),
                                                Container(
                                                  transform:
                                                      Matrix4.translationValues(
                                                          0.0, 15.0, 0.0),
                                                  width: double.infinity,
                                                  height: 54,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                      ),
                                                      // color: Colors.grey,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  50))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: TextField(
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                Constants
                                                                    .fontFamily,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        controller:
                                                            linkPopField,
                                                        decoration:
                                                            const InputDecoration(
                                                          prefixIcon:
                                                              Icon(Icons.link),
                                                          border:
                                                              InputBorder.none,
                                                          hintText: 'Link',
                                                          // labelText: 'Frist Name',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20.0,
                                                ),
                                                Container(
                                                  transform:
                                                      Matrix4.translationValues(
                                                          0.0, 15.0, 0.0),
                                                  width: double.infinity,
                                                  height: 54,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                      ),
                                                      // color: Colors.grey,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  50))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: TextField(
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                Constants
                                                                    .fontFamily,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        controller:
                                                            customLinkField,
                                                        decoration:
                                                            const InputDecoration(
                                                          prefixIcon:
                                                              Icon(Icons.edit),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Custom Link',
                                                          // labelText: 'Frist Name',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 30.0,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: FractionallySizedBox(
                                                    widthFactor: 1,
                                                    child: SizedBox(
                                                        height: 50.0,
                                                        child: OutlinedButton(
                                                          onPressed: () async {
                                                            saveUserProfile(
                                                                context);
                                                          },
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.black,
                                                            shape:
                                                                const StadiumBorder(),
                                                          ),
                                                          child: const Text(
                                                            'Save Changes',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    Constants
                                                                        .fontFamily,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: FractionallySizedBox(
                                                    widthFactor: 1,
                                                    child: SizedBox(
                                                        height: 50.0,
                                                        child: OutlinedButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            shape:
                                                                const StadiumBorder(),
                                                          ),
                                                          child: const Text(
                                                            'Dismiss',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    Constants
                                                                        .fontFamily,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const StadiumBorder(),
                              ),
                              child: const Text(
                                'Add More Details',
                                style: TextStyle(
                                    fontFamily: Constants.fontFamily,
                                    color: Colors.black),
                              ),
                            )),
                      ),
                    ),
                  ),
                  //Save Button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: SizedBox(
                          height: 50.0,
                          child: OutlinedButton(
                            onPressed: () async {
                              saveUserProfile(context);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: const StadiumBorder(),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  String state = "";

  Future<GetUserModel> saveUserProfile(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userData = (prefs.getString('user') ?? '');

    Map<String, dynamic> userMap = jsonDecode(userData);

    SignUpModel user = SignUpModel.fromJson(userMap);

    var bearerToken = user.data?.token.toString();

    Uri url = Uri.parse(
        Constants.baseUrl.toString() + Constants.UPDATE_USER.toString());

    headerData = {
      'Authorization': 'Bearer $bearerToken',
    };

    var bodyData = {
      'id': widget.userDataModel.data?.id?.toString() ?? "",
      'name': nameField.text,
      'phone': mobileField.text,
      'address': locationField.text,
      'secondaryPhone': mobilePopField.text,
      'gender': 'male',
      'secondaryEmail': emailPopField.text,
      'bio': widget.userDataModel.data?.bio.toString() ?? "",
      'company': companyField.text,
      'designation': jobTitleField.text,
      'username': widget.userDataModel.data?.username.toString() ?? "",
      'leadMode': widget.userDataModel.data?.leadMode.toString() ?? "",
      'secondaryAddress': locationPopField.text,
      'contactLink': linkPopField.text,
      'customText': customLinkField.text,
    };
    utilityOBJ.onLoading(context);
    final response = await http.post(
      url,
      body: bodyData,
      headers: headerData,
    );
    utilityOBJ.onLoadingDismiss(context);
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
}
