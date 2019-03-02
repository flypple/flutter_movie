import 'package:flutter/material.dart';

import 'package:flutter_movie/bean/category_list.dart';
import 'movie_category.dart';

class MoviePage extends StatefulWidget {
  List<Widget> pageList;
  int currentIndex = 0;
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with SingleTickerProviderStateMixin{

  TabController _controller;

  @override
  void initState() {
    super.initState();
    if(widget.pageList == null){
      widget.pageList = movieCategoryList.map((item){
        return MovieCategory(category: item);
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
        title: Text("电影"),
        bottom: TabBar(
          controller: _controller,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 16,),
          isScrollable: true,
          tabs: movieCategoryList.map((item) {
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

