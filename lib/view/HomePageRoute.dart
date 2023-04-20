// ignore_for_file: file_names

import 'dart:ui';

import 'package:apps/uitls/DioHelper.dart';
import 'package:apps/uitls/DioUitl.dart';
import 'package:apps/uitls/PlatformUtils.dart';
import 'package:apps/uitls/SocketType.dart';
import 'package:apps/uitls/WebSocketUtility.dart';
import 'package:apps/view/RoomItemWidget.dart';
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
    final bool isPhone =
        PlatformUtils.isAndroid || PlatformUtils.isIOS; //判断是否是手机

    //获取状态栏高度
    final double statusBasrHeight = MediaQueryData.fromView(window).padding.top;

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

    //房间列表
    List<int> roomList = [15, 16, 17];

    //快速开始
    void quickStart() {
      DioUitl().getTo200(HttpPath.loginPath);

      // roomList.add()
    }

    //注册WebSocket
    void registerSocket() {
      print("tinajia");
      // setState(() {});
      roomList.add(456);

      //更新房间列表
      // WebSocketUtility.getInstance()
      //     .addOnMessageCallBack(SocketType.TYPE_ROOM_LIST, (body) {
      //   print("准备更新UI");
      //   roomList.add(21);
      // List<dynamic> data = body["data"];
      // roomList.addAll(data);
      // data.forEach((element) {
      //   roomList.add(const RoomItemWidget(
      //       rid: 1,
      //       type: 0,
      //       userAId: 10080,
      //       userBId: 10081,
      //       observerCount: 156,
      //       userANick: "Whuo吕布1",
      //       userBNick: "哈哈哈哈哈哈"));
      // });
      // });
    }

    roomList.add(12);
    // registerSocket();

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
                                      borderRadius: BorderRadius.circular(0)))),
                          onPressed: registerSocket,
                          child: const Text(
                            "快速开始",
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
                child: Expanded(
                  child: ListView.builder(
                      itemCount: roomList.length,
                      itemBuilder: ((BuildContext context, int index) {
                        return RoomItemWidget(
                            rid: roomList[index],
                            type: 0,
                            userAId: 10080,
                            userBId: 10081,
                            observerCount: 156,
                            userANick: "dong",
                            userBNick: "哈哈哈哈哈哈");
                      })),
                )),
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
        ]));
  }
}
