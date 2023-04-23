// ignore_for_file: file_names, constant_identifier_names

import 'package:apps/uitls/LoadingUitl.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static const String HeaderUserToken = "UserToken";

  DioHelper._internal();

  static final DioHelper _instance = DioHelper._internal();

  static DioHelper getInstance() {
    return _instance;
  }

  //DIO
  static final _dio = Dio(BaseOptions(validateStatus: (statusCode) {
    if (200 == statusCode) {
      return true;
    }

    if (500 == statusCode) {
      return true;
    }

    return false;
  }));

  //获取dio
  Dio getDio() {
    return _dio;
  }

  //设置Header
  void setHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  //删除Header
  void removHeader(String key) {
    _dio.options.headers.remove(key);
  }

  //初始化
  void init() {
    _dio.options.baseUrl = 'http://192.168.1.52:8081';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
    _dio.interceptors.add(InterceptorsWrapper(
      //发起请求
      onRequest: (options, handler) {
        return handler.next(options);
      },
      //请求响应
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        LoadingUitl.closeAllLoading();
        return handler.next(response);
      },
      //错误请求
      onError: (DioError e, ErrorInterceptorHandler handler) {
        LoadingUitl.closeAllLoading();
        BotToast.showText(text: "连接服务器失败");
        print('连接服务器失败');
        print('连接服务器失败：' + e.toString());
        print('连接服务器失败：$e.message');
        return handler.next(e);
      },
    ));
  }
}
