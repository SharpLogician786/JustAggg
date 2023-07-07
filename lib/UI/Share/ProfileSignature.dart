import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:testtting/Constants/Constants.dart';

import '../../DataModels/GetUserModel.dart';

class Signature extends StatefulWidget {
  const Signature({Key? key, required this.userDataModel}) : super(key: key);

  final GetUserModel userDataModel;
  @override
  SignatreState createState() => SignatreState();
}

class SignatreState extends State<Signature> {
  @override
  bool isIncludeQr = false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Signature Preview',
          style:
              TextStyle(fontFamily: Constants.fontFamily, color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 54,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              children: [
                Checkbox(
                    value: isIncludeQr,
                    onChanged: (bool? selected) {
                      setState(() {
                        isIncludeQr = !isIncludeQr;
                      });
                    }),
                const Text(
                  'Include QR Code',
                  style: TextStyle(
                      fontFamily: Constants.fontFamily,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            FadeInImage.assetNetwork(
                              placeholder: 'assets/placeholder.jpeg',
                              image: widget.userDataModel.data?.profileUrl
                                      .toString() ??
                                  "",
                              fit: BoxFit.fill,
                              imageScale: 1.0,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.userDataModel.data?.name.toString() ?? "",
                              style: const TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.userDataModel.data?.designation
                                      .toString() ??
                                  "",
                              style: const TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.userDataModel.data?.company.toString() ??
                                  "",
                              style: const TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.userDataModel.data?.address.toString() ??
                                  "",
                              style: const TextStyle(
                                  fontFamily: Constants.fontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 2.0,
                      height: MediaQuery.of(context).size.height,
                      color: const Color.fromARGB(69, 158, 158, 158),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              QrImageView(
                                data: widget.userDataModel.data?.baseUrl
                                        .toString() ??
                                    "",
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                              const Text(
                                'Connect with me ',
                                style: TextStyle(
                                    fontFamily: Constants.fontFamily,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: FloatingActionButton.extended(
              label: const Text(
                'Save Email Signature',
                style: TextStyle(
                    fontFamily: Constants.fontFamily, color: Colors.black),
              ), // <-- Text
              backgroundColor: Colors.white,
              icon: const Icon(
                // <-- Icon
                Icons.download,
                size: 24.0,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
