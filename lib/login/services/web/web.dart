
import 'package:mosaic_inventory_management/models/default_response.dart';

abstract class LoginWebApi {
  Future<DefaultResponse> doLogin(String email, String password);
}