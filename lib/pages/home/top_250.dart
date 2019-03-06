import 'package:flutter/material.dart';

import 'package:flutter_movie/network/network_manager.dart';
import 'package:flutter_movie/bean/movie_bean.dart';
import 'movie_list_view.dart';

class Top250 extends StatefulWidget {

  List<SubjectsBean> dataList = [];

  double position = 0;

  @override
  _Top250State createState() => _Top250State();
}

class _Top250State extends State<Top250> {

  List<SubjectsBean> dataList;

  bool _isLoadingMore = false;

  Widget _createLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _createView(){
    var listView = MovieListView(
      position: widget.position,
      dataList: dataList,
      onScrollToBottom: (controller){
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          _loadMore();
        }
        widget.position = controller.position.pixels;
      },
    );

    return RefreshIndicator(
      onRefresh: _refresh,
      child: listView,
    );
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

  void _loadData() async {
    await getTop250(start: 0, count: 20).then((value) {
      if (value != null) {
        setState(() {
          dataList.addAll(value.subjects);
        });
      }
    });
  }

  Future _refresh() async {
    await getTop250(start: 0, count: 20).then((value) {
      if (value != null) {
        setState(() {
          dataList.clear();
          dataList.addAll(value.subjects);
        });
      }
    });
    return null;
  }

  void _loadMore() async {
    if (!_isLoadingMore) {
      _isLoadingMore = true;
      await getTop250(start: dataList.length, count: 20).then((value) {
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
