import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../Constants/Constants.dart';
import '../../Constants/Utilities.dart';
import '../../DataModels/AppLinks.dart';

class CustomDialog extends StatefulWidget {

  const CustomDialog({Key? key, required this.topLabel, required this.meesage}) : super(key: key);
  final String topLabel;
  final String meesage;
  @override
  CustomDialogState createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> {
  @override

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

  contentBox(context,)
  {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            width: 60,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset('assets/check.png'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.topLabel,
            style: const TextStyle(
                fontFamily: Constants
                    .fontFamily,
                fontWeight:
                FontWeight.w700,
                fontSize: 17.0),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.meesage,
            style: const TextStyle(
                fontFamily: Constants
                    .fontFamily,
                fontWeight:
                FontWeight.w400,
                fontSize: 17.0),
          ),Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: SizedBox(
                  height: 50.0,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Ok',
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
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}