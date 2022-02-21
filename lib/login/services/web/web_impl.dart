import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mosaic_inventory_management/login/services/web/web.dart';
import 'package:mosaic_inventory_management/models/default_response.dart';
import 'package:mosaic_inventory_management/models/login_model.dart';

import '../../../constants.dart';

class LoginWebApiImpl implements LoginWebApi {
  @override
  Future<DefaultResponse> doLogin(String email, String password) async {
    final response = await http.post(Uri.parse(baseUrl + "/auth/login/"),
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return LoginModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("Login unsuccessful with response ${response.body}");
    }
  }
}
