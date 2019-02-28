import 'package:flutter/material.dart';

import 'package:flutter_movie/bean/movie_bean.dart';
import 'movie_grid_item.dart';

/// 统一样式的网格列表
class MovieGridView extends StatelessWidget {

  final List<SubjectsBean> dataList;
  ScrollController _scrollController;
  final Function(ScrollController controller) onScrollToBottom;
  //保存初始位置
  final double position;

  MovieGridView({this.dataList, this.onScrollToBottom, this.position});
  
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
      child: GridView.count(
        controller: _scrollController, // GridView的控制器
        padding: EdgeInsets.only(top: 8),
        crossAxisCount: 2, // 每行子控件的个数
        childAspectRatio: 0.68, // 子控件的width / height
        mainAxisSpacing: 4, // 行间距
        crossAxisSpacing: 4, // 列间距，由于横纵比是定值，所以列间距会影响子控件的大小

        children: dataList.map((item) {
          return MovieItemView(item); // 自定义的GridView子控件
        },).toList(),
      ),
    );
  }
}
