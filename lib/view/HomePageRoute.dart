// ignore_for_file: file_names, no_logic_in_create_state, unused_import

import 'dart:math';
import 'dart:ui';

import 'package:apps/uitls/DioHelper.dart';
import 'package:apps/uitls/DioUitl.dart';
import 'package:apps/uitls/PlatformUtils.dart';
import 'package:apps/uitls/SocketType.dart';
import 'package:apps/uitls/WsHelper.dart';
import 'package:apps/view/RoomItemWidget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///首页
class HomePageRoute extends StatefulWidget {
  const HomePageRoute({
    Key? key,
  }) : super(key: key);

  // @override
  // State<StatefulWidget> createState() => _MyHomePageRoute();
  @override
  State<StatefulWidget> createState() {
    dynamic t = _MyHomePageRoute();
    t.call();
    return t;
  }
}

class _MyHomePageRoute extends State<HomePageRoute> {
  final bool isPhone = PlatformUtils.isAndroid || PlatformUtils.isIOS; //判断是否是手机
  List<dynamic> roomList = [];

  num screenWidth = 0; //宽度
  double screenHeight = 0; //高度
  double ratio = 0; //比例，大于1.33按竖屏适配
  double statusBasrHeight = 0; //状态栏高度

  //是否竖屏
  bool isDirection() {
    return ratio > 1.33;
  }

  //注册Socket监听
  void registerWs() {
    //房间列表
    WsHelper.getInstance().addMsgCallBack(SocketType.TYPE_ROOM_LIST, (body) {
      dynamic data = body["data"];

      //处理房间列表数据
      roomList.clear();
      roomList.addAll(data);

      setState(() {});
    });

    //房间列表部分刷新
    WsHelper.getInstance().addMsgCallBack(SocketType.TYPE_ROOM_LIST_CHANGE,
        (body) {
      dynamic data = body["data"];
      for (int i = 0; i < roomList.length; i++) {
        if (roomList[i]["id"] == data["id"]) {
          roomList[i] = data;
          setState(() {});
          break;
        }
      }
    });
  }

  //快速开始
  void quickStart() {}

  //默认调用方法
  void call() {
    //处理状态栏
    if (PlatformUtils.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //设置为透明
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    //注册WS
    registerWs();

    //获取房间列表（Ws返回）
    DioUitl().getTo200(HttpPath.enterHome);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width; //宽度
    screenHeight = mediaQueryData.size.height; //高度
    ratio = screenHeight / screenWidth; //比例
    statusBasrHeight = MediaQueryData.fromView(window).padding.top; //获取状态栏高度
    num arrange = (screenWidth.toInt() / 230);
    num gridViewRatio = 1.35;
    if (arrange.toInt() == 0) {
      arrange = 1;
    }

    switch (arrange.toInt()) {
      case 1:
        gridViewRatio = 1.70;
        break;
      case 2:
        gridViewRatio = 1.5;
        break;
      default:
        gridViewRatio = 1.35;
    }

    return MaterialApp(
      home: Scaffold(
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
              height: 55,
              color: const Color.fromARGB(255, 234, 226, 198),
              width: double.infinity,
              child: Row(
                children: [
                  Offstage(
                    offstage: isDirection(),
                    child: Container(
                        width: 160,
                        height: double.infinity,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 240, 187, 29)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0)))),
                            onPressed: quickStart,
                            child: const Text(
                              "快速开始",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ))),
                  ),
                  Flexible(
                      child: Container(
                    height: 45,
                  )),
                  Container(
                      height: 45,
                      margin: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Text(
                              "你好啦啦啦\n积分：60000",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Image.asset(
                            'assets/images/wzq.png',
                            width: 45,
                            height: 45,
                          )
                        ],
                      )),
                ],
              ),
            ),

            //大厅
            Flexible(
              child: Container(
                color: const Color.fromARGB(255, 248, 242, 219),
                height: double.infinity,
                width: double.infinity,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: roomList.length,
                  itemBuilder: (context, index) {
                    return RoomItemWidget(data: roomList[index]);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: arrange.toInt(), //每行三列
                    childAspectRatio: gridViewRatio.toDouble(), //显示区域宽高相等
                  ),
                ),
              ),
            ),
            //脚部
            Offstage(
              offstage: !isDirection(),
              child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 240, 187, 29))),
                      onPressed: quickStart,
                      child: const Text(
                        "快速开始",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ))),
            )
          ])),
    );
  }
}
