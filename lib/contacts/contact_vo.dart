import 'package:flutter/material.dart';

//好友数据类
class ContactsVO {
  //字母排列值
  String seationKey;

  //名称
  String name;

  //头像
  String avatarUrl;

  ContactsVO({@required this.seationKey, this.name, this.avatarUrl});
}
/**
 *@author
 *@time
 * 圆形圆角图片
 *@describe https://www.jianshu.com/p/b4085a1a5129
 */
List<ContactsVO> contactData = [
  new ContactsVO(
    seationKey: "A",
    name: "A张三",
    avatarUrl: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2003362743,1791145169&fm=58&bpow=700&bpoh=613",
  ),
  new ContactsVO(
    seationKey: "A",
    name: "阿黄",
    avatarUrl: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2003362743,1791145169&fm=58&bpow=700&bpoh=613",
  ),
  new ContactsVO(
    seationKey: "B",
    name: "波波",
    avatarUrl: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2003362743,1791145169&fm=58&bpow=700&bpoh=613",
  ),
  new ContactsVO(
    seationKey: "E",
    name: "二狗子",
    avatarUrl: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2003362743,1791145169&fm=58&bpow=700&bpoh=613",
  ),
  new ContactsVO(
    seationKey: "M",
    name: "马六",
    avatarUrl: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2003362743,1791145169&fm=58&bpow=700&bpoh=613",
  ),
  new ContactsVO(
    seationKey: "S",
    name: "傻逼",
    avatarUrl: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2003362743,1791145169&fm=58&bpow=700&bpoh=613",
  ),
  new ContactsVO(
    seationKey: "T",
    name: "涛涛",
    avatarUrl: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2003362743,1791145169&fm=58&bpow=700&bpoh=613",
  ),
  new ContactsVO(
    seationKey: "Y",
    name: "Y二逼",
    avatarUrl: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2003362743,1791145169&fm=58&bpow=700&bpoh=613",
  ),
];
