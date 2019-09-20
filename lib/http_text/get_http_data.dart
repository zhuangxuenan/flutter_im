import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class Http_text extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    @override
    _Http_net_text createState() => _Http_net_text();
  }
}

class _Http_net_text extends State<Http_text> {
  var s = '显示获取的接口信息';

  void _getNetMsg() async {
    //发起一个get请求
    Response response;
    Dio dio = Dio();
    response = await dio.get('https://api.apiopen.top/singlePoetry');
    setState(() {
      s = response.data.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '从网络获取信息',
      home: Scaffold(
        appBar: AppBar(
          title: Text('从网络获取信息'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text('点击获取网络结果'),
              ),
              Text('$s'),
            ],
          ),
        ),
      ),
    );
  }
}
