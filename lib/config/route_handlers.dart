import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_im/routes_page/demo_params_pag.dart';
import 'package:flutter_im/routes_page/home_page.dart';
import 'package:flutter_im/routes_page/return_params_page.dart';
import 'package:flutter_im/routes_page/splash_page.dart';
import 'package:flutter_im/routes_page/transition_demo_page.dart';
import 'package:flutter_im/utils/fluro/fluro_convert_util.dart';
/// 跳转到首页
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SplashPag();
    });

/// 跳转到主页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return HomePage();
    });

/// 参数传递 int ，double，bool，自定义类型
var demoParamHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      /// params["name"]?.first 相当于 params["name"][0] ，打个debug 你就知道为什么了是个list
      String name = params["name"]?.first;
      String age = params["age"]?.first;
      String sex = params["sex"]?.first;
      String score = params["score"]?.first;
      String personjson = params['personjson']?.first;
      return DemoParamsPage(
        name: name,
        age: FluroConvertUtils.string2int(age),
        score: FluroConvertUtils.string2double(score),
        sex: FluroConvertUtils.string2bool(sex),
        personJson: personjson,
      );
    });

/// 关闭页面，返回参数
var returnParamHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return ReturnParamsPage();
    });

/// 转场动画 页面
var transitionDemoHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      String title = params["title"]?.first;
      return TransitionDemoPage(title);
    });