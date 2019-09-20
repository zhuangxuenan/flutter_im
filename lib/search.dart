import 'package:flutter/material.dart';
import './common/touch_callback.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => new SearchState();
}

class SearchState extends State<Search> {
  //定义焦点环节
  FocusNode focusNode = new FocusNode();

  //请求获取焦点
  _requesFocus() {
    FocusScope.of(context).requestFocus(focusNode);
    return focusNode;
  }

  //返回一个文本组件
  _getText(String text) {
    return TouchCallBack(
      isfeed: false,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff1aad19),
        ),
      ),
      onpressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          top: 25.0,
        ),
        child: Column(
          //水平方向居中
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                TouchCallBack(
                  isfeed: false,
                  child: Container(
                    height: 45.0,
                    margin: const EdgeInsets.only(
                      left: 12.0,
                      right: 10.0,
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                    ),
                  ),
                  onpressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 45.0,
                  margin: const EdgeInsets.only(
                    left: 50.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 1.0,
                    color: Colors.green,
                  ))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        focusNode: _requesFocus(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        onChanged: (String text) {},
                        decoration: InputDecoration(
                          hintText: "搜索",
                          border: InputBorder.none,
                        ),
                      )),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 10.0,
                        ),
                        child: Icon(
                          Icons.mic,
                          color: Color(0xffaaaaaa),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 50.0,
              ),
              child: Text(
                "常用搜索",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xffb5b5b5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _getText("朋友"),
                  _getText("聊天"),
                  _getText("群组"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _getText("Flutter"),
                  _getText("Dart"),
                  _getText("C++"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
