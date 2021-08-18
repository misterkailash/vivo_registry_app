import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/views/intro.dart';
import 'package:vivo_registry/views/loading.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      box.read('authenticated') == null
          ? Get.offAll(() => AppIntro())
          : Get.offAll(() => LoadEth());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: width / 4),
            SizedBox(height: 50),
            Image.asset("assets/images/vivo.png", width: width / 12)
          ],
        ),
      ),
    );
  }
}
