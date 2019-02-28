import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/home_page.dart';
import '../movie/movie_page.dart';
import '../tv/tv_page.dart';
import '../my/my_page.dart';

class IndexPage extends StatefulWidget {

  //保存各个页面及其状态
  List<Widget> pageList;
  int currentIndex = 0;
  Widget currentPage;

  @override
  _IndexPageState createState() {

    print("IndexPage: pageList = ${pageList}");
    return _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> {

  int currentIndex;
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    //只有当发现pageList为空的时候才初始化4个页面，以保证不重复创建页面，保留各个页面的状态
    currentIndex = widget.currentIndex;

    if (widget.pageList == null) {
      widget.pageList = [
        HomePage(),
        MoviePage(),
        TvPage(),
        MyPage(),
      ];
    }

    currentPage = widget.pageList[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);

    return Container(
      child: Scaffold(
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("首页"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              title: Text("电影"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              title: Text("电视剧"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              title: Text("我的"),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            print("IndexPage: ==== ${widget.hashCode}");
            setState(() {
              currentIndex = index;
              currentPage = widget.pageList[currentIndex];
            });
          },
        ),
      ),
    );
  }
}
