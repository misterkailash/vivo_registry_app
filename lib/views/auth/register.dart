import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/utils/rest_client.dart';
import 'package:vivo_registry/views/auth/login.dart';

import '../wallet.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

TextEditingController nameCtrl = TextEditingController();
TextEditingController empCtrl = TextEditingController();
TextEditingController emailCtrl = TextEditingController();
TextEditingController passCtrl = TextEditingController();

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    _register() async {
      var data = {
        'name': nameCtrl.text.trim(),
        'empID': empCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'password': passCtrl.text.trim(),
      };
      var response = await RestClient().postData(data, '/register');
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (body['success']) {
          box.write("authenticated", true);
          box.write("auth_token", jsonEncode(body['token']));
          box.write('token', jsonEncode(body['token']));
          box.write('user', jsonEncode(body['user']));
          box.write('img', jsonEncode(body['imgPath']));
          Get.offAll(() => WalletScreen());
        } else {
          var error;
          body['message']['email'] != null
              ? error = body['message']['email'][0].toString()
              : error = body['message']['password'][0].toString();
          Get.snackbar("Failed", error);
        }
      } else {
        Get.snackbar("Failed", "Internal server error. Try again later");
      }
    }

    bool showKeyboard = MediaQuery.of(context).viewInsets.bottom != 0.0;
    final _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: _height,
          child: ListView(
            padding: const EdgeInsets.all(40),
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Text("Sign up",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              ),
              Center(child: Text("Sign up for new account")),
              SizedBox(height: 20),
              Visibility(
                  visible: !showKeyboard,
                  child: Center(
                      child: Image.asset("assets/images/sign_up.png",
                          width: 150))),
              SizedBox(height: 30),
              TextField(
                  controller: nameCtrl,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(15))),
              SizedBox(height: 20),
              TextField(
                  controller: empCtrl,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                      hintText: "Employee ID",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(15))),
              SizedBox(height: 20),
              TextField(
                  controller: emailCtrl,
                  decoration: InputDecoration(
                      hintText: "BT E-mail",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(15))),
              SizedBox(height: 20),
              TextField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(15))),
              SizedBox(height: 20),
              SizedBox(
                  height: _height * 0.05,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => _register(),
                      child: Text("Sign up"),
                      style: ElevatedButton.styleFrom(primary: themeBT))),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Already have an account?"),
                TextButton(
                    onPressed: () {
                      Get.offAll(() => LoginScreen());
                    },
                    child: Text("Login", style: TextStyle(color: themeBT)))
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
