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
    return RoomItemWidgetState();
  }
}

class RoomItemWidgetState extends State<RoomItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(5),
        width: 100,
        height: 100,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
        ),
      ),
    );
  }
}
