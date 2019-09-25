import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_im/base/bloc_provider.dart';

class BlocTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "测试",
      home: BlocProvider<BlocBussess>(
        child: BlocBussessWidget(),
        bloc: BlocBussess(),
      ),
    );
  }
}

class BlocBussess implements BlocBase {
  int _counter;

  //
  // Stream来处理计数器
  //
  StreamController<int> _counterController = StreamController<int>();

  StreamSink<int> get _inAdd => _counterController.sink;

  Stream<int> get outCounter => _counterController.stream;

  //
  //  Stream来处理计数器上的操作
  //
  StreamController _actionController = StreamController();

  StreamSink get incrementCounter => _actionController.sink;

  //
  // Constructor
  //
  BlocBussess() {
    _counter = 0;
    _actionController.stream.listen(_handleLogic);
  }

  @override
  void dispose() {
    _actionController.close();
    _counterController.close();
  }

  void _handleLogic(data) {
     ++_counter;
    _inAdd.add(_counter);
  }

}

class BlocBussessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlocBussess bloc = BlocProvider.of<BlocBussess>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream version of the Counter App'),
      ),
      body: StreamBuilder<int>(
        stream: bloc.outCounter,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Text('You hit me: ${snapshot.data} times');
        },
        initialData: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          bloc.incrementCounter.add(null);
        },
      ),
    );
  }
}
