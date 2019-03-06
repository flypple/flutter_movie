import 'package:flutter/material.dart';

import 'package:flutter_movie/network/network_manager.dart';
import 'package:flutter_movie/bean/movie_bean.dart';
import 'movie_list_view.dart';

/// 热播页面
class HotShowing extends StatefulWidget {

  //保存数据
  List<SubjectsBean> dataList = [];
  //保存滚动到的位置
  double position = 0;

  @override
  _HotShowingState createState() => _HotShowingState();
}

class _HotShowingState extends State<HotShowing> {
  List<SubjectsBean> _dataList;

  bool _isLoadingMore = false;

  Widget _createLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _createView(){

    var listView = MovieListView(
      position: widget.position,
      dataList: _dataList,
      onScrollToBottom: (controller) { // 监听滚动
        // 当滚动到底部时，加载更多数据
        if (controller.position.pixels ==
            controller.position.maxScrollExtent) {
          _loadMore();
        }
        widget.position = controller.position.pixels; // 保存位置
      },
    );



    var view = RefreshIndicator( // 支持下拉刷新的组件
      onRefresh: _refresh,
      child: listView,
    );
    return view;
  }

  @override
  void initState() {
    super.initState();
    _dataList = widget.dataList;
    if (_dataList.isEmpty) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _dataList.isEmpty ? _createLoading() : _createView(),
    );
  }

  /// 加载数据
  void _loadData() async {
    await getHotShowing(start: 0, count: 20).then((value) {
      if (value != null) {
        setState(() {
          _dataList.addAll(value.subjects);
        });
      }
    });
  }

  /// 下拉刷新
  Future _refresh() async {
    await getHotShowing(start: 0, count: 20).then((value) {
      if (value != null) {
        setState(() {
          _dataList.clear();
          _dataList.addAll(value.subjects);
        });
      }
    });
    return null;
  }

  /// 滚动到底时，加载更多
  void _loadMore() async {
    if (!_isLoadingMore) {
      _isLoadingMore = true;
      await getHotShowing(start: _dataList.length, count: 20).then((value) {
        if (value != null) {
          setState(() {
            _dataList.addAll(value.subjects);
          });
        }
        _isLoadingMore = false;
      });
    }
    return null;
  }
}
