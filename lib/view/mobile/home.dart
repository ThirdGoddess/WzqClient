import 'package:flutter/material.dart';

class MbHomePage extends StatefulWidget {
  const MbHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MbHomePageState();
  }
}

class _MbHomePageState extends State<MbHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Text("移动端端页面");
  }
}
