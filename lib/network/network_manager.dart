import 'package:dio/dio.dart';

import 'package:flutter_movie/bean/movie_bean.dart';
import 'urls.dart';

/// 请求 正在热播 的数据
Future getHotShowing({int start, int count, String city}) async {
  try {
    var parameters = {
      "start": start == null ? 0 : start,
      "count": count == null ? 20 : count,
      "city": city == null ? "北京" : city,
    };
    Map responseData = await request(hotShowingUrl, parameters: parameters);
    MovieBean movieBean = await MovieBean.fromMap(responseData);
    serviceLog(movieBean);
    return movieBean;
  } catch (e) {
    serviceLog(e);
  }
}

/// 请求 Top250 的数据
Future getTop250({int start, int count}) async {
  var parameters = {
    "start": start == null ? 0 : start,
    "count": count == null ? 50 : count,
  };
  Map responseData = await request(top250Url, parameters: parameters);
  return await MovieBean.fromMap(responseData);
}

Future request(String url, {Map parameters,}) async {
  try {
    Dio dio = Dio();
    var response = await dio.get(url, queryParameters: parameters);
    serviceLog(response.data);
    return response.data;
  } catch (e) {
    return serviceLog(e);
  }
}

// 网络请求日志格式统一输出
void serviceLog(Object o){
  print("NetWork ========> $o");
}