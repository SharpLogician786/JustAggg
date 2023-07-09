import 'package:flutter/material.dart';
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: contentBox(context)
        );
      },
    );
  }

  contentBox(context) {
    return Center(
      child: Container(
        height: 100,width: 100,
        child: LoadingIndicator(
            indicatorType: Indicator.ballScaleRippleMultiple, /// Required, The loading type of the widget
            colors: const [Colors.white],       /// Optional, The color collections
            strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
            backgroundColor: Colors.transparent,      /// Optional, Background of the widget
            pathBackgroundColor: Colors.black
        ),
      ),
    );
  }
  void onLoadingDismiss(BuildContext context) {
    Navigator.pop(context);
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
