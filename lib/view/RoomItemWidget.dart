// ignore_for_file: no_logic_in_create_state, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';

///房间item组件
class RoomItemWidget extends StatefulWidget {
  //房间id
  final int rid;

  //类型
  final int type;

  //用户A的id
  final int userAId;

  //用户B的id
  final int userBId;

  //观战数量
  final int observerCount;

  //用户A昵称
  final String userANick;

  //用户B昵称
  final String userBNick;

  const RoomItemWidget({
    Key? key,
    required this.rid,
    required this.type,
    required this.userAId,
    required this.userBId,
    required this.observerCount,
    required this.userANick,
    required this.userBNick,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RoomItemWidgetState(
        rid, type, userAId, userBId, observerCount, userANick, userBNick);
  }
}

class RoomItemWidgetState extends State<RoomItemWidget> {
  //房间id
  final int rid;

  //类型
  final int type;

  //用户A的id
  final int userAId;

  //用户B的id
  final int userBId;

  //观战数量
  final int observerCount;

  //用户A昵称
  final String userANick;

  //用户B昵称
  final String userBNick;

  //房间状态
  String statusString = "";

  //背景色
  Color background = const Color.fromARGB(255, 255, 255, 255);

  RoomItemWidgetState(this.rid, this.type, this.userAId, this.userBId,
      this.observerCount, this.userANick, this.userBNick) {
    //加载房间状态
    statusString = type > 0 ? "对局中" : "空闲";
    background = type > 0
        ? Color.fromARGB(255, 218, 218, 218)
        : const Color.fromARGB(255, 255, 255, 255);
  }

  void enterRoom() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)],
          color: background,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(5),
        width: 210,
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Row(children: [
                Container(
                  child: Text(
                    "$rid号桌",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Text("$statusString-观战$observerCount"),
                )
              ]),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color.fromARGB(255, 232, 232, 232),
              ),
              Container(
                width: double.infinity,
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/table.png',
                    width: 50,
                    height: 50,
                  ),
                  Flexible(
                      child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text("棋手1：$userANick"),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 2,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text("棋手2：$userBNick"),
                      )
                    ],
                  ))
                ],
              ),
              const SizedBox(
                width: double.infinity,
                height: 5,
              ),
              Row(
                children: [
                  Offstage(
                    offstage: type > 1 ? true : false,
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 95,
                      height: 35,
                      child: TextButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 240, 187, 29))),
                          onPressed: enterRoom,
                          child: const Text(
                            "加入对局",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 14),
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: 95,
                    height: 35,
                    child: TextButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 240, 187, 29))),
                        onPressed: enterRoom,
                        child: const Text(
                          "观战",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
