import 'package:flutter/material.dart';

import 'package:flutter_movie/bean/category_list.dart';
import 'movie_category.dart';

class MoviePage extends StatefulWidget {
  List<Widget> pageList;
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  @override
  void initState() {
    super.initState();
    if(widget.pageList == null){
      widget.pageList = movieCategoryList.map((item){
        return MovieCategory(category: item);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: movieCategoryList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("电影"),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 16,),
            unselectedLabelStyle: TextStyle(fontSize: 14,),
            isScrollable: true,
            tabs: movieCategoryList.map((item){
              return Tab(text: item,);
            }).toList(),
          ),
        ),
        body: Container(
          child: TabBarView(
            children: widget.pageList,
          ),
        ),
      ),
    );
  }
}

