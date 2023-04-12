// ignore_for_file: file_names
import 'package:shared_preferences/shared_preferences.dart';

//sp工具类
class Sp {
  Sp._internal();

  static final Sp _instance = Sp._internal();

  static const String _tag_ = "sp_";
  static const String _userToken = "${_tag_}user_token";
  static const String _userInfo = "${_tag_}user_info";
  //============================================================================

  //设置用户Token
  setUserToken(String token) async {
    await _setString(_userToken, token);
  }

  Future getUserToken() {
    return _getString(_userToken);
  }

  //设置用户信息
  setUserInfo(String info) async {
    await _setString(_userInfo, info);
  }

  getUserInfo() {
    return _getString(_userInfo);
  }

  //============================================================================

  Future _getString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  Future _setString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, value);
  }
}
