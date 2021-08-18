import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vivo_registry/views/auth/login.dart';

class AppIntro extends StatefulWidget {
  const AppIntro({Key? key}) : super(key: key);

  @override
  _AppIntroState createState() => _AppIntroState();
}

class _AppIntroState extends State<AppIntro> {
  final pages = [
    PageViewModel(
        title: 'Welcome',
        body: 'Vivo Phones Sale Registry',
        image: Image.asset("assets/images/intro1.png", height: 200.0),
        footer: TextButton(
            child: Text('https://dev.btcloud.bt'), onPressed: () {})),
    PageViewModel(
      title: "A Blockchain based app",
      body: "Register your sales and enjoy the benefits.",
      image: Container(
        margin: EdgeInsets.only(top: 10),
        child: Image.asset("assets/images/intro2.png", height: 200.0),
      ),
      footer: Text('Secure, Immutable, Transparent'),
    ),
    PageViewModel(
      title: "Based on Ethereum network",
      body: "Go ahead and show your worth",
      image: Container(
        margin: EdgeInsets.only(top: 10),
        child: Image.asset("assets/images/intro3.png", height: 200.0),
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Find out more on'),
          TextButton(
            onPressed: () {},
            child: Text('https://dev.btcloud.bt'),
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: pages,
        onDone: () {
          Get.offAll(() => LoginScreen());
        },
        onSkip: () {
          Get.offAll(() => LoginScreen());
        },
        showSkipButton: true,
        skip: Text('Skip'),
        next: Icon(Icons.double_arrow),
        done: Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
          size: Size.square(10.0),
          activeSize: Size(20.0, 10.0),
          activeColor: Colors.blue,
          color: Colors.black26,
          spacing: EdgeInsets.symmetric(horizontal: 5.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
