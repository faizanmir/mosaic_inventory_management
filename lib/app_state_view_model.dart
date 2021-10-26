import 'package:mosaic_inventory_management/auth_token_prefs/auth_token_mixin.dart';

class AppStateViewModel with AuthTokenMixin{

  Future<bool> checkForLoginCredentials() async{
    String? authToken  = await mGetAccessToken();
    return (authToken!=null && authToken.isNotEmpty);
  }

}