import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testtting/Constants/Constants.dart';
// import 'package:optimx/screens/auth/login.dart';
// import 'package:optimx/services/googleAuth.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Dialogs {
  //---------------Logout Dialog Box------------------
  logout(context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Wrap(
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              color: Colors.orange,
            ),
          ],
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  //--------------------------General Alert Dialog Box---------------------------------
  void alert(BuildContext context, int type, String title, String content,
      String img) {
    /*type 0 ===>> general
       type 1 ===>> success
       type 2 ===>> warning
       type 3 ===>> error
     */
    // showGeneralDialog(barrierColor: Colors.black.withOpacity(0.5),
    //     transitionBuilder: (context, a1, a2, widget) {
    //       return Transform.scale(
    //         scale: a1.value,
    //         child: Opacity(
    //           opacity: a1.value,
    //           child: AlertDialog(
    //             contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 6),
    //             titlePadding: EdgeInsets.only(top: 10),
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(8.0)),
    //             //-------------Header Image and close button----------------
    //             title: Container(
    //               width: MediaQuery.of(context).size.width,
    //               height: 100,
    //               child: Stack(
    //                 children: [
    //                   Image.asset(img,height: 100,width: double.infinity,fit: BoxFit.contain,),
    //                   Align(
    //                     alignment: Alignment.topRight,
    //                     child: IconButton(
    //                       icon: Icon(Icons.cancel,color: type==1? Colors.lightGreen: type==3? Colors.red[600]:Constants.gold,),
    //                       onPressed: ()=>Navigator.pop(context),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             //-------------Texts and button----------------
    //             content: Container(
    //               width: MediaQuery.of(context).size.width,
    //               height: 100,
    //               child: SingleChildScrollView(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Text(title, style: TextStyle(fontWeight: FontWeight.w700),),
    //                     SizedBox(height:5),
    //                     Text(content, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[700],fontSize: 14),),
    //
    //                     SizedBox(height:20),
    //
    //                     //--------Button-------------
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         InkWell(
    //                           onTap: ()=>Navigator.pop(context),
    //                           child: Container(
    //                             padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
    //                             decoration: BoxDecoration(
    //                                 color: type==1? Colors.lightGreen: type==3? Colors.red[600]:Constants.gold,
    //                                 borderRadius: BorderRadius.circular(50),
    //                                 boxShadow: [
    //                                   BoxShadow(
    //                                     //color: type==1? Colors.lightGreen[100]: type==3? Colors.red[50]:Colors.grey[200],
    //                                     spreadRadius: 3,
    //                                     blurRadius: 4,
    //                                     offset: Offset(3, 5),
    //                                   )
    //                                 ]
    //                             ),
    //                             child: Text("OK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //
    //                     SizedBox(height:17),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //     transitionDuration: Duration(milliseconds: 200),
    //     barrierDismissible: true,
    //     barrierLabel: '',
    //     context: context,
    //     pageBuilder: (context, animation1, animation2) {
    //
    //     });
  }

  //---------------Flutter Toast------------------
  displayToast(BuildContext context, String content, int length) {
    //length 0 for short, 1 for long
    // Fluttertoast.showToast(
    //     msg: content,
    //     toastLength: length < 1? Toast.LENGTH_SHORT:Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.grey[600],
    //     textColor: Colors.white,
    //     fontSize: 14.0
    // );
  }

  void cancelToast() {
    // Fluttertoast.cancel();
  }

  //--------------------SNACKBAR-----------------------
  displaySnackbar(context, key) {
    key.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.white.withOpacity(0.6),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage(Constants.wifi),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Your device is offline",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.red[700], fontWeight: FontWeight.w600),
          )
        ],
      ),
    ));
  }
}
