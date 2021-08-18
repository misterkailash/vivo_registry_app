import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_validator/string_validator.dart';
import 'package:vivo_registry/config/eth_client.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/utils/math_utils.dart';
import 'package:vivo_registry/views/loading.dart';
import 'package:web3dart/web3dart.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  _AddWalletState createState() => _AddWalletState();
}

late EthereumAddress walletAddress;
late Credentials cred;
double _balance = 0.0;
TextEditingController acc = TextEditingController();

Future<double> getBalance(String key) async {
  cred = await ethClient.credentialsFromPrivateKey(key);
  walletAddress = await cred.extractAddress();
  final bal = await ethClient.getBalance(walletAddress);
  double balInEth =
      roundDouble(bal.getValueInUnit(EtherUnit.ether).toDouble(), 4);
  return balInEth;
}

Future<List<dynamic>> getAccBal(String key) async {
  List<dynamic> accDetails = [];
  cred = await ethClient.credentialsFromPrivateKey(key);
  walletAddress = await cred.extractAddress();
  accDetails.add(walletAddress);
  final bal = await ethClient.getBalance(walletAddress);
  double balInEth =
      roundDouble(bal.getValueInUnit(EtherUnit.ether).toDouble(), 4);
  accDetails.add(balInEth);
  return accDetails;
}

class _AddWalletState extends State<AddWallet> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var arg = Get.arguments;
  bool buttonPressed = false;
  bool isFetched = false;

  @override
  void initState() {
    initialSetup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(30),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Image.asset("assets/images/metamask.png", width: 150),
                  SizedBox(height: 10),
                  Text(_balance.toString() + " ETH",
                      style: TextStyle(fontSize: 50)),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                  Text(
                    "Input your Metamask Account private key",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      enabled: !isFetched,
                      controller: acc,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Private key cannot be empty';
                        } else if (!isHexadecimal(val)) {
                          return 'Invalid private key';
                        } else if (val.length % 2 != 0) {
                          return 'Key length must be even';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Private Key",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15)),
                    ),
                  ),
                  SizedBox(height: 20),
                  buttonPressed
                      ? CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: themeBT),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          buttonPressed = true;
                                        });
                                        getBalance(acc.text.trim())
                                            .then((value) {
                                          setState(() {
                                            _balance = value;
                                            buttonPressed = false;
                                            isFetched = true;
                                          });
                                        });
                                      }
                                    },
                                    child: Text("Check")),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.redAccent),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      _formKey.currentState!.reset();
                                      setState(() {
                                        acc.text = "";
                                        _balance = 0.0;
                                        isFetched = false;
                                      });
                                    },
                                    child: Text("Clear")),
                              ),
                            ]),
                  isFetched
                      ? Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: ElevatedButton(
                              onPressed: () {
                                box.write("private_key", acc.text);
                                arg == "ADD"
                                    ? getCredentials()
                                        .whenComplete(() => Get.back())
                                    : Get.offAll(() => LoadEth());
                              },
                              child: Text("Confirm")))
                      : SizedBox.shrink(),
                ])),
          ),
        ),
      ),
    );
  }
}
