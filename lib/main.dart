// ignore_for_file: use_build_context_synchronously

import 'package:apps/uitls/CustomRoute.dart';
import 'package:apps/uitls/DioUitl.dart';
import 'package:apps/uitls/Init.dart';
import 'package:apps/uitls/Sp.dart';
import 'package:apps/view/TwoPageRoute.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit(); //1. call BotToastInit

    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //使用Token登录
    loginByToken(dynamic token) async {
      DioUitl.UserToken = token.toString();
      if (token.isNotEmpty) {
        dynamic data = await DioUitl().postTo200(HttpPath.loginByTokenPath);
        if (null != data) {
          //保存用户信息
          Sp().setUserInfo(data.toString());
          Navigator.push(context, CustomRoute(const TwoPageRoute(), 0));
        } else {
          //清除用户Token
          Sp().setUserToken("");
          Sp().setUserInfo("");
        }
      }
    }

    Future future = Sp().getUserToken();
    future.then((value) => loginByToken(value));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 221, 80),
      body: Center(
          child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 80),
          child: Image.asset(
            'assets/images/wzq.png',
            width: 130,
            height: 130,
          ),
        ),
        const Text(
          "五子棋",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 260,
          height: 40,
          margin: const EdgeInsets.only(top: 50),
          child: TextButton(
            onPressed: () {
              //跳转登录
              Navigator.push(context, CustomRoute(const TwoPageRoute(), 0));
            },
            style: ButtonStyle(
                side: MaterialStateProperty.all(const BorderSide(
                    width: 2, color: Color.fromARGB(255, 25, 25, 25))),
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 255, 221, 80))),
            child: const Text(
              "登录账号",
              style: TextStyle(
                  color: Color.fromARGB(255, 15, 15, 15),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: 260,
          height: 40,
          margin: const EdgeInsets.only(top: 20),
          child: TextButton(
            onPressed: () {},
            style: ButtonStyle(
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
