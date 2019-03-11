import 'package:flutter/material.dart';

import 'package:flutter_movie/global_config.dart';
import 'package:flutter_movie/pages/home/search_bar.dart';
import 'hot_showing.dart';
import 'top_250.dart';

/// 首页
class HomePage extends StatefulWidget {
  List<Widget> tabViweList;
  int currentIndex = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.tabViweList == null) {
      widget.tabViweList = [
        HotShowing(),
        Top250(),
      ];
    }
    _controller = TabController(
      initialIndex: widget.currentIndex,
      length: widget.tabViweList.length,
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
    print("HomePage: building……");
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(),
        bottom: TabBar(
          controller: _controller,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 16,),
          tabs: [
            Tab(text: "正在热映",),
            Tab(text: "Top250",),
          ],
        ),
      ),
      body: Container(
        color: GlobalConfig.backgroundColor,
        child: TabBarView(
          controller: _controller,
          children: widget.tabViweList,
        ),
      ),
    );
  }
}

