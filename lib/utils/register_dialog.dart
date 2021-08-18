import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/views/home.dart';

showRegisteredDialog(BuildContext context, String value) {
  bool isCopied = false;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Row(children: [
            Image.asset("assets/images/tick2.png", width: 30),
            SizedBox(width: 20),
            Text("SUCCESS")
          ]),
          content: Container(
              width: MediaQuery.of(context).size.width * 2,
              child: ListView(shrinkWrap: true, children: [
                Text("Successfully registered the sale."),
                SizedBox(height: 30),
                Text("Transaction Hash"),
                SizedBox(height: 10),
                TextField(
                  enabled: false,
                  maxLines: 3,
                  decoration: InputDecoration(
                      hintText: value,
                      hintStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40)),
                ),
                isCopied != true
                    ? TextButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: value));
                          setState(() => isCopied = true);
                        },
                        child: Text("Copy to clipboard"),
                      )
                    : TextButton(onPressed: null, child: Text("Copied")),
              ])),
          actions: [
            Center(
              child: ElevatedButton(
                child: new Text("OK"),
                style: ElevatedButton.styleFrom(primary: themeBT),
                onPressed: () {
                  Get.offAll(() => HomeScreen());
                },
              ),
            ),
          ],
        );
      });
    },
  );
}
