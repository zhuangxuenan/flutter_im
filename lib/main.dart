import 'package:flutter/material.dart';
import './app.dart';
import './loading.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import './search.dart';
import 'package:flutter/services.dart';
import './video/video_play.dart';
import './video/chewie/video_play_c.dart';
void main() {
  //强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '聊天室',
      //自定义主题
      theme: mDefaultTheme,
      routes: <String, WidgetBuilder>{
        "app": (BuildContext context) =>  App(),
        "/friends": (_) => new WebviewScaffold(
              url: "https://www.baidu.com/",
              appBar: new AppBar(
                title: new Text("百度首页"),
              ),
              withZoom: true,
              withLocalStorage: true,
            ),
        "search": (BuildContext context) =>  Search(),
        "video": (BuildContext context) =>  VideoApp(),
        "video_c": (BuildContext context) =>  VideoDemo(),
        "http_text": (BuildContext context) =>  VideoDemo(),
      },
      //添加路由表
      home: new LoadingPage(),
    );
  }

  final ThemeData mDefaultTheme = new ThemeData(
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Color(0xffebebeb),
    cardColor: Colors.green,
  );
}

