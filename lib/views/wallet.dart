import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/views/add_wallet.dart';
import 'package:vivo_registry/views/loading.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(25),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text("Lets setup your Wallet",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Image.asset("assets/images/wallet.jpg"),
                SizedBox(height: 60),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => AddWallet(), arguments: "LOGIN");
                        },
                        child: Text("I have a wallet"),
                        style: ElevatedButton.styleFrom(primary: themeBT))),
                SizedBox(height: 15),
                TextButton(
                    onPressed: () {
                      Get.offAll(() => LoadEth());
                    },
                    child: Text("I'll setup later",
                        style: TextStyle(color: themeBT)))
              ])),
        ),
      ),
    );
  }
}
