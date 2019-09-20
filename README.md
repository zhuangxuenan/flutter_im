TODO ------------------------1.0DioUtil 网络请求工具类---------
dio_util.dart工具类
https://github.com/Sky24n/FlutterRepos
// 打开debug模式.
DioUtil.openDebug();

// 配置网络参数.
Options options = DioUtil.getDefOptions();
options.baseUrl = "http://www.wanandroid.com/";
HttpConfig config = new HttpConfig(options: options);
DioUtil().setConfig(config);

// 两种单例请求方式.
DioUtil().request<List>(Method.get, "banner/json");
DioUtil.getInstance().request(Method.get, "banner/json");

//示例
LoginReq req = new LoginReq('username', 'password');
DioUtil().request(Method.post, "user/login",data: req.toJson());
//示例
FormData formData = new FormData.from({
      "username": "username",
      "password": "password",
    });
DioUtil().requestR(Method.post, "user/login",data: rformData);
TODO ------------------------2.0 DirectoryUtil 文件目录工具类---------
await DirectoryUtil.getInstance();
String path = DirectoryUtil.getTempPath(fileName: 'demo.png', category: 'image');
String path = DirectoryUtil.getAppDocPath(fileName: 'demo.mp4', category: 'video');
String path = DirectoryUtil.getStoragePath(fileName: 'flutterwanandroid.apk', package: 'com.thl.flutterwanandroid');
Directory dir = DirectoryUtil.createTempDirSync(package: 'doc', category: 'image');

setInitDir
initTempDir
initAppDocDir
createDirSync
createDir
getTempPath
getAppDocPath
getStoragePath
createTempDirSync
createAppDocDirSync
createStorageDirSync
createTempDir
createAppDocDir
createStorageDir
TODO ------------------------3.0 SpUtil 存储数据工具类---------
SpUtil : 单例"同步"SharedPreferences工具类。支持get传入默认值，支持存储对象，支持存储对象数组。
City hisCity = SpUtil.getObj("loc_city", (v) => City.fromJson(v));
List<City> dataList = SpUtil.getObjList("loc_city_list", (v) => City.fromJson(v));
putObject
getObject
putObjectList
getObjectList
getString
putString
getBool
putBool
getInt
putInt
getDouble
putDouble
getStringList
putStringList
getDynamic
haveKey
getKeys
remove
clear
isInitialized


/// SpUtil使用：
/// 方式一
/// 等待sp初始化完成后再运行app。
/// sp初始化时间 release模式下30ms左右，debug模式下100多ms。
void main() async {
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    /// 同步使用Sp。
    SpUtil.remove("username");
    String defName = SpUtil.getString("username", defValue: "sky");
    SpUtil.putString("username", "sky24");
    String name = SpUtil.getString("username");
    print("MyApp defName: $defName, name: $name");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}


/// 方式二
/// 增加闪屏页，在闪屏页SpUtil初始化完成， await SpUtil.getInstance();
/// 跳转到主页后，可以直接同步使用。 String defName = SpUtil.getString("username");

import 'package:flustars/flustars.dart';

/// SpUtil详细使用示例！
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    /// App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();

    /// 同步使用Sp。
    SpUtil.remove("username");
    String defName = SpUtil.getString("username", defValue: "sky");
    SpUtil.putString("username", "sky24");
    String name = SpUtil.getString("username");
    print("MyApp defName: $defName, name: $name");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/MainPage': (ctx) => MyHomePage(),
      },
      home: SplashPage(),
    );
  }
}

