import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_movie/global_config.dart';

class MyPage extends StatefulWidget {

  int currentIndex = 0;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      initialIndex: widget.currentIndex,
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    widget.currentIndex = _controller.index;
    _controller.dispose();
    super.dispose();
  }

  Widget _createTabBarView(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 12),
            alignment: Alignment.centerLeft,
            height: ScreenUtil().setHeight(120),
            color: GlobalConfig.backgroundGrey,
            child: Text("参与或浏览过的内容将出现在这里", style: TextStyle(color: GlobalConfig.fontColorGray),),
          ),
          Expanded(
            child: Center(
              child: Text("没有相关记录"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createHeader(){
    return Container(
      height: ScreenUtil().setHeight(600),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.cyan,
            ],
          )
      ),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/images/aodamiao.gif"),
                    ),
                  )
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Learner",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(360),
                        margin: EdgeInsets.only(top: 12),
                        padding: EdgeInsets.only(left: 12, top: 6, right: 12, bottom: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          border: Border.all(color: Colors.white70, width: 1),
                        ),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.account_balance_wallet,
                                color: Colors.white,
                                size: 16,
                              ),
                              Text(
                                "我的电影票",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(top: 4,),
                child: MaterialButton(
                  padding: EdgeInsets.all(16),
                  minWidth: 0,
                  splashColor: Colors.white30,
                  child: Icon(
                    Icons.settings,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createTabBar(){
    return Container(
      height: ScreenUtil().setHeight(100),
      child: TabBar(
        controller: _controller,
        labelColor: GlobalConfig.fontColorBlack2,
        unselectedLabelColor: GlobalConfig.fontColorGray,
        indicatorColor: GlobalConfig.fontColorBlack2,
        tabs: tabs.map((item){
          return Tab(text: item, );
        }).toList(),
      ),
    );
  }

  Widget _createBody(){
    return Expanded(
      child: Container(
        child: TabBarView(
          controller: _controller,
          children: tabs.map((item){
            return _createTabBarView();
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _createHeader(),
          _createTabBar(),
          _createBody(),
        ],
      ),
    );
  }
}

const tabs = [
  "讨论",
  "想看",
  "再看",
  "看过",
  "影评",
  "影人",
];

