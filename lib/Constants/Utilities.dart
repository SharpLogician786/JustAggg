import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

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

  void onLoading(BuildContext context) {
    EasyLoading.show(status: '');
  }
  void onLoadingDismiss(BuildContext context) {
    EasyLoading.dismiss();
  }


  String parseDate(String currentDate)
  {
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(currentDate);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM-dd-yy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }


//  Date Format Setting

  // date = '2021-01-26T03:17:00.000000Z';
  // DateTime parseDate =
  // new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
  // var inputDate = DateTime.parse(parseDate.toString());
  // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  // var outputDate = outputFormat.format(inputDate);
  // print(outputDate)


}
