import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_vacation/data/model/entity/company.dart';
import 'package:sky_vacation/data/model/entity/user.dart';
import 'package:sky_vacation/helper/user_constant.dart';

import '../main.dart';



class SessionManager {
  final SharedPreferences? prefs;

  SessionManager(this.prefs);


//  --------------------- value ---------------
  bool containKey(String key){
    if (prefs!.containsKey(key)) {
      return true;
    }
    return false;
  }

  String getValue(String key) {
    if (prefs!.containsKey(key)) {
      return prefs!.getString(key)!;
    } else {
      return "";
    }
  }

  setValue(String key, String value) {
    prefs!.setString(key, value);
  }

  deleteValue(String key) {
    prefs!.remove(key);
  }

//-----------------------  user -----------------
  User? getUser() {
    if (prefs!.containsKey(UserConstant.user)) {
      var userString = prefs!.getString(UserConstant.user);
      return User.decodedJson(userString!);
    } else {
      return null;
    }
  }

  setUser(User? userData) {
    String userString = userData?.encodedJson() ?? "";
    setValue(UserConstant.user, userString);
    setValue(UserConstant.userLogged, "true");
  }
  setUserString(String userData) {
    // String userString = userData?.encodedJson() ?? "";
    setValue(UserConstant.user, userData);
    setValue(UserConstant.userLogged, "true");
  }
  deleteUser() {
    deleteValue(UserConstant.user);
    deleteValue(UserConstant.userLogged);
    deleteValue(UserConstant.accessToken);
    deleteValue(UserConstant.cartCounter);
    deleteValue(UserConstant.chatCounter);
    deleteValue(UserConstant.notificationCounter);
  }


  bool isUserLogged(){
    if (getValue(UserConstant.userLogged) == "true" && getValue(UserConstant.accessToken).isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }


  setCompany(Company? company) {
    String userString = company?.encodedJson() ?? "";
    setValue(UserConstant.company, userString);
  }
  Company? getCompany() {
    if (prefs!.containsKey(UserConstant.company)) {
      var userString = prefs!.getString(UserConstant.company);
      return Company.decodedJson(userString!);
    } else {
      return null;
    }
  }

  deleteCompany() {
    deleteValue(UserConstant.company);
    deleteUser();
    // firebaseMessaging?.unsubscribeFromTopic('DawimTopic');

  }
//  --------------

}
