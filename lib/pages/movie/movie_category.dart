import 'package:flutter/material.dart';

import 'package:flutter_movie/bean/movie_tv_bean.dart';
import 'package:flutter_movie/network/network_manager.dart';
import 'movie_tv_grid_view.dart';

class MovieCategory extends StatefulWidget {
  List<SubjectsBean> dataList = [];
  double position = 0;

  String type;
  String category;

  MovieCategory({this.type, this.category});

  @override
  _MovieCategoryState createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {
  List<SubjectsBean> dataList;

  bool _isLoadingMore = false;

  Widget _createLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _createView(){
    var view = RefreshIndicator( // 支持下拉刷新的组件
      onRefresh: _refresh,
      child: MovieOrTvGridView(
        position: widget.position,
        dataList: dataList,
        onScrollToBottom: (controller) { // 监听滚动
          // 当滚动到底部时，加载更多数据
          if (controller.position.pixels ==
              controller.position.maxScrollExtent) {
            _loadMore();
          }
          widget.position = controller.position.pixels; // 保存位置
        },
        type: widget.type == "tv" ? "电视剧" : "电影",
      ),
    );
    return view;
  }

  @override
  void initState() {
    super.initState();
    dataList = widget.dataList;
    if (dataList.isEmpty) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: dataList.isEmpty ? _createLoading() : _createView(),
    );
  }

  /// 加载数据
  void _loadData() async {
    await getMoviesOrTvs(type: widget.type, tag: widget.category, start: 0, count: 20).then((value) {
      if (value != null) {
        setState(() {
          dataList.addAll(value.subjects);
        });
      }
    });
  }

  /// 下拉刷新
  Future _refresh() async {
    await getMoviesOrTvs(type: widget.type, tag: widget.category, start: 0, count: 20).then((value) {
      if (value != null) {
        setState(() {
          dataList.clear();
          dataList.addAll(value.subjects);
        });
      }
    });
    return null;
  }

  /// 滚动到底时，加载更多
  void _loadMore() async {

    if (!_isLoadingMore) {
      _isLoadingMore = true;
      await getMoviesOrTvs(type: widget.type,
          tag: widget.category,
          start: dataList.length,
          count: 20).then((value) {
        print("MovieCategory: ${value.toString()}");
        if (value != null) {
          setState(() {
            dataList.addAll(value.subjects);
          });
        }
        _isLoadingMore = false;
      });
    }
    return null;
  }
}
