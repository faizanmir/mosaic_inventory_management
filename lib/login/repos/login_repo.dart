import 'package:mosaic_inventory_management/auth_token_prefs/auth_token_mixin.dart';
import 'package:mosaic_inventory_management/login/services/web/web.dart';
import 'package:mosaic_inventory_management/models/default_response.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';

class LoginRepository with AuthTokenMixin implements LoginWebApi {
  LoginWebApi loginWebApi = serviceLocator<LoginWebApi>();
  @override
  Future<DefaultResponse> doLogin(String email, String password) async {
    return loginWebApi.doLogin(email, password);
  }
}
