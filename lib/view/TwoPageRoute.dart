import 'package:flutter/material.dart';

class TwoPageRoute extends StatelessWidget {
  const TwoPageRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 221, 80),
      body: Center(
          child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: Image.asset(
            'assets/images/wzq.png',
            width: 180,
            height: 180,
          ),
        ),
        const Text(
          "五子棋",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        Container(
            width: 300,
            height: 50,
            margin: const EdgeInsets.only(top: 50),
            child: TextField(
              decoration: InputDecoration(
                labelText: '请输入账号',
                contentPadding: EdgeInsets.all(18),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: TextButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                side: MaterialStateProperty.all(const BorderSide(
                    width: 2, color: Color.fromARGB(255, 25, 25, 25))),
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 255, 221, 80))),
            child: const Text(
              "注册账号",
              style: TextStyle(
                  color: Color.fromARGB(255, 15, 15, 15),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ])),
    );
  }
}
