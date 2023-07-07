import 'package:flutter/material.dart';
import 'package:testtting/NetworkCall/NetworkCall.dart';

import '../../Constants/Constants.dart';
import '../../Constants/Utilities.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  var _data;
  var messageToShow;

  TextEditingController emailController = new TextEditingController();

  void ApiCall(BuildContext context) async {
    if (emailController.text == "") {
      return Utltity().showAlert(context, 'Info', 'Please enter email.');
    }

    Uri _url = Uri.parse(
        Constants.baseUrl.toString() + Constants.forgotPassword.toString());

    _data = {'email': emailController.text};
    //print(_data);
    RestAPI()
        .postReq(context, _url, _data, 'Info', 'Loading..', true)
        .then((value) => {
              if (value != null)
                {
                  Utltity()
                      .showAlert(context, 'Info', value['message'].toString())
                }
              else
                {
                  Utltity().showAlertWithoutPop(
                      context, 'Info', value['message'].toString())
                }
            });
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
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Constants.fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50,
                  width: 100,
                  child: Image.asset('assets/AppLogoScreenShot.png'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Text(
                  'Enter your email address for getting you Verfication Code.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: Constants.fontFamily, fontSize: 17.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 44,
                      child: TextField(
                        style: const TextStyle(
                            fontFamily: Constants.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: SizedBox(
                              height: 50.0,
                              child: OutlinedButton(
                                onPressed: () async {
                                  this.ApiCall(context);
                                },
                                child: const Text(
                                  'Send',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
