import 'package:dio/dio.dart';

import 'package:flutter_movie/bean/movie_bean.dart';
import 'package:flutter_movie/bean/movie_tv_bean.dart';
import 'package:flutter_movie/bean/movie_details_bean.dart';
import 'urls.dart';

/// 请求 正在热播 的数据
Future<MovieBean> getHotShowing({int start, int count, String city}) async {
  try {
    var parameters = {
      "start": start == null ? 0 : start,
      "count": count == null ? 20 : count,
      "city": city == null ? "北京" : city,
    };
    Map responseData = await request(hotShowingUrl, parameters: parameters);
    MovieBean movieBean = await MovieBean.fromMap(responseData);
    return movieBean;
  } catch (e) {
    log(e);
  }
}

/// 请求 Top250 的数据
Future<MovieBean> getTop250({int start, int count}) async {
  try {
    var parameters = {
      "start": start == null ? 0 : start,
      "count": count == null ? 50 : count,
    };
    Map responseData = await request(top250Url, parameters: parameters);
    return await MovieBean.fromMap(responseData);
  } catch (e) {
    log(e);
  }
}

/// 请求电影或电视剧列表
Future<MovieOrTvBean> getMoviesOrTvs({String type, String tag, int start, int count,}) async {
  try {
    var parameters = {
      "type": type == null ? "movie" : type,
      "tag": tag == null ? "热门" : tag,
      "page_start": start == null ? 0 : start,
      "page_limit": count == null ? 50 : count,
    };
    Map responseData = await request(movieOrTvUrl, parameters: parameters);
    return await MovieOrTvBean.fromMap(responseData);
  } catch (e) {
    log(e);
  }
}

/// 获取详情页的数据
Future<MovieDetailsBean> getMovieDetails(String movieId) async {
  try {
    Map responseData = await request(movieDetailsUrl + movieId);
    return await MovieDetailsBean.fromMap(responseData);
  } catch (e) {
    log(e);
  }
}

/// 获取搜索结果数据
Future<MovieBean> getSearchResult(String tag, {int start, int count}) async {
  try {
    var parameters = {
      "tag": tag,
      "start": start == null ? 0 : start,
      "count": count == null ? 10 : count,
    };
    Map responseData = await request(searchUrl, parameters: parameters);
    print(responseData);
    return await MovieBean.fromMap(responseData);
  } catch (e) {
    log(e);
  }
}

Future request(String url, {Map parameters,}) async {
  try {
    Dio dio = Dio();
    var response = await dio.get(url, queryParameters: parameters);
    return response.data;
  } catch (e) {
    return log(e);
  }
}

// 网络请求日志格式统一输出
void log(Object o){
  print("NetWork ========> $o");
}