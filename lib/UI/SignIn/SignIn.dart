import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:testtting/UI/ResetPassword/ResetPassword.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testtting/main.dart';
import 'package:testtting/Constants/Constants.dart';
import 'package:testtting/Constants/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:obim/DataModels/SingInModel.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

import '../../DataModels/SignUpModel.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  SignInWidget createState() => SignInWidget();
}

class SignInWidget extends State<SignIn> {

  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(40));
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  Utltity utilityOBJ = new Utltity();
  var _data;
  var data;
  SharedPreferences? newUserDefault;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
      false; // Prevents focus if tap on eye
    });
  }


  void _showButtonPressDialog(BuildContext context, String provider) {}

  void signIn(BuildContext context) async {
    if (emailController.text == "") {
      return utilityOBJ.showAlert(context, "Error", "Please enter email.");
    }
    if (passwordController.text == "") {
      return utilityOBJ.showAlert(context, "Error", "Please enter password.");
    }

    final _url =
    Uri.parse(Constants.baseUrl.toString() + Constants.login.toString());
    _data = {
      'email': emailController.text,
      'fcmToken': 'asda',
      'password': passwordController.text,
      'name': 'hassan',
      'loginWith': 'signup',
      'platform': 'web',
      'socialId':
      'eyJraWQiOiJmaDZCczhDIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJodHRwczovL2FwcGxlaWQuYXBwbGUuY29tIiwiYXVkIjoiY29tLkp1c3RhZ2cuYXBwIiwiZXhwIjoxNjgxODgyOTUyLCJpYXQiOjE2ODE3OTY1NTIsInN1YiI6IjAwMDY0My45ODQ2YmVmMmI4NGQ0NDA4YmIzMWYxMzI3MDBjYTI0Ni4xMTQxIiwibm9uY2UiOiI4YWQ3Y2VhOGZhMGJlYjhjMjMzNDlkYjhhZTU1Y2JkM2E0YzE5N2Y5MmUwNDliNjI1ZTE0NjkwODc5MDExMTk2IiwiY19oYXNoIjoiNVJNTWc4TEJuRHFTQmw3MHVYZldPUSIsImVtYWlsIjoiYWJkdWxsYWhzYWRhcWF0QGhvdG1haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiYXV0aF90aW1lIjoxNjgxNzk2NTUyLCJub25jZV9zdXBwb3J0ZWQiOnRydWUsInJlYWxfdXNlcl9zdGF0dXMiOjJ9.aun8Zj7xn8zXeQNkrVs5LvuHWANpe-X1ZP9tm5z8WGgbYriix0Iglf0ft28xVY041GFxEVZqMaamIEmMua0aYokj3GVBJVjFD1L80Zg7KWZswOvVeuj7lwPXtCKXvRFRA4EEeFumDwjfpWv0g2JpZqAqrP5QpEm2LqJodRHCGQRqerzj7LOc6e-CO2agCP2JRL3Z8DUgoe_JmfXIbuUzBGhFrc_UbJdPPR4QAkmTKuLOVPhOqg21uGYGTzMfzA9p83cN8oNaS6qGOTu9T9ZXCpfKJcHSnfrGSvtV888w1Ey9hEZPZunun1yhg2pzhWnoKx1jV7jwXCxmibCbxLnrug'
    };
    var header = {'Content-Type': 'application/x-www-form-urlencoded'};

    utilityOBJ.onLoading(context);
    await http
        .post(
      _url,
      body: _data,
      headers: header,
    )
        .then((response) async {
      data = json.decode(response.body);
      utilityOBJ.onLoadingDismiss(context);

      if (data['status'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        Map<String, dynamic> user = data;

        SignUpModel userToken = SignUpModel.fromJson(user);

        var bearerToken = userToken.data?.token.toString();

        await prefs.setString('bearerToken', bearerToken.toString());

        await prefs.setString('user', jsonEncode(user));

        await prefs.setString(
            'userRole', userToken.data?.role.toString() ?? "");

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                child: BottomNavigationBarExample()),
                (e) => false);
      } else {
        Utltity().showAlert(context, 'Info', data['message'].toString());
        data = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    emailController.text = "del_check@gmail.com";
    passwordController.text = "12345678";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 100,
                child: Image.asset('assets/AppLogoScreenShot.png'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email ID',
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
                        controller: emailController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            filled: true,
                            hintText: 'Enter Email ID',
                            hintStyle: TextStyle(
                              color: Colors.grey[300],
                              fontFamily: Constants.fontFamily,
                            ),
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
                        controller: passwordController,
                        textAlignVertical: TextAlignVertical.bottom,
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
                            hintText: 'Must be atleast 6 character.',
                            hintStyle: TextStyle(
                              color: Colors.grey[300],
                              fontFamily: Constants.fontFamily,
                            ),
                            fillColor: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontFamily: Constants.fontFamily,
                            fontSize: 15,
                            color: Colors.black38),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResetPassword()));
                      }),
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
                          this.signIn(context);
                        },
                        child: Text(
                          'Sign In',
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
              const Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(children: <Widget>[
                  Expanded(child: Divider()),
                  Text("OR"),
                  Expanded(child: Divider()),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: SignInButton(
                      Buttons.AppleDark,
                      shape: shape,
                      onPressed: () {
                        _showButtonPressDialog(context, 'Google');
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: SignInButton(
                      Buttons.FacebookNew,
                      shape: shape,
                      onPressed: () {
                        _showButtonPressDialog(context, 'Facebook');
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: SignInButton(
                      Buttons.Google,
                      shape: shape,
                      onPressed: () {
                        _showButtonPressDialog(context, 'Google');
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
