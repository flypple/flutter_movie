import 'package:flutter/material.dart';

import 'package:flutter_movie/bean/category_list.dart';
import 'package:flutter_movie/pages/movie/movie_category.dart';
import 'package:flutter_movie/pages/home/search_bar.dart';

class TvPage extends StatefulWidget {
  List<Widget> pageList;
  int currentIndex = 0;

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    super.initState();
    if(widget.pageList == null){
      widget.pageList = tvCategoryList.map((item){
        return MovieCategory(type: "tv", category: item,);
      }).toList();
    }
    _controller = TabController(
      initialIndex: widget.currentIndex,
      length: widget.pageList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    widget.currentIndex = _controller.index;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(),
        bottom: TabBar(
          controller: _controller,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 16,),
          isScrollable: true,
          tabs: tvCategoryList.map((item) {
            return Tab(text: item,);
          }).toList(),
        ),
      ),
      body: Container(
        child: TabBarView(
          controller: _controller,
          children: widget.pageList,
        ),
      ),
    );
  }
}

