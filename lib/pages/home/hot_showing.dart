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
  List<SubjectsBean> dataList;

  Widget _createLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _createView(){

    var listView = MovieListView(
      position: widget.position,
      dataList: dataList,
      onScrollToBottom: (controller) { // 监听滚动
        // 当滚动到底部时，加载更多数据
        if (controller.position.pixels ==
            controller.position.maxScrollExtent) {
          setState(() {

          });
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
    await getHotShowing(start: 0, count: 20).then((value) {
      if (value != null) {
        setState(() {
          dataList.addAll(value.subjects);
        });
      }
    });
  }

  /// 下拉刷新
  Future _refresh() async {
    await getHotShowing(start: 0, count: 20).then((value) {
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
    await getHotShowing(start: dataList.length, count: 20).then((value) {
      if (value != null) {
        setState(() {
          dataList.addAll(value.subjects);
        });
      }
    });
    return null;
  }
}
