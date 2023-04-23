import 'package:flutter/material.dart';

///对局页面
class BattlefieldPage extends StatefulWidget{
  const BattlefieldPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
   return _BattlefieldPage();
  }
}

class _BattlefieldPage extends State<BattlefieldPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 226, 198),
      body: Row(
        children: [
          Container(width: 200,height: 200,color: Colors.pink),
          Container(width: 200,height: 200,color: Colors.black,),
        ],
      ),
    ),);
  }

}