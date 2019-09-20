import 'package:flutter/material.dart';
import 'dart:async';

class LoadingPage extends StatefulWidget {
  @override
 _LoadingState createState()=>new _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    //在加载页面停顿3秒
    new Future.delayed(Duration(seconds: 3),(){
      print("Flutter即时通讯APP界面实现");
      Navigator.of(context).pushReplacementNamed("app");
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Stack(
        children: <Widget>[
          Image.asset(
            "images/loading.jpg",
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
