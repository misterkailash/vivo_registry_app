import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RestClient {
  final String _url = 'https://dev.btcloud.bt/api/v1';
  GetStorage box = GetStorage();
  var token;

  getToken() async {
    token = jsonDecode(box.read('auth_token'))['token'];
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await getToken();
    return await http.get(Uri.parse(fullUrl), headers: setHeaders());
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: setHeaders());
  }

  setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
