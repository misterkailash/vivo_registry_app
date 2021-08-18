import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vivo_registry/config/eth_client.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/models/vivo_model.dart';
import 'package:vivo_registry/utils/math_utils.dart';
import 'package:vivo_registry/views/details.dart';
import 'package:vivo_registry/widgets/vivo_list_card.dart';

class SearchEntries extends StatefulWidget {
  const SearchEntries({Key? key}) : super(key: key);

  @override
  _SearchEntriesState createState() => _SearchEntriesState();
}

class _SearchEntriesState extends State<SearchEntries> {
  bool isClicked = false;
  List<VivoModel> resultList = <VivoModel>[];
  TextEditingController cid = TextEditingController();
  Future<List<VivoModel>> _getCidData(String cidNo) async {
    List<VivoModel> dataList = <VivoModel>[];

    //Getting total count of entries
    final count = await readContract(totalRegistered, [], contract);

    for (var i = 1; i <= count.first.toInt(); i++) {
      var result = await readContract(vivophones, [BigInt.from(i)], contract);
      if (result[2].toString() == cidNo.toString()) {
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
    }
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Text("Check Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text("Check Sale Record with CID"),
            SizedBox(height: 20),
            TextField(
              controller: cid,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(11)],
              decoration: InputDecoration(
                hintText: "CID Number",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isClicked = true;
                  });
                },
                child: Text("Fetch"),
                style: ElevatedButton.styleFrom(primary: themeBT),
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            isClicked
                ? FutureBuilder(
                    future: _getCidData(cid.text.trim()),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return snapshot.data.length > 0
                              ? Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
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
                                  ),
                                )
                              : Text("No data for such CID");
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    })
                : SizedBox.shrink(),
          ],
        ),
      )),
    );
  }
}
