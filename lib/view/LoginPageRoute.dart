// ignore_for_file: file_names, use_build_context_synchronously

import 'package:apps/uitls/CustomRoute.dart';
import 'package:apps/uitls/DioHelper.dart';
import 'package:apps/uitls/DioUitl.dart';
import 'package:apps/uitls/LoadingUitl.dart';
import 'package:apps/uitls/Sp.dart';
import 'package:apps/uitls/WsHelper.dart';
import 'package:apps/view/HomePageRoute.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPageRoute extends StatelessWidget {
  const LoginPageRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountInput = TextEditingController();
    var passwordInput = TextEditingController();

    //调用登录
    loginApp() async {
      if (accountInput.text.isNotEmpty) {
        if (passwordInput.text.isNotEmpty) {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          dynamic param = {
            "account": accountInput.text,
            "password": passwordInput.text
          };
          LoadingUitl.showLoading();
          dynamic data = await DioUitl().postTo200(HttpPath.loginPath, param);
          if (null != data) {
            DioHelper.getInstance().setHeader(DioHelper.HeaderUserToken,
                data["token"].toString()); //设置dio header参数token
            Sp.getInstance().setUserToken(data["token"].toString()); //sp存储token
            Sp.getInstance().setUserInfo(data.toString()); //sp存储用户信息

            //设置Socket Token
            WsHelper.getInstance().setToken(data["token"].toString());

            //连接Socket
            WsHelper.getInstance().initWebSocket(
                onOpen: () {
                  BotToast.showText(text: "登录成功");

                  //跳转首页
                  Navigator.push(
                      context, CustomRoute(const HomePageRoute(), 0));
                },
                onError: () {});
          }
        } else {
          BotToast.showText(text: "密码不可为空");
        }
      } else {
        BotToast.showText(text: "账号不可为空");
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
            child: TextField(
              controller: accountInput,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                LengthLimitingTextInputFormatter(10)
              ],
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelStyle: TextStyle(color: Colors.black),
                labelText: '请输入账号',
                contentPadding: EdgeInsets.all(18),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 18, color: Colors.black),
            )),
        Container(
            width: 260,
            height: 40,
            margin: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: passwordInput,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp("[a-zA-Z0-9,.@#!\$%^&]")),
                LengthLimitingTextInputFormatter(18)
              ],
              obscureText: false,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelStyle: TextStyle(color: Colors.black),
                labelText: '请输入密码',
                contentPadding: EdgeInsets.all(18),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 18, color: Colors.black),
            )),
        Container(
          width: 260,
          height: 40,
          margin: const EdgeInsets.only(top: 20),
          child: TextButton(
            onPressed: loginApp,
            style: ButtonStyle(
                side: MaterialStateProperty.all(const BorderSide(
                    width: 2, color: Color.fromARGB(255, 25, 25, 25))),
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 255, 255, 255))),
            child: const Text(
              "登录",
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
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              SizedBox(
                width: 260,
                height: 40,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "返回",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}
