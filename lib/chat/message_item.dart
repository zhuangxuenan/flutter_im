import 'package:flutter/material.dart';
import './message_data.dart';
import 'package:date_format/date_format.dart';
import '../common/touch_callback.dart';

/**
 *@author zhuangxuenan
 *@time  2019.06.11
 *@describe 消息项
 */
class MessageItem extends StatelessWidget {
  final MessgaeData message;

  MessageItem(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(width: 0.5, color: Color(0xffd9d9d9))),
      ),
      height: 64.0,
      child: TouchCallBack(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 13.0, right: 13.0),
              child: ClipOval(
                child: Image.network(
                  message.avatar,
                  width: 48.0,
                  height: 48.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.title,
                  maxLines: 1,
                  style: TextStyle(fontSize: 16.0, color: Color(0xff353535)),
                ),
                Padding(padding: const EdgeInsets.only(top: 8.0)),
                Text(
                  message.subTitle,
                  maxLines: 1,
                  //显示不完整的文本用省略号来表示
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: Color(0xffa9a9a9)),
                ),
              ],
            )),
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: const EdgeInsets.only(right: 12.0, top: 12.0),
              child: Text(
                formatDate(message.time, [HH, ":", nn, ":", ss]),
                style: TextStyle(fontSize: 14.0, color: Color(0xffa9a9a9)),
              ),
            ),
          ],
        ),
        onpressed: () {},
      ),
    );
  }
}
