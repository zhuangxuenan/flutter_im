
/**
 *@author zhuangxuenan
 *@time  2019.06.11
 *@describe 消息数据
 */
//定义消息类型枚举类型
enum MessageType { SYSTEM, PUBLIC, CHAT, GROUP }

//聊天数据model
class MessgaeData {
  //头像
  String avatar;

  //主标题
  String title;

  //子标题
  String subTitle;

//消息时间
  DateTime time;

//消息类型
  MessageType type;

  MessgaeData(this.avatar, this.title, this.subTitle, this.time, this.type);
}

List<MessgaeData> messageData = [
  new MessgaeData(
      "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2003362743,1791145169&fm=58&bpow=700&bpoh=613",
      "一休哥",
      "突然想到的",
      new DateTime.now(),
      MessageType.CHAT),
  new MessgaeData(
      "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3642380826,1742743263&fm=27&gp=0.jpg",
      "哆啦A梦",
      "机器猫！",
      new DateTime.now(),
      MessageType.CHAT),
  new MessgaeData(
      "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3905019814,2025434798&fm=26&gp=0.jpg",
      "忍者神龟",
      "臭傻逼",
      new DateTime.now(),
      MessageType.CHAT),
];
