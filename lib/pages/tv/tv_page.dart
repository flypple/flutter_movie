import 'package:flutter/material.dart';

import 'package:flutter_movie/bean/category_list.dart';
import 'package:flutter_movie/pages/movie/movie_category.dart';

class TvPage extends StatefulWidget {
  List<Widget> pageList;

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {

  @override
  void initState() {
    super.initState();
    if(widget.pageList == null){
      widget.pageList = tvCategoryList.map((item){
        return MovieCategory(type: "tv", category: item,);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tvCategoryList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("电视剧"),
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
        body:  Container(
          child: TabBarView(
            children: widget.pageList,
          ),
        ),
      ),
    );
  }
}

