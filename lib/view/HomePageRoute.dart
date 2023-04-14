// ignore_for_file: file_names

import 'dart:ui';

import 'package:apps/uitls/PlatformUtils.dart';
import 'package:flutter/material.dart';

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

    bool isDirection() {
      return ratio > 1.33;
    }

    //快速开始
    void quickStart() {}

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Column(children: [
          //头部
          Offstage(
            offstage: false,
            child: Container(
              height: 85,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                      width: 160,
                      height: 45,
                      margin: EdgeInsets.only(left: 25),
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
