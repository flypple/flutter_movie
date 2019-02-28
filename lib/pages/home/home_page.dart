import 'package:flutter/material.dart';

import 'package:flutter_movie/global_config.dart';
import 'hot_showing.dart';
import 'top_250.dart';

/// 首页
class HomePage extends StatefulWidget {
  List<Widget> tabViweList;
  int currentIndex = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    if (widget.tabViweList == null) {
      widget.tabViweList = [
        HotShowing(),
        Top250(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    print("HomePage: building……");
    return DefaultTabController(
      length: 2,
      initialIndex: widget.currentIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text("首页"),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 16,),
            unselectedLabelStyle: TextStyle(fontSize: 14,),
            tabs: [
              Tab(text: "正在热映",),
              Tab(text: "Top250",),
            ],
          ),
        ),
        body: Container(
          color: GlobalConfig.backgroundColor,
          child: TabBarView(
            children: widget.tabViweList,
          ),
        ),
      ),
    );
  }
}

