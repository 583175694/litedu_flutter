import 'dart:io';

/**
 * @ClassName http
 * @Author wushaohang
 * @Date 2020/7/7
 **/

import 'package:dio/dio.dart';
import 'dart:async';

import 'package:flutter_boost/flutter_boost.dart';

/*
 * 封装 restful 请求
 *
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class HttpUtils {

  /// global dio object
  static Dio dio;

  /// default options
  static const String API_PREFIX = 'https://api-dev.lit-edu.com/';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;
  static const Map<String, dynamic> HEADER = null;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  /// request method
  static Future<Map> request (
      String url,
      { data, method, headers }) async {
    
   // var _headers = await FlutterBoost.singleton.channel.invokeMethod("app/getRequestHeader");
   // _headers = new Map<String, dynamic>.from(_headers);

    var _headers = {
      "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTY0NDI4OTUyNSwiaWF0IjoxNjEyNzUzNTI1LCJuYmYiOjE2MTI3NTM1MjUsImp0aSI6IjdkYWRhNWQyLTY5YmEtMTFlYi05ODJiLTAyNDJhYzE0MDAwNiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJpc3MiOiJodHRwczovL2FwaS1kZXYubGl0LWVkdS5jb20vYXBpL2Zyb250ZW5kL2F1dGgvbG9naW4ifQ.Dwo9PR0Tfiv5lxBcdF8pbweJrTKuGHhihsi7JWTy0Cs"
    };

    data = data ?? {};
    method = method ?? 'GET';
    headers = headers ?? {};

    /// restful 请求处理
    /// /gysw/search/hist/:user_id        user_id=27
    /// 最终生成 url 为     /gysw/search/hist/27
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    /// 打印请求相关信息：请求地址、请求方式、请求参数
    print('请求地址：【' + method + '  ' + url + '】');
    print('请求参数：' + data.toString());

    Dio dio = createInstance();
    var result;

    try {
      Response response = await dio.request(url, data: data, options: new Options(method: method, headers: _headers));
      result = response.data;

      if (result["code"] == 401) {
        FlutterBoost.singleton.channel.invokeMethod('app/authExpired');
      }
      print('响应数据：' + response.toString());
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
    }

    return result;
  }

  /// 创建 dio 实例对象
  static Dio createInstance () {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = new BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT
      );

      dio = new Dio(options);
    }

    return dio;
  }

  /// 清空 dio 对象
  static clear () {
    dio = null;
  }
}