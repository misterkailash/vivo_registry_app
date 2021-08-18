import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivo_registry/constants.dart';
import 'package:vivo_registry/utils/rest_client.dart';
import 'package:vivo_registry/views/auth/login.dart';

class VivoDrawer extends StatelessWidget {
  const VivoDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logout() async {
      var response = await RestClient().getData('/logout');
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        if (body['success']) {
          box.remove('authenticated');
          box.remove('auth_token');
          box.remove('user');
          box.remove('img');
          Get.offAll(() => LoginScreen());
        }
      }
    }

    String _imgUrl = "https://dev.btcloud.bt" + jsonDecode(box.read('img'));
    var user = jsonDecode(box.read('user'));
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/drawer.jpg")),
            ),
            accountName: Text(user['name'],
                style: TextStyle(fontSize: 20, color: white)),
            accountEmail: Text(user['email'],
                style: TextStyle(
                    fontSize: 15, color: white, fontFamily: "Source Sans Pro")),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(_imgUrl),
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.account_balance_wallet,
                color: nearlyBlue,
              ),
              title: Text("My Wallet", style: TextStyle(fontSize: 16))),
          ListTile(
              leading: Icon(Icons.send_to_mobile, color: nearlyBlue),
              title: Text("Transactions", style: TextStyle(fontSize: 16))),
          Divider(),
          ListTile(
              leading: Icon(Icons.feedback, color: nearlyBlue),
              title: Text("Feedback", style: TextStyle(fontSize: 16))),
          ListTile(
              leading: Icon(Icons.contact_page, color: nearlyBlue),
              title: Text("Contact", style: TextStyle(fontSize: 16))),
          ListTile(
              onTap: () => showAboutDialog(
                  context: context,
                  applicationVersion: '1.0.0',
                  applicationLegalese: 'Developed by Kailash Rai',
                  applicationIcon:
                      Image.asset('assets/images/logo.png', width: 30)),
              leading: Icon(Icons.dashboard, color: nearlyBlue),
              title: Text("About", style: TextStyle(fontSize: 16))),
          Divider(),
          ListTile(
              onTap: _logout,
              leading: Icon(Icons.logout, color: nearlyBlue),
              title: Text("Logout", style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
