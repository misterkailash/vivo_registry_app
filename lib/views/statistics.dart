import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vivo_registry/config/eth_client.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/utils/sales_bar_chart.dart';
import 'package:vivo_registry/utils/sales_data.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

// ------------------------------------ Get Stats Information --------------------------------------------//
Future<List<int>> _getStats() async {
  List<int> stats = [];
  final today = DateFormat('d/MM/yyyy').format(DateTime.now());
  int salesToday = 0, revenueToday = 0, sum = 0;

  //Getting total count of entries
  final count = await readContract(totalRegistered, [], contract);

  for (var i = 1; i <= count.first.toInt(); i++) {
    var result = await readContract(vivophones, [BigInt.from(i)], contract);
    var date = result[8];
    var price = int.parse(result[7].toString());
    if (today == date) {
      salesToday++;
      revenueToday += price;
    }
    sum += price;
  }
  stats.add(salesToday);
  stats.add(revenueToday);
  stats.add(int.parse(count.first.toString()));
  stats.add(sum);
  return stats;
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      backgroundColor: white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FutureBuilder(
            future: _getStats(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 250,
                          child: SalesBarChart(data: data)),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                            ),
                            child: Container(
                              height: height,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/images/sale1.png",
                                      height: 50,
                                    ),
                                  ),
                                  Text("Sales Today",
                                      style: TextStyle(fontSize: 18)),
                                  Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      snapshot.data[0].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35,
                                          color: Colors.blueGrey),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Container(
                              height: height,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "Nu. ${snapshot.data[1].toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Colors.blueGrey),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Revenue\nToday",
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      "assets/images/revenue1.png",
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                            ),
                            child: Container(
                              height: height,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Image.asset(
                                      "assets/images/sale2.png",
                                      height: 50,
                                    ),
                                  ),
                                  Text("Total Sales",
                                      style: TextStyle(fontSize: 18)),
                                  Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      snapshot.data[2].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35,
                                          color: Colors.blueGrey),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Container(
                              height: height,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "Nu. ${snapshot.data[3].toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Colors.blueGrey),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Total\nRevenue",
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      "assets/images/revenue2.png",
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
