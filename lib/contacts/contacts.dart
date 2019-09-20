import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './contact_sider_list.dart';
import './contact_item.dart';
import './contact_header.dart';
import './contact_vo.dart';

class Contacts extends StatefulWidget {
  @override
  ContactsState createState() => ContactsState();
}

class ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //主题实现
      body: ContactSiderList(
          items: contactData,
          //好友列表头构造器
          headerBuilder: (BuildContext context, int index) {
            return Container(
              child: ContactHeader(),
            );
          },
          //好哟列表项构造器
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: ContactItem(item: contactData[index],),
            );
          },
          //字母构造器
          sectionBuilder: (BuildContext context, int index) {
            return Container(
              height: 32.0,
              padding: const EdgeInsets.only(left: 14.0),
              color: Colors.grey[300],
              alignment: Alignment.centerLeft,
              child: Text(
                contactData[index].seationKey,
                style: TextStyle(fontSize: 14.0, color: Color(0xff909090)),
              ),
            );
          }),
    );
  }
}