/// 闪屏页。
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _info = '';

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    /// App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();
    Future.delayed(new Duration(milliseconds: 500), () {
      /// 同步使用Sp。
      /// 是否显示引导页。
      if (SpUtil.getBool("key_guide", defValue: true)) {
        SpUtil.putBool("key_guide", false);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  /// App引导页逻辑。
  void _initBanner() {
    setState(() {
      _info = "引导页～";
    });
  }

  /// App广告页逻辑。
  void _initSplash() {
    setState(() {
      _info = "广告页，2秒后跳转到主页";
    });
    Future.delayed(new Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacementNamed('/MainPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash"),
      ),
      body: new Center(
        child: new Text("$_info"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool isGuide = SpUtil.getBool("key_guide", defValue: true);
          if (isGuide) {
            Navigator.of(context).pushReplacementNamed('/MainPage');
          }
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    /// 同步使用Sp。

    /// 存取基础类型
    SpUtil.putString("username", "Sky24n");
    String userName = SpUtil.getString("username");
    print("MyHomePage userName: " + userName);

    bool isFirst = SpUtil.getBool("userName", defValue: true);
    SpUtil.putBool("isFirst", false);
    print("MyHomePage isFirst: $isFirst");

    /// save object example.
    /// 存储实体对象示例。
    City city = new City();
    city.name = "成都市";
    SpUtil.putObject("loc_city", city);

    Map dataMap = SpUtil.getObject("loc_city");
    City hisCity = dataMap == null ? null : City.fromJson(dataMap);
    print("City: " + (hisCity == null ? "null" : hisCity.toString()));

    /// save object list example.
    /// 存储实体对象list示例。
    List<City> list = new List();
    list.add(new City(name: "成都市"));
    list.add(new City(name: "北京市"));
    SpUtil.putObjectList("loc_city_list", list);

    List<Map> dataMapList = SpUtil.getObjectList("loc_city_list");
    List<City> _cityList = dataMapList?.map((value) {
      return City.fromJson(value);
    })?.toList();

    print("City list: " + (_cityList == null ? "null" : _cityList.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: new Center(
        child: new Text(SpUtil.getString("username")),
      ),
    );
  }
}

class City {
  String name;

  City({this.name});

  /// 必须写.
  City.fromJson(Map<String, dynamic> json) : name = json['name'];

  /// 必须写.
  Map<String, dynamic> toJson() => {
        'name': name,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"name\":\"$name\"");
    sb.write('}');
    return sb.toString();
  }
}
TODO ------------------------4.0 ScreenUtil 兼容横/纵屏适配---------
ScreenUtil : 屏幕适配，获取屏幕宽、高、密度，AppBar高，状态栏高度，屏幕方向.
double adapterSize = ScreenUtil.getInstance().getAdapterSize(100);
double adapterSize = ScreenUtil.getAdapterSizeCtx(context, 100)

v0.2.5 (2019.03.07)
WidgetUtil 新增获取图片尺寸。
/// get image width height，load error return Rect.zero.（unit px）
/// 获取图片宽高，加载错误情况返回 Rect.zero.（单位 px）
Future getImageWH({Image image, String url, String localUrl, String package});

/// get image width height, load error throw exception.（unit px）
/// 获取图片宽高，加载错误会抛出异常.（单位 px）
Future getImageWHE({Image image, String url, String localUrl, String package});

/// 获取CachedNetworkImage下的图片尺寸
Image image = new Image(image: new CachedNetworkImageProvider("Url"));
Rect rect1 = await WidgetUtil.getImageWH(image: image);

/// 其他image
Image imageAsset = new Image.asset("");
Image imageFile = new Image.file(File("path"));
Image imageNetwork = new Image.network("url");
Image imageMemory = new Image.memory(null);

/// 获取网络图片尺寸
Rect rect2 = await WidgetUtil.getImageWH(url: "Url");

/// 获取本地图片尺寸 localUrl 需要全路径
Rect rect3 = await WidgetUtil.getImageWH(localUrl: "assets/images/3.0x/ali_connors.png");

/// 其他方式
WidgetUtil.getImageWH(url: "Url").then((Rect rect) {
  print("rect: " + rect.toString();
});

WidgetUtil.getImageWHE(url: "Url").then((Rect rect) {
  print("rect: " + rect.toString();
}).catchError((error) {
  print("rect: " + error.toString();
});

getWidth                  : 返回根据屏幕宽适配后尺寸.
getHeight                 : 返回根据屏幕高适配后尺寸.
getWidthPx                : 返回根据屏幕宽适配后尺寸.
getHeightPx               : 返回根据屏幕高适配后尺寸.
getSp                     : 返回根据屏幕宽适配后字体尺寸.
screenWidth               : 获取屏幕宽.
screenHeight              : 获取屏幕高.
screenDensity             : 获取屏幕密度.
appBarHeight              : 获取系统AppBar高度.
statusBarHeight           : 获取系统状态栏高度.
getScreenW(ctx)           : 当前屏幕 宽.
getScreenH(ctx)           : 当前屏幕 高.
getStatusBarH(ctx)        : 当前状态栏高度.
getBottomBarH(ctx)        : 当前BottomBar高度.
getScaleW(ctx,size)       : 返回根据屏幕宽适配后尺寸.
getScaleH(ctx,size)       : 返回根据屏幕高适配后尺寸.
getScaleSp(ctx,size)      : 返回根据屏幕宽适配后字体尺寸.
getScaleSp(ctx,size)      : 返回根据屏幕宽适配后字体尺寸.

///旧适配方法仅适用于纵屏适配。
///推荐使用以下新适配方法。
getAdapterSize(size)             : 返回适配后尺寸，可用于宽，高，字体尺寸.
getAdapterSizeCtx(ctx,size)      : 返回适配后尺寸，可用于宽，高，字体尺寸.

double adapterSize = ScreenUtil.getInstance().getAdapterSize(100);
double adapterSize = ScreenUtil.getAdapterSizeCtx(context, 100);

一、不依赖context
// 屏幕宽
double screenWidth = ScreenUtil.getInstance().screenWidth;
// 屏幕高
double screenHeight = ScreenUtil.getInstance().screenHeight;
// 屏幕像素密度
double screenDensity = ScreenUtil.getInstance().screenDensity;
// 系统状态栏高度
double statusBarHeight = ScreenUtil.getInstance().statusBarHeight;
// BottomBar高度
double bottomBarHeight = ScreenUtil.getInstance().bottomBarHeight;
// 系统AppBar高度
double appBarHeight = ScreenUtil.getInstance().appBarHeight;
// 根据屏幕宽适配后尺寸
double adapterW100 = ScreenUtil.getInstance().getWidth(100);
// 根据屏幕高适配后尺寸
double adapterH100 = ScreenUtil.getInstance().getHeight(100);
// 根据屏幕宽适配后字体尺寸
double adapterSp100 = ScreenUtil.getInstance().getSp(100);
// 根据屏幕宽适配后尺寸(输入px)
double adapterW100px = ScreenUtil.getInstance().getWidthPx(300);
// 根据屏幕高适配后尺寸(输入px)
double adapterH100px = ScreenUtil.getInstance().getHeightPx(300);

二、依赖context
// 屏幕宽
double screenWidth = ScreenUtil.getScreenW(context);
// 屏幕高
double screenHeight = ScreenUtil.getScreenH(context);
// 屏幕像素密度
double screenDensity = ScreenUtil.getScreenDensity(context);
// 系统状态栏高度
double statusBarHeight = ScreenUtil.getStatusBarH(context);
// BottomBar高度
double bottomBarHeight = ScreenUtil.getBottomBarH(context);
// 根据屏幕宽适配后尺寸
double adapterW100 = ScreenUtil.getScaleW(context, 100);
// 根据屏幕高适配后尺寸
double adapterH100 = ScreenUtil.getScaleH(context, 100);
// 根据屏幕宽适配后字体尺寸
double adapterSp100 = ScreenUtil.getScaleSp(context, 100);
// 屏幕方向
Orientation orientation = ScreenUtil.getOrientation(context);
TODO ------------------------5.0 WidgetUtil---------
监听Widget渲染状态，获取Widget宽高，在屏幕上的坐标，获取网络/本地图片尺寸

asyncPrepare              : Widget渲染监听，监听widget宽高变化,callback返回宽高等参数.
getWidgetBounds           : 获取widget 宽高.
getWidgetLocalToGlobal    : 获取widget在屏幕上的坐标.
getImageWH                : 获取图片宽高，加载错误情况返回 Rect.zero.（单位 px）.
getImageWHE               : 获取图片宽高，加载错误会抛出异常.（单位 px）.

/// widget渲染监听。
WidgetUtil widgetUtil = new WidgetUtil();
widgetUtil.asyncPrepare(context, true, (Rect rect) {
  // widget渲染完成。
});

/// widget宽高。
Rect rect = WidgetUtil.getWidgetBounds(context);

/// widget在屏幕上的坐标。
Offset offset = WidgetUtil.getWidgetLocalToGlobal(context);

/// 获取CachedNetworkImage下的图片尺寸
Image image = new Image(image: new CachedNetworkImageProvider("Url"));
Rect rect1 = await WidgetUtil.getImageWH(image: image);

/// 其他image
Image imageAsset = new Image.asset("");
Image imageFile = new Image.file(File("path"));
Image imageNetwork = new Image.network("url");
Image imageMemory = new Image.memory(null);

/// 获取网络图片尺寸
Rect rect2 = await WidgetUtil.getImageWH(url: "Url");

/// 获取本地图片尺寸 localUrl 需要全路径
Rect rect3 = await WidgetUtil.getImageWH(localUrl: "assets/images/3.0x/ali_connors.png");

/// 其他方式
WidgetUtil.getImageWH(url: "Url").then((Rect rect) {
  print("rect: " + rect.toString();
});

WidgetUtil.getImageWHE(url: "Url").then((Rect rect) {
  print("rect: " + rect.toString();
}).catchError((error) {
  print("rect: " + error.toString();
});
TODO ------------------------6.0common_utils ---------
https://github.com/Sky24n/common_utils
1、TimelineUtil : 时间轴.(新)
2、TimerUtil : 倒计时，定时任务.(新)
3、MoneyUtil : 精确转换，元转分，分转元，支持格式输出.(新)
4、LogUtil : 简单封装打印日志.(新)
5、DateUtil : 日期转换格式化输出.
6、RegexUtil : 正则验证手机号，身份证，邮箱等等.
7、NumUtil : 保留x位小数, 精确加、减、乘、除, 防止精度丢失.
8、ObjectUtil : 判断对象是否为空(String List Map),判断两个List是否相等.
TODO -------------------------7.0---------
  # Flutter 常用工具类库 https://github.com/Sky24n/flustars
  #flustars: '>=0.2.6 <1.0.0'
  Flutter工具类库 flustars
  1、SpUtil : 单例"同步"SharedPreferences工具类。支持get传入默认值，支持存储对象，支持存储对象数组。
  2、ScreenUtil : 屏幕适配，获取屏幕宽、高、密度，AppBar高，状态栏高度，屏幕方向.
  3、WidgetUtil : 监听Widget渲染状态，获取Widget宽高，在屏幕上的坐标，获取网络/本地图片尺寸.
  4、DioUtil : 单例Dio网络工具类(已迁移至此处DioUtil)。

  # Flutter 国际化/多语言库 https://github.com/Sky24n/fluintl
  #fluintl: '>=0.1.3 <1.0.0'

  # https://github.com/flutterchina/dio
  dio: 1.0.13

  # Flutter 全局屏幕适配。https://github.com/flutterchina/auto_size
  #auto_size:
  #    git:
  #      url: git://github.com/flutterchina/auto_size.git

  #网络请求
  DioUtil:https://github.com/Sky24n/FlutterRepos
-----------------------------------------------------------
示例demo
https://github.com/li-xiaojun/flutter_gank?tdsourcetag=s_pctim_aiomsg
https://github.com/flutter-dev/FlutterRepos
https://github.com/Sky24n/GreenTravel
https://github.com/Sky24n/flutter_wanandroid
-----------------------------------------------------------
高德地图
https://www.jianshu.com/p/61d3b56d09b9
https://github.com/best-flutter/flutter_amap_location
https://github.com/OpenFlutter/amap_base_flutter
--------------------------------------------------------------
文字转拼音
https://github.com/flutterchina/lpinyin
Flutter城市列表
https://github.com/flutterchina/azlistview
已有项目迁移flutter
https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps
https://mp.weixin.qq.com/s/reZgriEHIBNu8gxPvZLqWw
--------------------------------------------------------------