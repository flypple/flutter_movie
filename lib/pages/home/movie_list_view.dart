import 'package:flutter/material.dart';

import 'package:flutter_movie/bean/movie_bean.dart';
import 'movie_list_item.dart';

/// 统一样式的单列表
class MovieListView extends StatelessWidget {

  final List<SubjectsBean> dataList;
  ScrollController _scrollController;
  final Function(ScrollController controller) onScrollToBottom;
  //保存初始位置
  final double position;

  MovieListView({this.dataList, this.onScrollToBottom, this.position});

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController(
      initialScrollOffset: position, //初始化初始位置
    );
    _scrollController..addListener((){
      // 向使用者暴露滚动状态
      onScrollToBottom(_scrollController);
    });
    return Container(
      child: ListView(
        controller: _scrollController,
        children: dataList.map((item) {
          return MovieListItem(item); // 自定义的GridView子控件
        },).toList(),
      ),
    );
  }
}