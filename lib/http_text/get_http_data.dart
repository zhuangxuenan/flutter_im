import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Httptext extends StatefulWidget {
  @override
  _Http_net_text createState() => _Http_net_text();
}

class _Http_net_text extends State<Httptext> {
  var s = '显示获取的接口信息';

  void _getNetMsg() async {
    //发起一个get请求
    Response response;
    Dio dio = Dio();
    response = await dio.get('https://www.apiopen.top/journalismApi');
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
              RaisedButton(
                onPressed: () {
                  _getNetMsg();
                },
                child: Text(
                  '点击获取网络结果',
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text('$s'),
            ],
          ),
        ),
      ),
    );
  }
}
