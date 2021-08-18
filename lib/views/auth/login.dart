import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/utils/rest_client.dart';
import 'package:vivo_registry/views/auth/register.dart';
import 'package:vivo_registry/views/loading.dart';
import 'package:vivo_registry/views/wallet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginClicked = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _login() async {
      var data = {
        'email': _emailCtrl.text.trim(),
        'password': _passCtrl.text.trim()
      };

      var response = await RestClient().postData(data, '/login');
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (body['success']) {
          _emailCtrl.clear();
          _passCtrl.clear();
          box.write("authenticated", true);
          box.write("auth_token", jsonEncode(body['token']));
          box.write('user', jsonEncode(body['user']));
          box.write('img', jsonEncode(body['imgPath']));
          box.read('pirvate_key') == null
              ? Get.offAll(() => WalletScreen())
              : Get.offAll(() => LoadEth());
        } else {
          setState(() {
            isLoginClicked = false;
          });
          Get.snackbar("Failed", "Invalid Credentials");
        }
      } else {
        isLoginClicked = false;
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
          child: Center(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(40),
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text("Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Center(child: Text("Login to your account")),
                  SizedBox(height: 20),
                  Visibility(
                      visible: !showKeyboard,
                      child: Center(
                          child: Image.asset("assets/images/sign_in.png",
                              width: 250))),
                  SizedBox(height: 40),
                  TextFormField(
                      controller: _emailCtrl,
                      decoration: InputDecoration(
                          hintText: "E-mail",
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.all(15)),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'E-mail cannot be empty';
                        }
                        return null;
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: _passCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.all(15)),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      }),
                  SizedBox(height: 10),
                  TextButton(
                      onPressed: () {},
                      child: Text("Forgot Password?",
                          style: TextStyle(color: themeBT))),
                  SizedBox(height: 25),
                  isLoginClicked
                      ? Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(color: themeBT)),
                        )
                      : SizedBox(
                          height: _height * 0.05,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    isLoginClicked = true;
                                  });
                                  _login();
                                }
                              },
                              child: Text("Login"),
                              style:
                                  ElevatedButton.styleFrom(primary: themeBT))),
                  SizedBox(height: 30),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("No account?"),
                    TextButton(
                        onPressed: () {
                          _formKey.currentState!.reset();
                          _emailCtrl.clear();
                          _passCtrl.clear();
                          FocusScope.of(context).unfocus();
                          Get.to(() => RegisterScreen());
                        },
                        child:
                            Text("Sign up", style: TextStyle(color: themeBT)))
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
