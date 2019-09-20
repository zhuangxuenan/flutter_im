import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './contact_vo.dart';

class ContactSiderList extends StatefulWidget {
  //好友列表数据项
  List<ContactsVO> items;

  //好友列表头构造器
  IndexedWidgetBuilder headerBuilder;

  //好友列表项构造器
  IndexedWidgetBuilder itemBuilder;

  //字母构造器
  IndexedWidgetBuilder sectionBuilder;

  ContactSiderList(
      {Key key,
      @required this.items,
      this.headerBuilder,
      @required this.itemBuilder,
      @required this.sectionBuilder});

  @override
  ContactState createState() => ContactState();
}

class ContactState extends State<ContactSiderList> {
  //列表滚动控制器
  final ScrollController _scrollController = new ScrollController();

  bool _onNotification(ScrollNotification notification) {
    return true;
  }

  _isShowHeadView(index) {
    if (index == 0 && widget.headerBuilder != null) {
      return Offstage(
        offstage: false,
        child: widget.headerBuilder(context, index),
      );
    }
    return Container();
  }

  bool _shouldShowHeader(int position) {
    if (position <= 0) {
      return false;
    }
    if (position != 0 &&
        widget.items[position].seationKey !=
            widget.items[position - 1].seationKey) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NotificationListener(
            onNotification: _onNotification,
            child: ListView.builder(
              //滚动控制器
              controller: _scrollController,
              //列表里面的内容不足一屏时，列表也可以滑动
              physics: const AlwaysScrollableScrollPhysics(),
              //列表长度
              itemCount: widget.items.length,
              //列表项构造器
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      //显示列表头
                      _isShowHeadView(index),
                      //是否显示英文字母
                      Offstage(
                        offstage: _shouldShowHeader(index),
                        child: widget.sectionBuilder(context, index),
                      ),
                      //显示列表项
                      Column(
                        children: <Widget>[widget.itemBuilder(context, index)],
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
