// ignore_for_file: file_names
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(validateStatus: (statusCode) {
  if (200 == statusCode) {
    return true;
  }

  if (500 == statusCode) {
    return true;
  }

  return false;
}));

//网络请求工具类
class DioUitl {
  static String UserToken = "";

  DioUitl() {
    // Map<String,dynamic> headers = Map();
    // headers["UserToken"] = userToken;
    dio.options.baseUrl = 'http://192.168.1.52:8081';
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
    dio.options.headers["UserToken"] = UserToken;
  }

  //post请求
  post(String path, [Map<String, dynamic>? map]) async {
    if (null != map) {
      final fromData = FormData.fromMap(map);
      final r = await dio.post(path, data: fromData);
      return _responseProcessing(r);
    } else {
      final r = await dio.post(path);
      return _responseProcessing(r);
    }
  }

  //post请求并且结果为200返回数据源data对象
  postTo200(String path, [Map<String, dynamic>? map]) async {
    final Response r = await post(path, map);
    if (200 == r.data["code"]) {
      return r.data["data"];
    } else {
      return null;
    }
  }

  //响应统一处理
  _responseProcessing(Response r) {
    if (200 == r.statusCode) {
      var data = r.data;
      int code = r.data["code"];
      switch (code) {
        case 200:
          break;
        case 600:
          BotToast.showText(text: data["msg"]);
          break;
      }
      return r;
    } else if (400 == r.statusCode) {
      BotToast.showText(text: "请求错误");
    } else if (500 == r.statusCode) {
      BotToast.showText(text: "服务器错误");
    }
    return null;
  }
}

class HttpPath {
  //账号密码登录
  static const String loginPath = "/user/login";

  //Token登录
  static const String loginByTokenPath = "/user/loginByToken";
}
