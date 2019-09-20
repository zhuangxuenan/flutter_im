import 'package:flutter/material.dart';
import './message_item.dart';
import './message_data.dart';

/**
 *@author zhuangxuenan
 *@time  2019.06.11
 *@describe 消息页面
 */
class MessagePage extends StatefulWidget {
  @override
  MessagePageState createState() => MessagePageState();
}

class MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: messageData.length,
        itemBuilder: (BuildContext context, int index) {
          return new MessageItem(messageData[index]);
        },
      ),
    );
  }
}
