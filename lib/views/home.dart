import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/views/add_entry.dart';
import 'package:vivo_registry/views/all_entries.dart';
import 'package:vivo_registry/views/bottomnav.dart';
import 'package:vivo_registry/views/drawer.dart';
import 'package:vivo_registry/views/profile.dart';
import 'package:vivo_registry/views/search_entries.dart';
import 'package:vivo_registry/views/statistics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final titles = ["Statistics", "All Entries", "Search Details", "Profile"];
  final pages = [Statistics(), AllEntries(), SearchEntries(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: white,
            centerTitle: true,
            title: Column(
              children: [
                SizedBox(height: 5),
                Text("Vivo Sale Registry",
                    style: TextStyle(color: nearlyBlack)),
                SizedBox(height: 5),
                Text(titles[index],
                    style: TextStyle(fontSize: 15, color: Colors.teal)),
              ],
            ),
            actions: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset("assets/images/logo.png", width: 30))
            ],
          ),
        ),
        drawer: VivoDrawer(),
        body: pages[index],
        extendBody: true,
        bottomNavigationBar:
            BottomNav(index: index, onChangedTab: onChangedTab),
        floatingActionButton: Visibility(
          visible: !showFab,
          child: FloatingActionButton(
              onPressed: () {
                Get.to(() => AddEntry());
              },
              child: Icon(Icons.add),
              backgroundColor: themeBT),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  onChangedTab(index) {
    setState(() {
      this.index = index;
    });
  }
}
