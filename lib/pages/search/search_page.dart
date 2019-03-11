import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_movie/pages/search/search_bar.dart';
import 'package:flutter_movie/network/network_manager.dart';
import 'package:flutter_movie/bean/movie_bean.dart';
import 'package:flutter_movie/global_config.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller;

  List<SubjectsBean> _dataList;

  //搜索任务定时器
  Timer _resultTimer;
  //搜索输入值
  String _input;
  //加载中，应该展示圆形进度条
  bool _isLoading = false;

  void _getSearchResult() async {

    if (_resultTimer != null && _resultTimer.isActive) {
      _resultTimer.cancel();
    }

    setState(() {
      if (_input.isEmpty) {
        _isLoading = false;
        _dataList.clear();
      } else {
        _isLoading = _input.isNotEmpty;
        _resultTimer = Timer(Duration(milliseconds: 300), () async {
          await getSearchResult(_input, start: 0, count: 10).then((value) {
            setState(() {
              _isLoading = false;
              _dataList.clear();
              _dataList.addAll(value.subjects);
            });
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _dataList = List();
    _input = "";
    _controller = TextEditingController(text: _input);
    _controller.addListener((){
      print(_controller.text);
      _input = _controller.text;
      _getSearchResult();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_resultTimer?.isActive) {
      _resultTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //搜索条
          title: SearchBar(controller: _controller,),
          titleSpacing: 0,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(4, 8, 4, 8),
              width: ScreenUtil().setWidth(120),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text("取消", style: TextStyle(fontSize: 16),),
                ),
              ),
            )
          ],
        ),
        body:_createBody(),
      ),
    );
  }

  Widget _createBody(){
    Widget body;
    if (_input.isEmpty) { //当输入为空时，展示历史搜索
      body = _createHistory();
    } else { //当输入不为空时，
      if (_dataList.isEmpty) { //当搜索结果为空时
        if (_isLoading) { //当处于加载状态时
          body = _createLoading();
        } else { //显示空内容
          body = _createNoResult();
        }
      } else { //当搜索结果不为空时
        body = _createSuggestions(); //显示结果
      }
    }
    return body;
  }
  
  Widget _createSuggestions(){
    return Container(
      child: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, index){
          var itemData = _dataList[index];
          String image = itemData.images == null ? "" : itemData.images.small;
          String desc = "${itemData.rating.average}分/${itemData.year}/${itemData.genres}";
          return Container(
            height: ScreenUtil().setHeight(220),
            padding: EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 12),
                  child: Image.network(image),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      itemData.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      desc,
                      style: TextStyle(color: GlobalConfig.fontColorGray, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _createNoResult(){
    return Container();
  }

  Widget _createLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _createHistory(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 12, right: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "搜索历史",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.grey,),
                  onPressed: (){},
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(12),
            child: Wrap(
              spacing: 12,
              runSpacing: 20,
              alignment: WrapAlignment.start,
              children: historyList.map((itemValue){
                return Container(
                  padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                  decoration: BoxDecoration(
                    color: GlobalConfig.backgroundGrey2,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  child: InkWell(
                    child: Text(itemValue),
                    onTap: (){},
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

const historyList = [
  "罗永浩",
  "战斗天使",
  "姜文",
  "罗马",
  "漫威",
  "斯巴达克斯",
  "权力的游戏",
  "呵呵",
];
