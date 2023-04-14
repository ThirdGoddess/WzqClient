// ignore_for_file: file_names

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

///Loading工具类
class LoadingUitl {
  //打开Loading
  static void showLoading() {
    BotToast.showLoading(
        backButtonBehavior: BackButtonBehavior.none,
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(
          seconds: 12,
        ),
        backgroundColor: Color.fromARGB(111, 0, 0, 0));
  }

  //关闭Loading
  static void closeAllLoading() {
    BotToast.closeAllLoading();
  }
}
