import 'package:dio/dio.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/utils/shared_preferences_utils.dart';

Dio dio;

class HttpUtil {
  static HttpUtil get instance => _getInstance();

  static HttpUtil _httpUtil;

  static HttpUtil _getInstance() {
    if (_httpUtil == null) {
      _httpUtil = HttpUtil();
    }
    return _httpUtil;
  }

  HttpUtil() {
    BaseOptions options =
        BaseOptions(connectTimeout: 5000, receiveTimeout: 5000);

    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
        // 请求时 回调
        onRequest: (RequestOptions options) async {
      print("====================== 请求数据 ======================");
      print("url = ${options.uri.toString()}");
      print("params = ${options.data}");

      // 添加 Token
      dio.lock();
      await SharedPreferencesUtil.getToken().then((token) {
        options.headers[KString.TOKEN] = token;
      });
      dio.unlock();

      return options;
    },

        // 响应时 回调
        onResponse: (Response response) {
      print("====================== 响应数据 ======================");
      print("statusCode = ${response.statusCode}");
      print("data = ${response.data}");
    }, onError: (DioError error) {
      print("====================== 请求错误 ======================");
      print("message = ${error.message}");
    }));
  }

  Future get(String url, {Map<String, dynamic> params, Options options}) async {
    Response response;
    if (params != null && options != null) {
      response = await dio.get(url, queryParameters: params, options: options);
    } else if (params != null && options == null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }

    return response.data;
  }

  Future post(String url,
      {Map<String, dynamic> params, Options options}) async {
    Response response;
    if (params != null && options != null) {
      response = await dio.post(url, data: params, options: options);
    } else if (params != null && options == null) {
      response = await dio.post(url, data: params);
    } else {
      response = await dio.post(url);
    }

    return response.data;
  }
}
