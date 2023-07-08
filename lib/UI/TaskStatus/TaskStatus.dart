import 'package:flutter/material.dart';

import '../../Constants/Constants.dart';

class TaskStatus extends StatefulWidget {
  const TaskStatus({Key? key}) : super(key: key);
  TaskStatusState createState() => TaskStatusState();
}

class TaskStatusState extends State<TaskStatus> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
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
        title: const Text('Complete your task',
            style: TextStyle(
                fontFamily: Constants.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Container(
                width: double.infinity,
                height: 120,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    elevation: 1,
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 6,
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                  child: Column(
                                    children: [
                                      Text('Add Profile Picture',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color: Colors.black)),
                                      Spacer(),
                                      Text('By clicking pencil edit button',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17.0,
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                                // color: Colors.green,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/check.png'),
                                ),
                                //color: Colors.orange,
                              )),
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Container(
                width: double.infinity,
                height: 120,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    elevation: 1,
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 6,
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.0, bottom: 20.0),
                                  child: Column(
                                    children: [
                                      Text('Add Cover Picture',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color: Colors.black)),
                                      Spacer(),
                                      Text(
                                        'By clicking pencil edit button',
                                        style: TextStyle(
                                            fontFamily: Constants.fontFamily,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17.0,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                                // color: Colors.green,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/check.png'),
                                ),
                                //color: Colors.orange,
                              )),
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Container(
                width: double.infinity,
                height: 150,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    elevation: 1,
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 6,
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                  child: Column(
                                    children: [
                                      Text('Add Company Logo Picture',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color: Colors.black)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Going to business mode and clicking pencil edit button',
                                            style: TextStyle(
                                                fontFamily:
                                                    Constants.fontFamily,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15.0,
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ))
                                    ],
                                  ),
                                ),
                                // color: Colors.green,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/check.png'),
                                ),
                                //color: Colors.orange,
                              )),
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Container(
                width: double.infinity,
                height: 130,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    elevation: 1,
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 6,
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.0, bottom: 20.0),
                                  child: Column(
                                    children: [
                                      Text('Add First Social Link',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color: Colors.black)),
                                      Spacer(),
                                      Text('By clicking on + icon on home page',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(

                                              fontFamily: Constants.fontFamily,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15.0,
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                                // color: Colors.green,
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/check.png'),
                                ),
                                //color: Colors.orange,
                              )),
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Container(
                width: double.infinity,
                height: 135,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    elevation: 1,
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 6,
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.0, bottom: 20.0),
                                  child: Column(
                                    children: [
                                      Text('Activate Your Device',
                                          style: TextStyle(
                                              fontFamily: Constants.fontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color: Colors.black)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              'By clicking on active button on menu tab',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily:
                                                      Constants.fontFamily,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15.0,
                                                  color: Colors.black)))
                                    ],
                                  ),
                                ),
                                // color: Colors.green,
                              )),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/check.png'),
                                ),
                                //color: Colors.orange,
                              )),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
