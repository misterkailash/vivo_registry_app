import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivo_registry/config/eth_client.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/views/home.dart';

class LoadEth extends StatefulWidget {
  const LoadEth({Key? key}) : super(key: key);

  @override
  _LoadEthState createState() => _LoadEthState();
}

class _LoadEthState extends State<LoadEth> {
  @override
  void initState() {
    box.read("private_key") == null
        ? initialSetup().whenComplete(() => getDeployedContract('vivo.json')
            .whenComplete(() => getContractFunctions().whenComplete(() {
                  Timer(Duration(seconds: 2), () {
                    Get.offAll(() => HomeScreen());
                  });
                })))
        : initialSetup().whenComplete(
            () => getCredentials()
                .whenComplete(() => getDeployedContract('vivo.json'))
                .whenComplete(
                  () => getContractFunctions().whenComplete(() {
                    Timer(Duration(seconds: 2), () {
                      Get.offAll(() => HomeScreen());
                    });
                  }),
                ),
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(100),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 100),
            SizedBox(height: 20),
            LinearProgressIndicator(),
            SizedBox(height: 20),
            Text("Loading..."),
          ],
        )),
      ),
    );
  }
}
