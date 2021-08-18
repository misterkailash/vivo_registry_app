import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/views/splash.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vivo Sale Registry',
      theme: ThemeData(
        primaryColor: themeBT,
      ),
      home: SafeArea(child: Splash()),
    );
  }
}
