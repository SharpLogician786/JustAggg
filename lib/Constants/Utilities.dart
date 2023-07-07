import 'package:flutter/material.dart';

class Utltity {


  showAlert(BuildContext context,String alertTitle,String alertMessage) async
  {

     return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(alertTitle),
            content: Text(alertMessage),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                    Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  showAlertWithoutPop(BuildContext context,String alertTitle,String alertMessage) async
  {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertTitle),
          content: Text(alertMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {

              },
            ),
          ],
        );
      },
    );
  }
}
