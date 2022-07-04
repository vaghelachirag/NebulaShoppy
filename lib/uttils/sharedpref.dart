import 'dart:convert';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static readObject(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get(key) != null) {
      return prefs.get(key);
    } else {
      return null;
    }
  }

  static readBool(String key) async {
    final value = await readObject(key);
    return value != null ? value : '';
  }

  static readString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(key);
    return stringValue != null ? stringValue : '';
  }

  static readInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get(key) != null) {
      return prefs.get(key);
    } else {
      return 0;
    }
  }

  static saveObject(String key, value) async {
    await saveString(key, json.encode(value));
  }

  static saveString(String key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
  }

  static saveBoolean(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static saveInt(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static resetData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
 static  clearData() {
    SharedPref.saveString(str_Token, "");
    SharedPref.saveString(str_RefreshToken, "");
    SharedPref.saveString(str_Role, "");
    SharedPref.saveString(str_DisplayName, "");
    SharedPref.saveString(str_IBO_Id, "");
    SharedPref.saveString(str_Refrence_Id, "");
    SharedPref.saveBoolean(str_IsLogin, false);
  }
}
