import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testtting/NetworkCall/NetworkCall.dart';
import 'package:testtting/Constants/Constants.dart';
import 'package:testtting/Constants/Utilities.dart';
import 'package:testtting/UI/SignIn/SignIn.dart';
import 'dart:convert' as convert;
import 'package:page_transition/page_transition.dart';

// import 'package:http/http.dart' as http;

import 'package:testtting/DataModels/SignUpModel.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  SignUpWidget createState() => SignUpWidget();
}

// QUERYURL urls = new QUERYURL();

class SignUpWidget extends State<SignUp> {
  //TODO:- Variables

  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  Utltity utilityOBJ = new Utltity();
  // NetworkCall nc = new NetworkCall();

  SignUpModel dataModel = new SignUpModel();
  bool agree = false;
  var _data;
  TextEditingController nameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  //TODO:- Functions

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void _doSomething() {
    // Do something
  }

  void signUP(BuildContext context) async {
    if (nameController.text == "") {
      return utilityOBJ.showAlert(context, "Error", "Please enter full name.");
    }
    if (mobileController.text == "") {
      return utilityOBJ.showAlert(
          context, "Error", "Please enter mobile number.");
    }
    if (emailController.text == "") {
      return utilityOBJ.showAlert(context, "Error", "Please enter email.");
    }
    if (passwordController.text == "") {
      return utilityOBJ.showAlert(context, "Error", "Please enter password.");
    }
    if (agree == false) {
      return utilityOBJ.showAlert(
          context, "Error", "Please check terms and condition checkbox.");
    }
    _data = {
      'email': emailController.text,
      'loginWith': 'signup',
      'fcmToken': 'asda',
      'platform': 'mobile',
      'password': passwordController.text,
      'name': nameController.text,
      'phone': mobileController.text
    };
    final _url =
        Uri.parse(Constants.baseUrl.toString() + Constants.Signup.toString());

    RestAPI()
        .postReq(context, _url, _data, 'Info', 'Waiting For Response', true)
        .then((value) {
      if (value != null) {
        // Storage().addDetails(value, 'userData');
        print('SignIN');
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop, child: SignIn()),
            (e) => false);
      } else {
        print('Not SignIN');
      }
    });

    //nc.NetworkCallforGetData(_url as String, Map());

    // await http
    //     .post(_url,
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode({
    //       'email': emailController.text,
    //       'loginWith': 'signup',
    //       'fcmToken': 'asda',
    //       'platform': 'mobile',
    //       'password': passwordController.text,
    //       'name': nameController.text,
    //       'phone': mobileController.text
    //     }))
    //     .then((response) async {
    //   var data = json.decode(response.body);
    //   print(data);
    //   if (response.statusCode == 201) {
    //     // If the server did return a 201 CREATED response,
    //     // then parse the JSON.
    //     dataModel = SignUpModel.fromJson(jsonDecode(response.body));
    //
    //     print(dataModel.data?.phone);
    //
    //     return dataModel;
    //   } else {
    //     // If the server did not return a 201 CREATED response,
    //     // then throw an exception.
    //     throw Exception('Failed to create album.');
    //   }
    // });
  }

  //TODO:- Widgets

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 45,
                width: 100,
                child: Image.asset('assets/AppLogoScreenShot.png'),
              ),
              const SizedBox(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              fontFamily: Constants.fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Full Name',
                          style: TextStyle(
                              fontFamily: Constants.fontFamily,
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        )),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 54,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextField(
                          style: const TextStyle(
                              fontFamily: Constants.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          controller: nameController,
                          textAlignVertical: TextAlignVertical.bottom,
                          // controller: usernameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              filled: true,
                              hintText: 'Enter Full Name',
                              hintStyle: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  color: Colors.grey[300]),
                              fillColor: Colors.white70),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
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
                    SizedBox(
                      height: 44,
                      child: TextField(
                        style: const TextStyle(
                            fontFamily: Constants.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                        textAlignVertical: TextAlignVertical.bottom,
                        controller: mobileController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            filled: true,
                            hintText: 'Enter Mobile Number',
                            hintStyle: TextStyle(
                                fontFamily: Constants.fontFamily,
                                color: Colors.grey[300]),
                            fillColor: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
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
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 44,
                      child: TextField(
                        style: const TextStyle(
                            fontFamily: Constants.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                        textAlignVertical: TextAlignVertical.bottom,
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            filled: true,
                            hintText: 'Enter Email',
                            hintStyle: TextStyle(
                                fontFamily: Constants.fontFamily,
                                color: Colors.grey[300]),
                            fillColor: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                              fontFamily: Constants.fontFamily,
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        )),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 44,
                      child: TextField(
                        style: const TextStyle(
                            fontFamily: Constants.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                        textAlignVertical: TextAlignVertical.bottom,
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: GestureDetector(
                                onTap: _toggleObscured,
                                child: Icon(
                                  _obscured
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  size: 24,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            filled: true,
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(
                                fontFamily: Constants.fontFamily,
                                color: Colors.grey[300]),
                            fillColor: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      focusColor: Colors.white,
                      activeColor: Colors.grey,
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      'I accept terms of use and privacy policy',
                      style: TextStyle(
                          fontFamily: Constants.fontFamily, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: SizedBox(
                      height: 50.0,
                      child: OutlinedButton(
                        onPressed: () {
                          signUP(context);
                        },
                        child: const Text(
                          'Create Account',
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
            ],
          ),
        ),
      ),
    );
  }
}
