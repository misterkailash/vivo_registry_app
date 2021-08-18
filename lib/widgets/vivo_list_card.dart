import 'package:flutter/material.dart';

Widget vivoListCard(
    {required String image,
    required String name,
    required BigInt cid,
    required BigInt phone,
    required String custAddress,
    required String model,
    required BigInt imeiNo,
    required BigInt price,
    required String purchaseDate,
    required String enteredBy}) {
  return Card(
    elevation: 2,
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Image.asset(
            image,
            height: 80,
          ),
          Expanded(
            child: Column(children: [
              Text(model,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("IMEI: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(imeiNo.toString()),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Purchased By: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(name.toString())),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Purchased Date: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(purchaseDate.toString()),
              ]),
              SizedBox(height: 5),
              // Divider(indent: 15, endIndent: 15, thickness: 1),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(children: [
                  Divider(),
                  Text("click for more details...",
                      style: TextStyle(color: Colors.grey))
                ]),
              ),
            ]),
          ),
        ],
      ),
    ),
  );
}
