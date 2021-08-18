import 'package:flutter/material.dart';

import '../constants.dart';

class VivoDetails extends StatelessWidget {
  final String image;
  final String name;
  final BigInt cid;
  final BigInt phone;
  final String custAddress;
  final String model;
  final BigInt imeiNo;
  final BigInt price;
  final String purchaseDate;
  final String enteredBy;

  const VivoDetails(
      {Key? key,
      required this.image,
      required this.name,
      required this.cid,
      required this.phone,
      required this.custAddress,
      required this.model,
      required this.imeiNo,
      required this.price,
      required this.purchaseDate,
      required this.enteredBy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        iconTheme: IconThemeData(color: nearlyBlack),
        centerTitle: true,
        title: Text("Sale Details", style: TextStyle(color: nearlyBlack)),
        actions: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset("assets/images/logo.png", width: 30))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),
              Stack(clipBehavior: Clip.none, children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue[300]!, nearlyDarkBlue]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ]),
                ),
                Positioned(
                  top: -40,
                  right: 5,
                  child: Image.asset(image,
                      height: MediaQuery.of(context).size.height * 0.2),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.phone_android, color: white),
                        title: Text("Model",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 25,
                                fontFamily: 'Pacifico',
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(model,
                            style: TextStyle(color: white, fontSize: 18)),
                      ),
                      ListTile(
                        leading: Icon(Icons.tag, color: white),
                        title: Text("IMEI",
                            style: TextStyle(
                                color: nearlyWhite,
                                fontSize: 25,
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.bold)),
                        subtitle: SelectableText(imeiNo.toString(),
                            style: TextStyle(color: white, fontSize: 18)),
                      ),
                      ListTile(
                        leading: Icon(Icons.attach_money, color: white),
                        title: Text("Price (Nu)",
                            style: TextStyle(
                                color: nearlyWhite,
                                fontSize: 25,
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(price.toString(),
                            style: TextStyle(color: white, fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(height: 10),
              Column(
                children: [
                  Card(
                      elevation: 2,
                      child: ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        leading: Icon(Icons.date_range, color: themeBT),
                        title: Text("Purchased Date"),
                        subtitle: Text(purchaseDate),
                      )),
                  Card(
                      elevation: 2,
                      child: ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        leading: Icon(Icons.transit_enterexit, color: themeBT),
                        title: Text("Entered By"),
                        subtitle: Text(enteredBy),
                      )),
                  Card(
                      elevation: 2,
                      child: ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        leading: Icon(Icons.person, color: themeBT),
                        title: Text("Customer"),
                        subtitle: Text(name),
                      )),
                  Card(
                      elevation: 2,
                      child: ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        leading: Icon(Icons.info, color: themeBT),
                        title: Text("CID Number"),
                        subtitle: SelectableText(cid.toString()),
                      )),
                  Card(
                      elevation: 2,
                      child: ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        leading: Icon(Icons.location_on, color: themeBT),
                        title: Text("Address"),
                        subtitle: Text(custAddress),
                      )),
                  Card(
                      elevation: 2,
                      child: ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        leading: Icon(Icons.phone, color: themeBT),
                        title: Text("Phone"),
                        subtitle: Text(phone.toString()),
                      )),
                ],
              ),

              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 15),
              //   height: MediaQuery.of(context).size.height * 0.16,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       gradient: LinearGradient(
              //         colors: [Colors.red[300]!, Colors.orange],
              //         stops: [0.5, 1.0],
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //             color: Colors.grey.withOpacity(0.5),
              //             spreadRadius: 5,
              //             blurRadius: 7,
              //             offset: Offset(0, 3))
              //       ]),
              //   child: Column(children: [
              //     ListTile(
              //       dense: true,
              //       visualDensity: VisualDensity(vertical: -4),
              //       leading: Icon(Icons.date_range, color: white),
              //       title: Text("Purchased Date",
              //           style: TextStyle(
              //               color: nearlyWhite,
              //               fontSize: 22,
              //               fontFamily: 'Source Sans Pro',
              //               fontWeight: FontWeight.bold)),
              //       subtitle: Text(purchaseDate,
              //           style: TextStyle(color: white, fontSize: 18)),
              //     ),
              //     ListTile(
              //       dense: true,
              //       visualDensity: VisualDensity(vertical: -4),
              //       leading: Icon(Icons.perm_identity, color: white),
              //       title: Text("Entered By",
              //           style: TextStyle(
              //               color: nearlyWhite,
              //               fontSize: 22,
              //               fontFamily: 'Source Sans Pro',
              //               fontWeight: FontWeight.bold)),
              //       subtitle: Text(enteredBy,
              //           style: TextStyle(color: white, fontSize: 18)),
              //     ),
              //   ]),
              // ),
              // SizedBox(height: 10),
              // Stack(
              //   clipBehavior: Clip.none,
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.symmetric(vertical: 20),
              //       height: MediaQuery.of(context).size.height * 0.346,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           gradient: LinearGradient(
              //               colors: [Colors.green[300]!, Colors.green[600]!]),
              //           boxShadow: [
              //             BoxShadow(
              //                 color: Colors.grey.withOpacity(0.5),
              //                 spreadRadius: 5,
              //                 blurRadius: 7,
              //                 offset: Offset(0, 3))
              //           ]),
              //       child: Column(children: [
              //         ListTile(
              //           dense: true,
              //           visualDensity: VisualDensity(vertical: -4),
              //           leading: Icon(Icons.person, color: white),
              //           title: Text("Customer",
              //               style: TextStyle(
              //                   color: nearlyWhite,
              //                   fontSize: 22,
              //                   fontFamily: 'Source Sans Pro',
              //                   fontWeight: FontWeight.bold)),
              //           subtitle: Text(name,
              //               style: TextStyle(color: white, fontSize: 18)),
              //         ),
              //         ListTile(
              //           dense: true,
              //           visualDensity: VisualDensity(vertical: -4),
              //           leading: Icon(Icons.info, color: white),
              //           title: Text("CID",
              //               style: TextStyle(
              //                   color: nearlyWhite,
              //                   fontSize: 22,
              //                   fontFamily: 'Source Sans Pro',
              //                   fontWeight: FontWeight.bold)),
              //           subtitle: Text(cid.toString(),
              //               style: TextStyle(color: white, fontSize: 18)),
              //         ),
              //         ListTile(
              //           dense: true,
              //           visualDensity: VisualDensity(vertical: -4),
              //           leading: Icon(Icons.location_on, color: white),
              //           title: Text("Address",
              //               style: TextStyle(
              //                   color: nearlyWhite,
              //                   fontSize: 22,
              //                   fontFamily: 'Source Sans Pro',
              //                   fontWeight: FontWeight.bold)),
              //           subtitle: Text(custAddress,
              //               style: TextStyle(color: white, fontSize: 18)),
              //         ),
              //         ListTile(
              //           dense: true,
              //           visualDensity: VisualDensity(vertical: -4),
              //           leading: Icon(Icons.phone, color: white),
              //           title: Text("Phone",
              //               style: TextStyle(
              //                   color: nearlyWhite,
              //                   fontSize: 22,
              //                   fontFamily: 'Source Sans Pro',
              //                   fontWeight: FontWeight.bold)),
              //           subtitle: Text(phone.toString(),
              //               style: TextStyle(color: white, fontSize: 18)),
              //         ),
              //       ]),
              //     ),
              //     Positioned(
              //       top: 10,
              //       right: 0,
              //       child: Image.asset("assets/images/4.png",
              //           height: MediaQuery.of(context).size.height * 0.15),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
