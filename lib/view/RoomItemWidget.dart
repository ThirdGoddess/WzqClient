// ignore_for_file: no_logic_in_create_state, use_key_in_widget_constructors, file_names, prefer_interpolation_to_compose_strings

import 'package:apps/uitls/DioUitl.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

///房间item组件
class RoomItemWidget extends StatefulWidget {
  final dynamic data;

  const RoomItemWidget({
    @required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // String nickA = userNickA ?? "【暂无】";
    // String nickB = userNickB ?? "【暂无】";
    return RoomItemWidgetState();
  }
}

class RoomItemWidgetState extends State<RoomItemWidget> {
  //加入房间
  void enterRoom() async {
    Map<String, dynamic> map = {};
    map["id"] = getData()["id"];
    dynamic data = await DioUitl().postTo200(HttpPath.enterSeat, map);
    if (null != data && 200 == data["code"]) {
      BotToast.showText(text: "加入成功");
    }
  }

  //背景色
  Color background = const Color.fromARGB(255, 255, 255, 255);

  //获取data
  dynamic getData() {
    return widget.data;
  }

  //获取名字
  //type:1=A；2=B
  String getNick(int type) {
    if (1 == type) {
      if (null == getData()["userNickA"]) {
        return "[暂无]";
      } else {
        return "【" + getData()["userNickA"] + "】";
      }
    }

    if (2 == type) {
      if (null == getData()["userNickB"]) {
        return "[暂无]";
      } else {
        return "【" + getData()["userNickB"] + "】";
      }
    }

    return "[未知]";
  }

  //获取名字字体颜色
  //type:1=A；2=B
  Color getNickColor(int type) {
    if (1 == type) {
      if (null == getData()["userNickA"]) {
        return const Color.fromARGB(255, 190, 190, 190);
      } else {
        return const Color.fromARGB(255, 8, 0, 255);
      }
    }

    if (2 == type) {
      if (null == getData()["userNickB"]) {
        return const Color.fromARGB(255, 190, 190, 190);
      } else {
        return const Color.fromARGB(255, 8, 0, 255);
      }
    }

    return const Color.fromARGB(255, 190, 190, 190);
  }

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
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(children: [
                Text(
                  "${widget.data["id"]}号桌",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Text(
                      "${widget.data["type"] > 0 ? "对局中" : "空闲中"}-观战${widget.data["observerCount"]}"),
                )
              ]),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color.fromARGB(255, 232, 232, 232),
              ),
              const SizedBox(
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
                        child: Text(
                          "棋手1：${getNick(1)}",
                          style: TextStyle(color: getNickColor(1)),
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 2,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "棋手2：${getNick(2)}",
                          style: TextStyle(color: getNickColor(2)),
                        ),
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
                  Flexible(
                      child: Container(
                    width: double.infinity,
                    height: 35,
                    margin: const EdgeInsets.only(right: 5),
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
                  )),
                  Flexible(
                      child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 35,
                    width: double.infinity,
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
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
