import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vivo_registry/config/eth_client.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/utils/register_dialog.dart';
import 'package:vivo_registry/views/add_wallet.dart';
import 'package:vivo_registry/widgets/add_textfield.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({Key? key}) : super(key: key);

  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  bool submitPressed = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController custName = TextEditingController();
  TextEditingController cid = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController imei = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController purchasedDate = TextEditingController();

  @override
  void dispose() {
    custName.dispose();
    cid.dispose();
    mobile.dispose();
    address.dispose();
    model.dispose();
    imei.dispose();
    price.dispose();
    purchasedDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: white,
        iconTheme: IconThemeData(color: nearlyBlack),
        centerTitle: true,
        title: Text("Vivo Sale Registry", style: TextStyle(color: nearlyBlack)),
        actions: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset("assets/images/logo.png", width: 30))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(35),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Register a Sale",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                    SizedBox(height: 5),
                    Text(
                        "Each registered sale will be added to blockchain network"),
                    SizedBox(height: 30),
                    registerTextField(
                        hintText: "Customer Name",
                        controller: custName,
                        textCapitalization: TextCapitalization.words),
                    SizedBox(height: 15),
                    registerTextField(
                        hintText: "CID Number",
                        controller: cid,
                        keyboardtype: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11)
                        ]),
                    SizedBox(height: 15),
                    registerTextField(
                        hintText: "Mobile Number",
                        controller: mobile,
                        keyboardtype: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(8)]),
                    SizedBox(height: 15),
                    registerTextField(
                      hintText: "Address",
                      controller: address,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    SizedBox(height: 15),
                    registerTextField(
                        hintText: "Vivo Model",
                        controller: model,
                        textCapitalization: TextCapitalization.words),
                    SizedBox(height: 15),
                    registerTextField(
                        hintText: "IMEI Number",
                        controller: imei,
                        keyboardtype: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15)
                        ]),
                    SizedBox(height: 15),
                    registerTextField(
                        hintText: "Price (in Nu.)", controller: price),
                    SizedBox(height: 15),
                    registerTextField(
                        showCursor: true,
                        readOnly: true,
                        ontap: () {
                          FocusScope.of(context).unfocus();
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015, 1),
                                  lastDate: DateTime.now())
                              .then((value) {
                            var outputFormat = DateFormat('dd/MM/yyyy');
                            purchasedDate.text =
                                outputFormat.format(value!.toLocal());
                          });
                        },
                        hintText: "Purchased Date",
                        controller: purchasedDate),
                    SizedBox(height: 20),
                    submitPressed
                        ? SizedBox(
                            height: 35,
                            width: 35,
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  box.read("private_key") == null
                                      ? Get.to(() => AddWallet(),
                                          arguments: "ADD")
                                      : setState(() {
                                          submitPressed = true;
                                        });
                                  writeContract(
                                          registerPhone,
                                          [
                                            custName.text.trim(),
                                            BigInt.from(
                                                int.parse(cid.text.trim())),
                                            BigInt.from(
                                                int.parse(mobile.text.trim())),
                                            address.text.trim(),
                                            model.text.trim(),
                                            BigInt.from(
                                                int.parse(imei.text.trim())),
                                            BigInt.from(
                                                int.parse(price.text.trim())),
                                            purchasedDate.text.trim(),
                                            jsonDecode(
                                                box.read('user'))['empID']
                                          ],
                                          contract)
                                      .then((value) {
                                    setState(() {
                                      submitPressed = false;
                                      showRegisteredDialog(context, value);
                                      // showSuccessDialog(value);
                                    });
                                  });
                                },
                                child: Text("Submit"),
                                style:
                                    ElevatedButton.styleFrom(primary: themeBT)),
                          ),
                  ]),
            )),
      ),
    );
  }
}
