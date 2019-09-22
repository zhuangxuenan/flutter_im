import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'base_resp.dart';
import 'package:dio/adapter.dart';
/**
 * @Author: 庄学南
 * @Description: Dio Util.封装dio网络单例
 * @Date: 2019/09/20
 */

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

///Http配置.
class HttpConfig {
  /// constructor.
  HttpConfig({
    this.status,
    this.code,
    this.msg,
    this.data,
    this.options,
    this.pem,
    this.pKCSPath,
    this.pKCSPwd,
  });

  /// BaseResp [String status]字段 key, 默认：status.
  String status;
  /// BaseResp [int code]字段 key, 默认：errorCode.
  String code;
  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String msg;
  /// BaseResp [T data]字段 key, 默认：data.
  String data;
  /// Options.
  BaseOptions options;
  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PEM证书内容.
  String pem;
  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书路径.
  String pKCSPath;
  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书密码.
  String pKCSPwd;
}

/// 单例 DioUtil.
/// debug模式下可以打印请求日志. DioUtil.openDebug().
class DioUtil {
  static final DioUtil _singleton = DioUtil._init();
  static Dio _dio;

  /// Options.
  BaseOptions _options = getDefOptions();

  /// 是否是debug模式.
  static bool _isDebug = false;

  /// BaseResp [String status]字段 key, 默认：status.
  String _statusKey = "status";

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String _codeKey = "errorCode";

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String _msgKey = "errorMsg";

  /// BaseResp [T data]字段 key, 默认：data.
  String _dataKey = "data";
  /// PEM证书内容.
  String _pem;
  /// PKCS12 证书路径.
  String _pKCSPath;
  /// PKCS12 证书密码.
  String _pKCSPwd;
  static DioUtil getInstance() {
    return _singleton;
  }

  factory DioUtil() {
    return _singleton;
  }

  DioUtil._init() {
    _dio = new Dio(_options);
  }

  /// 打开debug模式.
  static void openDebug() {
    _isDebug = true;
  }

  /// get Def Options.
  static BaseOptions getDefOptions() {
    /// Http请求头.
    Map<String, dynamic> headers;
    BaseOptions options = BaseOptions(
        baseUrl: "https://www.xx.com/api",
        connectTimeout: 10000,
        receiveTimeout: 10000,
        sendTimeout: 10000,
        headers: headers);
    return options;
  }

   /// set Config.
  void setConfig(HttpConfig config) {
    _statusKey = config.status ?? _statusKey;
    _codeKey = config.code ?? _codeKey;
    _msgKey = config.msg ?? _msgKey;
    _dataKey = config.data ?? _dataKey;
    _mergeOption(config.options);
    _pem = config.pem ?? _pem;
    if (_dio != null) {
      _dio.options = _options;
      if (_pem != null) {
        ///HttpClientAdapter是 Dio 和 HttpClient之间的桥梁
        (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
          ///X509Certificate是证书的标准格式
          client.badCertificateCallback=(X509Certificate cert, String host, int port){
            if(cert.pem==_pem){ // Verify the certificate
              return true;
            }
            return false;
          };
        };
      }
      if (_pKCSPath != null) {
        ///对于自签名的证书，我们也可以将其添加到本地证书信任链中，这样证书验证时就会自动通过，而不会再走到badCertificateCallback回调中
        ///如果证书格式为PKCS12，则需将证书密码传入，这样则会在代码中暴露证书密码，所以客户端证书校验不建议使用PKCS12格式的证书
        (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
          SecurityContext sc = new SecurityContext();
          //file is the path of certificate
          sc.setTrustedCertificates(_pKCSPath,password: _pKCSPwd);
          HttpClient httpClient = new HttpClient(context: sc);
          return httpClient;
        };
      }
    }
  }

