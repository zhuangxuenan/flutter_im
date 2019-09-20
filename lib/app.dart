import 'package:flutter/material.dart';
import './chat/message_page.dart';
import './contacts/contacts.dart';
import './personal/personal.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  //当前选中页面索引
  var _currentIndex = 0;

  //聊天页面
  MessagePage message;

  //好友页面
  Contacts contacts;

  //我的页面
  Personal me;

  //根据当前索引返回不同的页面
  currentPage() {
    switch (_currentIndex) {
      case 0:
        if (message == null) {
          message = new MessagePage();
        }
        return message;
      case 1:
        if (contacts == null) {
          contacts = new Contacts();
        }
        return contacts;
      case 2:
        if (me == null) {
          me = new Personal();
        }
        return me;
      default:
    }
  }

  //渲染某个菜单项，传入菜单标题，图片路径或图标
  _popMenuItem(String title, {String imagepPath, IconData icon}) {
    return PopupMenuItem(
      child: Row(
        children: <Widget>[
          imagepPath != null
              ? Image.asset(
                  imagepPath,
                  width: 32.0,
                  height: 32.0,
                )
              : SizedBox(
                  width: 32.0,
                  height: 32.0,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
          Container(
            padding: const EdgeInsets.only(
              left: 20.0,
            ),
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("微信"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "search");
            },
            child: Icon(
              Icons.search,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: GestureDetector(
              onTap: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(500.0, 76.0, 10.0, 0.0),
                    items: <PopupMenuEntry>[
                      _popMenuItem("发起会话",
                          imagepPath: "images/icon_menu_group.png"),
                      _popMenuItem("添加好友",
                          imagepPath: "images/icon_menu_addfriend.png"),
                      _popMenuItem("联系客服", icon: Icons.person),
                      _popMenuItem("扫一扫",
                          imagepPath: "images/icon_menu_scan.png"),
                    ]);
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        //通过fixedCorlor设置选中item的颜色
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
        items: [
          new BottomNavigationBarItem(
            title: new Text(
              "聊天",
              style: TextStyle(
                  color: _currentIndex == 0
                      ? Color(0xff46c01b)
                      : Color(0xff999999)),
            ),
            icon: _currentIndex == 0
                ? Image.asset(
                    "images/message_pressed.png",
                    width: 32.0,
                    height: 28.0,
                  )
                : Image.asset(
                    "images/message_normal.png",
                    width: 32.0,
                    height: 28.0,
                  ),
          ),
          new BottomNavigationBarItem(
            title: new Text(
              "好友",
              style: TextStyle(
                  color: _currentIndex == 1
                      ? Color(0xff46c01b)
                      : Color(0xff999999)),
            ),
            icon: _currentIndex == 1
                ? Image.asset(
                    "images/contact_list_pressed.png",
                    width: 32.0,
                    height: 28.0,
                  )
                : Image.asset(
                    "images/contact_list_normal.png",
                    width: 32.0,
                    height: 28.0,
                  ),
          ),
          new BottomNavigationBarItem(
            title: new Text(
              "我的",
              style: TextStyle(
                  color: _currentIndex == 2
                      ? Color(0xff46c01b)
                      : Color(0xff999999)),
            ),
            icon: _currentIndex == 3
                ? Image.asset(
                    "images/profile_pressed.png",
                    width: 32.0,
                    height: 28.0,
                  )
                : Image.asset(
                    "images/profile_normal.png",
                    width: 32.0,
                    height: 28.0,
                  ),
          ),
        ],
      ),
      body: currentPage(),
    );
  }
}
