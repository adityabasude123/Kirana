import 'dart:async';
import 'dart:ffi';

import 'package:Kirana/utils/screen_size.dart';
import 'package:Kirana/tools/custom_toast.dart';
import "package:flutter/material.dart";
import 'package:Kirana/constants/SystemColors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              )),
          title: Text(
            "Notifications",
            style: TextStyle(color: textColor),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'Currently, this feature is not there in the app',
            softWrap: true,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
