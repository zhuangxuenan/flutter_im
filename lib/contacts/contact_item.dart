import 'package:flutter/material.dart';
import './contact_vo.dart';

class ContactItem extends StatelessWidget {
  //好友数据
  final ContactsVO item;
  final String titleName;
  final String imageName;

  ContactItem({this.item, this.titleName, this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(width: 0.5, color: Color(0xffd9d9d9))),
      ),
      height: 52.0,
      child: FlatButton(
          onPressed: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: imageName == null
                    ? Image.network(
                        item.avatarUrl != ""
                            ? item.avatarUrl
                            : "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2003362743,1791145169&fm=58&bpow=700&bpoh=613",
                        width: 36.0,
                        height: 36.0,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        imageName,
                        width: 36.0,
                        height: 36.0,
                        fit: BoxFit.cover,
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12.0),
                child: Text(
                  titleName == null ? item.name ?? "暂时" : titleName,
                  style: TextStyle(fontSize: 15.0, color: Color(0xff353535)),
                  maxLines: 1,
                ),
              ),
            ],
          )),
    );
  }
}
