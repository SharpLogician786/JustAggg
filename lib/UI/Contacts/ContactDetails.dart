import 'package:flutter/material.dart';

import '../../Constants/Constants.dart';

class ContactDetails extends StatefulWidget {
  ContactDetailsState createState() => ContactDetailsState();
}

class ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details',
            style: TextStyle(
                fontFamily: Constants.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                    'https://via.placeholder.com/150'),
                                backgroundColor: Colors.transparent,
                              ),
                              Container(
                                height: 20,
                                // color: Colors.green,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                          // color: Colors.orange,
                                          ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        // color: Colors.cyanAccent,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text('Friday, 06/02'),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                      Icons.person_add_alt_1)),
                                            )
                                          ],
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
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Text(
                              'Amar Abbas',
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.copy,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_email,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('amarjafri1472@gmail.com'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.copy,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('03146167055'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.copy,
                              size: 15,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
