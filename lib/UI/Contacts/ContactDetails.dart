import 'package:flutter/material.dart';
import 'package:testtting/Constants/Utilities.dart';
import 'package:testtting/DataModels/ContactModel.dart';

import '../../Constants/Constants.dart';

class ContactDetails extends StatefulWidget {

  const ContactDetails({Key? key, required this.contactDataModelOBJ, required this.index}) : super(key: key);

  final ContactsModel contactDataModelOBJ;

   final int index;

  @override
  ContactDetailsState createState() => ContactDetailsState();
}

class ContactDetailsState extends State<ContactDetails> {
  @override
  Utltity utilityOBJ = new Utltity();
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
                  height: MediaQuery.of(context).size.height * 0.33,
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
                                    widget.contactDataModelOBJ.data?[widget.index].image.toString() ?? ""),
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
                                            Text( utilityOBJ.parseDate(widget.contactDataModelOBJ.data?[widget.index].createdAt.toString() ?? "")
                                              ,style: TextStyle(fontFamily: Constants.fontFamily,fontSize: 12),),
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
                              widget.contactDataModelOBJ.data?[widget.index].name.toString() ?? "",
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
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
                            Text( widget.contactDataModelOBJ.data?[widget.index].email.toString() ?? "",
                              style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12),
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
                              Icons.phone,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(widget.contactDataModelOBJ.data?[widget.index].phone.toString() ?? ""
                            ,style: TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12),),
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
