import 'package:flutter/material.dart';
import './touch_callback.dart';

class ImItem extends StatelessWidget {
  //标题
  final String title;

  //图片路径
  final String imagePath;

  //图标
  final Icon icon;

  ImItem({Key key, @required this.title, this.imagePath, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCallBack(
        child: Container(
          height: 50.0,
          child: Row(
            children: <Widget>[
              Container(
                child: imagePath != null
                    ? Image.asset(
                        imagePath,
                        height: 32.0,
                        width: 32.0,
                      )
                    : SizedBox(
                        height: 32.0,
                        width: 32.0,
                        child: icon,
                      ),
                margin: const EdgeInsets.only(left: 22.0, right: 22.0),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 16.0, color: Color(0xff353535)),
              )
            ],
          ),
        ),
        onpressed: () {
          //判断点击的项
          switch (title) {
            case "好友动态":
              //路由到好友动态页
              Navigator.pushNamed(context, "/friends");
              break;
            case "联系客服":
              Navigator.pushNamed(context, "video_c");
              break;
            case "视频播放":
              Navigator.pushNamed(context, "video");
              break;
            case "消息管理":
              Navigator.pushNamed(context, "/http_text");
              break;
          }
        });
  }
}
