import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivo_registry/config/eth_client.dart';
import 'package:vivo_registry/models/vivo_model.dart';
import 'package:vivo_registry/utils/math_utils.dart';
import 'package:vivo_registry/views/details.dart';
import 'package:vivo_registry/widgets/vivo_list_card.dart';

import '../constants.dart';

class AllEntries extends StatefulWidget {
  const AllEntries({Key? key}) : super(key: key);

  @override
  _AllEntriesState createState() => _AllEntriesState();
}

class _AllEntriesState extends State<AllEntries> {
  int totalEntries = 0;
  BigInt entries = BigInt.from(0);

  // ------------------------------------ Get All Information --------------------------------------------//
  Future<List<VivoModel>> _getAllData() async {
    List<VivoModel> dataList = <VivoModel>[];

    //Getting total count of entries
    final count = await readContract(totalRegistered, [], contract);

    for (var i = 1; i <= count.first.toInt(); i++) {
      var result = await readContract(vivophones, [BigInt.from(i)], contract);
      VivoModel model = VivoModel(
          name: result[1],
          cid: result[2],
          phone: result[3],
          cust_address: result[4],
          model: result[5],
          imei_no: result[6],
          price: result[7],
          purchase_date: result[8],
          entered_by: result[9]);
      dataList.add(model);
    }
    return dataList;
  }

  // ------------------------------------ Build Context --------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: FutureBuilder(
            future: _getAllData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // if (snapshot.hasError) {
                //   return Center(
                //       child: Text('${snapshot.error} occured',
                //           style: TextStyle(fontSize: 18)));
                // }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data[index];
                      var image = getRandomImage();
                      return InkWell(
                        onTap: () {
                          Get.to(() => VivoDetails(
                              image: image,
                              name: item.name,
                              cid: item.cid,
                              phone: item.phone,
                              custAddress: item.cust_address,
                              model: item.model,
                              imeiNo: item.imei_no,
                              price: item.price,
                              purchaseDate: item.purchase_date,
                              enteredBy: item.entered_by));
                        },
                        child: vivoListCard(
                            image: image,
                            name: item.name,
                            cid: item.cid,
                            phone: item.phone,
                            custAddress: item.cust_address,
                            model: item.model,
                            imeiNo: item.imei_no,
                            price: item.price,
                            purchaseDate: item.purchase_date,
                            enteredBy: item.entered_by),
                      );
                    },
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