  /***
   *
   * Options类描述了每一个Http请求的配置信息，每一次请求都可以单独配置，
   * 单次请求的Options中的配置信息可以覆盖BaseOptions中的配置，下面是BaseOptions的配置项
      {
        /// Http method.
        String method;

        /// 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
        String baseUrl;

        /// Http请求头.
        Map<String, dynamic> headers;

        /// 连接服务器超时时间，单位是毫秒.
        int connectTimeout;
        /// 2.x中为接收数据的最长时限.
        int receiveTimeout;

        /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则,
        /// 将会和baseUrl拼接出完整的的url.
        String path = "";

        /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
        /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
        /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
        /// 就会自动编码请求体.
        String contentType;

        /// [responseType] 表示期望以那种格式(方式)接受响应数据。
        /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
        ///
        /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
        /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
        ///
        /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
        ResponseType responseType;

        /// `validateStatus` 决定http响应状态码是否被dio视为请求成功， 返回`validateStatus`
        ///  返回`true` , 请求结果就会按成功处理，否则会按失败处理.
        ValidateStatus validateStatus;

        /// 用户自定义字段，可以在 [Interceptor]、[Transformer] 和 [Response] 中取到.
        Map<String, dynamic> extra;
        /// Common query parameters
        Map<String, dynamic /*String|Iterable<String>*/ > queryParameters;
      }
   *************************************请求的响应数据***************************
   * {
        /// 响应数据，可能已经被转换了类型, 详情请参考Options中的[ResponseType].
        T data;
        /// 响应头
        HttpHeaders headers;
        /// 本次请求信息
        Options request;
        /// Http status code.
        int statusCode;
        /// 是否重定向(Flutter Web不可用)
        bool isRedirect;
        /// 重定向信息(Flutter Web不可用)
        List<RedirectInfo> redirects ;
        /// 真正请求的url(重定向最终的uri)
        Uri realUri;
        /// 响应对象的自定义字段（可以在拦截器中设置它），调用方可以在`then`中获取.
        Map<String, dynamic> extra;
      }
   */


  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseResp<T> 返回 status code msg data .不带响应码Response
  /// 传入的data默认会转化成json请求体
  Future<BaseResp<T>> request<T>(String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          // 在请求被发送之前做一些事情
          return options; //continue
          // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
          // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
          //
          // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
          // 这样请求将被中止并触发异常，上层catchError会被调用。
        },
        onResponse:(Response response) async {
          // 在返回响应数据之前做一些预处理
          return response; // continue
        },
        onError: (DioError e) async {
          // 当请求失败时做一些预处理
          return e;//continue
        }
    ));
    Response response = await _dio.request(path,
        data: data,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    _printHttpLog(response);
    String _status;
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        Map<String, dynamic> _dataMap = _decodeData(response);
        _status = (_dataMap[_statusKey] is int)
            ? _dataMap[_statusKey].toString()
            : _dataMap[_statusKey];
        _code = (_dataMap[_codeKey] is String)
            ? int.tryParse(_dataMap[_codeKey])
            : _dataMap[_codeKey];
        _msg = _dataMap[_msgKey];
        _data = _dataMap[_dataKey];
        return new BaseResp(_status, _code, _msg, _data);
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          error: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      error: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }
  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseRespR<T> 返回 status code msg data  Response.带响应码Response
  Future<BaseRespR<T>> requestR<T>(String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          // 在请求被发送之前做一些事情
          return options; //continue
          // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
          // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
          //
          // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
          // 这样请求将被中止并触发异常，上层catchError会被调用。
        },
        onResponse:(Response response) async {
          // 在返回响应数据之前做一些预处理
          return response; // continue
        },
        onError: (DioError e) async {
          // 当请求失败时做一些预处理
          return e;//continue
        }
    ));
    Response response = await _dio.request(path,
        data: data,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    _printHttpLog(response);
    String _status;
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        Map<String, dynamic> _dataMap = _decodeData(response);
        _status = (_dataMap[_statusKey] is int)
            ? _dataMap[_statusKey].toString()
            : _dataMap[_statusKey];
        _code = (_dataMap[_codeKey] is String)
            ? int.tryParse(_dataMap[_codeKey])
            : _dataMap[_codeKey];
        _msg = _dataMap[_msgKey];
        _data = _dataMap[_dataKey];
        return new BaseRespR(_status, _code, _msg, _data, response);
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          error: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      error: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }
  /// print Http Log.
  void _printHttpLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      print("----------------Http Log----------------" +
          "\n[statusCode]:   " +
          response.statusCode.toString() +
          "\n[request   ]:   " +
          _getOptionsStr(response.request));
      _printDataStr("reqdata ", response.request.data);
      _printDataStr("response", response.data);
    } catch (ex) {
      print("Http Log" + " error......");
    }
  }

  /// get Options Str.
  String _getOptionsStr(RequestOptions request) {
    return "method: " +
        request.method +
        "  baseUrl: " +
        request.baseUrl +
        "  path: " +
        request.path;
  }

  /// print Data Str.
  void _printDataStr(String tag, Object value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag  ]:   " + da.substring(0, 512));
        da = da.substring(512, da.length);
      } else {
        print("[$tag  ]:   " + da);
        da = "";
      }
    }
  }

  /// get dio.
  Dio getDio() {
    return _dio??createNewDio();
  }

  /// create new dio.
  static Dio createNewDio([BaseOptions options]) {
    options = options ?? getDefOptions();
    Dio dio = new Dio(options);
    return dio;
  }

  /// check Options.
  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  /// decode response data.
  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }
  /// merge Option.
  void _mergeOption(BaseOptions opt) {
    _options.method = opt.method ?? _options.method;
    _options.headers = (new Map.from(_options.headers))..addAll(opt.headers);
    _options.baseUrl = opt.baseUrl ?? _options.baseUrl;
    _options.connectTimeout = opt.connectTimeout ?? _options.connectTimeout;
    _options.receiveTimeout = opt.receiveTimeout ?? _options.receiveTimeout;
    _options.responseType = opt.responseType ?? _options.responseType;
    _options.extra = (new Map.from(_options.extra))..addAll(opt.extra);
    _options.contentType = opt.contentType ?? _options.contentType;
    _options.validateStatus = opt.validateStatus ?? _options.validateStatus;
    _options.followRedirects = opt.followRedirects ?? _options.followRedirects;
  }
}
