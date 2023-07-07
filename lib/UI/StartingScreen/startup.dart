import 'package:flutter/material.dart';
import 'package:testtting/UI/SignIn/SignIn.dart';
import 'package:testtting/UI/SignUp/SignUp.dart';

import '../../Constants/Constants.dart';

class IntialView extends StatefulWidget {
  const IntialView({Key? key}) : super(key: key);

  @override
  IntialViewState createState() => IntialViewState();
}

class IntialViewState extends State<IntialView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/AppLogoScreenShot.png'),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/AppLogoScreenShot.png'),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: SizedBox(
                      height: 50.0,
                      child: OutlinedButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUp()));
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
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 30, right: 8, left: 8),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: SizedBox(
                      height: 50.0,
                      child: OutlinedButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignIn()));
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              fontFamily: Constants.fontFamily,
                              color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const StadiumBorder(),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
