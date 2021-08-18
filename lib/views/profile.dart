import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/utils/math_utils.dart';
import 'package:vivo_registry/views/add_wallet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int tappedImage = -1;
  String coverImage = box.read('cover') == null
      ? 'assets/images/covers/1.jpg'
      : box.read('cover');
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController walletCtrl = TextEditingController();

  bool _setWallet = false;
  double _balance = 0.0;
  bool _buttonPressed = false;
  bool _isFetched = false;
  String error = "";
  @override
  Widget build(BuildContext context) {
    String _imgUrl = "https://dev.btcloud.bt" + jsonDecode(box.read('img'));
    var _user = jsonDecode(box.read('user'));
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(coverImage), fit: BoxFit.cover)),
            child: Container(
              width: double.infinity,
              height: 220,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: Column(children: [
                                    Text("Choose a cover image"),
                                    SizedBox(height: 5),
                                    Text(error,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 15)),
                                  ]),
                                  content: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 2,
                                    // height: 270,
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 100,
                                                childAspectRatio: 3 / 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemCount: coverList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                error = "";
                                                tappedImage = index;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: tappedImage == index
                                                    ? Border.all(
                                                        color: Colors.red,
                                                        width: 3)
                                                    : null,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      coverList[index]),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      child: new Text("OK"),
                                      style: ElevatedButton.styleFrom(
                                          primary: themeBT),
                                      onPressed: () {
                                        if (tappedImage == -1) {
                                          setState(() => error =
                                              "You must select one image.");
                                        } else {
                                          setState(() => coverImage =
                                              coverList[tappedImage]);
                                          box.write('cover', coverImage);
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                    ElevatedButton(
                                      child: new Text("Cancel"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () {
                                        tappedImage = -1;
                                        error = "";
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                            },
                          ).then((value) {
                            setState(() {});
                          });
                        },
                        icon: Icon(Icons.change_circle,
                            size: 25, color: Colors.white),
                      )),
                  Container(
                    alignment: Alignment(0.0, 2.2),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(_imgUrl),
                      radius: 60.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Center(
            child: Text(
              _user["name"],
              style: TextStyle(
                  fontFamily: 'Brandon Medium',
                  fontSize: 40.0,
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Center(
            child: Text(
              _user["email"],
              style: TextStyle(
                  fontFamily: 'Brandon Medium',
                  fontSize: 30.0,
                  color: Colors.black54,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              _user["empID"],
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black87,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 10),
          Divider(thickness: 2),
          SizedBox(height: 10),
          Center(
            child: Text("Wallet Information",
                style: TextStyle(
                  fontFamily: "Brandon Medium",
                  fontSize: 35,
                  color: Colors.black54,
                )),
          ),
          SizedBox(height: 20),
          box.read("private_key") == null
              ? Stack(
                  children: [
                    walletNotSetDisplay(),
                    addWalletOptions(),
                  ],
                )
              : FutureBuilder(
                  future: getAccBal(box.read('private_key')),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(children: [
                        Text("Account Address", style: TextStyle(fontSize: 20)),
                        SizedBox(height: 5),
                        SelectableText(snapshot.data[0].toString()),
                        SizedBox(height: 25),
                        Text("Balance : ${snapshot.data[1]} ETH",
                            style: TextStyle(fontSize: 20)),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    print(MediaQuery.of(context).size.height);
                                  },
                                  child: Text("Change Wallet",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.green))),
                              SizedBox(width: 20),
                              TextButton(
                                  onPressed: () {
                                    box.remove('private_key');
                                    setState(() {});
                                  },
                                  child: Text("Remove Wallet",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.red))),
                            ])
                      ]);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: LinearProgressIndicator(),
                    );
                  }),
        ]),
      ),
    );
  }

  // -------------------- Wallet Not Set Display -------------------- //
  walletNotSetDisplay() {
    return Visibility(
      visible: !_setWallet,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Not Set",
            style: TextStyle(
                color: Colors.black87,
                fontFamily: "Brandon Regular",
                fontSize: 22)),
        SizedBox(width: 10),
        TextButton.icon(
            onPressed: () {
              setState(() => _setWallet = true);
            },
            icon: Icon(Icons.edit),
            label: Text("Set Now")),
      ]),
    );
  }

  // -------------------- Add Wallet Options -------------------- //
  addWalletOptions() {
    return Visibility(
      visible: _setWallet,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Image.asset("assets/images/metamask.png", height: 20),
          SizedBox(height: 5),
          Text(_balance.toString() + "  ETH",
              style: TextStyle(fontSize: 20, color: Colors.black54)),
          SizedBox(height: 10),
          Form(
            key: _formKey,
            child: TextFormField(
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
              enabled: !_isFetched,
              enableInteractiveSelection: true,
              controller: walletCtrl,
              decoration: InputDecoration(
                  hintText: "Metamask private key",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15)),
            ),
          ),
          SizedBox(height: 5),
          _buttonPressed
              ? Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator())
              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Stack(
                    children: [
                      Visibility(
                        visible: !_isFetched,
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() => _buttonPressed = true);
                                getBalance(walletCtrl.text.trim())
                                    .then((value) {
                                  setState(() {
                                    _balance = value;
                                    _isFetched = true;
                                    _buttonPressed = false;
                                  });
                                });
                              }
                            },
                            child: Text("Check",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green))),
                      ),
                      Visibility(
                        visible: _isFetched,
                        child: TextButton(
                            onPressed: () {
                              box.write("private_key", walletCtrl.text.trim());
                              setState(() {
                                walletCtrl.clear();
                                _balance = 0.0;
                                _setWallet = false;
                                _isFetched = false;
                              });
                            },
                            child: Text("Confirm",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green))),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _balance = 0.0;
                          walletCtrl.clear();
                          _setWallet = false;
                          _isFetched = false;
                        });
                      },
                      child: Text("Cancel",
                          style: TextStyle(fontSize: 16, color: Colors.red))),
                ])
        ]),
      ),
    );
  }
}
