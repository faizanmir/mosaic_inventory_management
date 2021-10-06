import 'package:shared_preferences/shared_preferences.dart';

mixin AuthTokenMixin {
  static const String ACCESS_TOKEN = "PREF_KEY_ACCESS_TOKEN";

  Future<bool?> mSetAccessToken(var accessToken) async {
    var mPrefs = await SharedPreferences.getInstance();
    return mPrefs.setString(ACCESS_TOKEN, "Bearer $accessToken");
  }

  Future<String?> mGetAccessToken() async {
    var mPrefs = await SharedPreferences.getInstance();
    return mPrefs.getString(ACCESS_TOKEN);
  }

  Future<bool> deleteAccessToken() async {
    var mPrefs = await SharedPreferences.getInstance();
    return mPrefs.remove(ACCESS_TOKEN);
  }
}
