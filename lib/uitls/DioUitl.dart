// ignore_for_file: file_names
import 'package:apps/uitls/DioHelper.dart';
import 'package:apps/uitls/Sp.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

//网络请求工具类
class DioUitl {
  //post请求
  dynamic post(String path, [Map<String, dynamic>? map]) async {
    final Response r;
    if (null != map) {
      final fromData = FormData.fromMap(map);
      r = await DioHelper.getInstance().getDio().post(path, data: fromData);
    } else {
      r = await DioHelper.getInstance().getDio().post(path);
    }
    return _responseProcessing(r);
  }

  //get请求
  dynamic get(String path, [Map<String, dynamic>? map]) async {
    final Response r;
    if (null != map) {
      r = await DioHelper.getInstance().getDio().get(path, data: map);
    } else {
      r = await DioHelper.getInstance().getDio().get(path);
    }
    return _responseProcessing(r);
  }

  //post请求并且结果为200返回数据源data对象
  dynamic postTo200(String path, [Map<String, dynamic>? map]) async {
    final Response r = await post(path, map);
    if (200 == r.data["code"]) {
      return r.data["data"];
    } else {
      return null;
    }
  }

  //get请求并且结果为200返回数据源data对象
  dynamic getTo200(String path, [Map<String, dynamic>? map]) async {
    final Response r = await get(path, map);
    if (200 == r.data["code"]) {
      return r.data["data"];
    } else {
      return null;
    }
  }

  //响应统一处理
  Response? _responseProcessing(Response r) {
    if (200 == r.statusCode) {
      var data = r.data;
      int code = r.data["code"];
      switch (code) {
        case 200:
          break;
        case 600:
          BotToast.showText(text: data["msg"]);
          break;
        case 602:
          //更新本地存储的Token
          Sp.getInstance().setUserToken("");

          //删除DIO Header Token
          DioHelper.getInstance().removHeader("UserToken");

          BotToast.showText(text: "账号在其它设备登录，请重新登录");
          break;
      }
      return r;
    } else if (400 == r.statusCode) {
      BotToast.showText(text: "请求错误");
    } else if (500 == r.statusCode) {
      BotToast.showText(text: "服务器错误");
    }
    return r;
  }
}

class HttpPath {
  //账号密码登录
  static const String loginPath = "/user/login";

  //Token登录
  static const String loginByTokenPath = "/user/loginByToken";
}
