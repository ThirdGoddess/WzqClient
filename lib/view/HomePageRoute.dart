// ignore_for_file: file_names

import 'dart:ui';

import 'package:apps/uitls/PlatformUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///首页
class HomePageRoute extends StatelessWidget {
  const HomePageRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final double screenWidth = mediaQueryData.size.width; //宽度
    final double screenHeight = mediaQueryData.size.height; //高度
    final double ratio = screenHeight / screenWidth; //比例，大于1.33按竖屏适配
    final bool isPhone = PlatformUtils.isAndroid || PlatformUtils.isIOS;

    //获取状态栏高度
    final double statusBasrHeight =
        MediaQueryData.fromWindow(window).padding.top;

    if (PlatformUtils.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //设置为透明
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    //是否竖屏
    bool isDirection() {
      return ratio > 1.33;
    }

    //快速开始
    void quickStart() {}

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Column(children: [
          //状态栏
          SizedBox(
            width: double.infinity,
            height: statusBasrHeight,
            child: Container(
              color: Colors.black,
            ),
          ),
          //头部
          Container(
            color: Colors.black,
            height: 85,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                    width: 160,
                    height: 45,
                    margin: EdgeInsets.only(left: 20),
                    child: TextButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 240, 187, 29))),
                        onPressed: quickStart,
                        child: const Text(
                          "快速开始",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )))
              ],
            ),
          ),
          //大厅
          Flexible(
            child: Container(
              width: double.infinity,
              color: Color.fromARGB(255, 254, 254, 254),
            ),
          ),
          //脚部
          Offstage(
            offstage: !isDirection(),
            child: Container(
              color: Color.fromARGB(255, 196, 7, 7),
              height: 65,
              width: double.infinity,
            ),
          )
        ]));
  }
}
