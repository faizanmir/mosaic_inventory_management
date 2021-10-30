import 'package:mosaic_inventory_management/models/login_cached_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin AuthTokenMixin {
  static const String ACCESS_TOKEN = "PREF_KEY_ACCESS_TOKEN";
  static const String USERS = "PREF_KEY_USERS";
  static const String PASSWORDS = "PREF_KEY_PASSWORD";

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

  Future<void> saveProfile(String email,String password) async{
    var mPrefs = await SharedPreferences.getInstance();
    var users  = mPrefs.getStringList(USERS);
    if(users!=null && !users.contains(email)) {
      users.add(email);
      mPrefs.setStringList(USERS,users);
      mPrefs.setString(PASSWORDS+email, password);
    }else if(users==null){
      users  = List.empty(growable: true);
      users.add(email);
      mPrefs.setStringList(USERS, users);
      mPrefs.setString(PASSWORDS+email, password);
    }
  }

  Future<List<LoginCachedUser>> getLoginCachedUsers() async{
    List<LoginCachedUser> loginCachedUsers = [];
    var mPrefs = await SharedPreferences.getInstance();
    mPrefs.getStringList(USERS)?.forEach((element) {
      loginCachedUsers.add( LoginCachedUser(element,mPrefs.getString(PASSWORDS+element) ));
    });
    return loginCachedUsers;
  }

  Future<void> deleteCachedUser(String email) async{
    var mPrefs = await SharedPreferences.getInstance();
    var fetchedUsers = mPrefs.getStringList(USERS);
    if(fetchedUsers!= null&& fetchedUsers.contains(email)){
      fetchedUsers.remove(email);
      mPrefs.remove(PASSWORDS+email);
      mPrefs.setStringList(USERS, fetchedUsers);
    }
  }


}
