import 'package:flutter/material.dart';
/*
    https://www.jianshu.com/p/9d4275368feb

    State生命周期
    1.Widget A打开Widget B： 调用 Navigator.push(B)
    B构造函数--->B initState--->B didChangeDependencies--->B build--->A deactivate--->A didChangeDependencies.
    2.Widget B退出： Navigator.pop
    A deactivate--->A didChangeDependencies--->A build--->B deactivate--->B dispose
 */
class LifeStatus extends StatefulWidget {
  @override
  LifeStatusState createState() =>LifeStatusState();
}
///Flutter提供了WidgetsBindingObserver来监听AppLifecycleState， 而AppLifecycleState有4种状态
class LifeStatusState extends State<LifeStatus> with WidgetsBindingObserver{
  AppLifecycleState _lastLifecycleState;
  ///initState() 表示当前 State 将和一个 BuildContext 产生关联，
  ///但是此时BuildContext没有完全装载完成，如果你需要在该方法中获取 BuildContext ，
  ///可以 new Future.delayed(const Duration(seconds: 0, (){//context}); 一下。
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  ///didChangeDependencies() 在 initState() 之后调用，
  ///当 State 对象的依赖关系发生变化时，该方法被调用，初始化时也会调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  ///didUpdateWidge 当 widget 状态发生变化时，会调用
  @override
  void didUpdateWidget(LifeStatus oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return null;
  }
  ///deactivate() 当 State 被暂时从视图树中移除时，会调用这个方法，同时页面切换时，也会调用
  @override
  void deactivate() {
    super.deactivate();
  }
  ///dispose() Widget 销毁了，在调用这个方法之前，总会先调用 deactivate()。
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  /*
    1、初次打开widget时，不执行AppLifecycleState的回调；

    2、按home键或Power键， AppLifecycleState inactive---->AppLifecycleState pause

    3、从后台到前台：AppLifecycleState inactive--->ApplifecycleState resumed

    4、back键退出应用： AppLifecycleState inactive--->AppLifecycleState paused
  */
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //super.didChangeAppLifecycleState(state);
    print(state);
    switch(state){
      ///resumed 界面可见， 同安卓的onResume
      case AppLifecycleState.resumed:

        break;
      ///inactive界面退到后台或弹出对话框情况下， 即失去了焦点但仍可以执行drawframe回调；同安卓的onPause
      case AppLifecycleState.inactive:

        break;
      ///paused应用挂起，比如退到后台，失去了焦点且不会收到 drawframe 回调；同安卓的onStop
      case AppLifecycleState.paused:

        break;
      ///suspending， iOS中没用，安卓里就是挂起，不会再执行 drawframe 回调
      case AppLifecycleState.suspending:

        break;
    }
  }
}
