import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_movie/bean/movie_details_bean.dart';
import 'package:flutter_movie/network/network_manager.dart';
import 'package:flutter_movie/view/static_rating_bar.dart';
import 'package:flutter_movie/global_config.dart';

class MovieDetailsPage extends StatefulWidget {

  final String movieId;
  MovieDetailsBean data;

  MovieDetailsPage({Key key, this.movieId}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {

  Widget _createView(){
    AppBar appBar = _createAppBar();
    Size appbarSize = appBar.preferredSize;

    print("详情页Id = ${widget.hashCode}");
    if (widget.data == null) {
      print("data为空");
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.green),),
        ),
      );
    } else {
      print("data不为空");
      return Stack(
        children: <Widget>[
          Container(
            color: Color(0xFFF4F7FF),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _createHeaderView(appbarSize.height),
                _createInfoView(),
              ],
            ),
          ),
          appBar,
        ],
      );
    }
  }

  AppBar _createAppBar(){
    return AppBar(
      backgroundColor: Color(0x00FFFFFF),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 2),
                  child: Icon(Icons.local_movies, color: Colors.white,),
                ),
                Container(
                  padding: EdgeInsets.only(left: 2),
                  child: Text(
                    "电影",
                    style: TextStyle(color: Colors.white,),
                  ),
                )
              ],
            ),
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.share, color: Colors.white,),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _createHeaderView(double appBarHeight){
    return Container(
      height: ScreenUtil().setHeight(1080),
      color: Color(0xFF3C5C81),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            height: appBarHeight,
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 12, bottom: 24),
                      alignment: Alignment.center,
                      child: Image.network(widget.data.images.large),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createInfoView(){
    String tag = widget.data.year;
    for (var item in widget.data.genres) {
      tag = "$tag/$item";
    }
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.data.title,
                    style: TextStyle(
                      fontSize: 22,
                      color: GlobalConfig.fontColorBlack,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    tag,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "原名：${widget.data.original_title}",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 24, right: 24),
              alignment: Alignment.topRight,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                elevation: 3,
                color: Colors.white,
                child: Container(
                  width: ScreenUtil().setWidth(220),
                  height: ScreenUtil().setHeight(220),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "豆瓣评分",
                        style: TextStyle(color: Colors.grey, fontSize: 11,),
                      ),
                      Text(
                        widget.data.rating.average.toString(),
                        style: TextStyle(color: GlobalConfig.fontColorBlack,  fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      StaticRatingBar(
                        size: 11,
                        rate: widget.data.rating.average / 2,
                      ),
                      Text(
                        widget.data.collect_count.toString() + "人",
                        style: TextStyle(color: Colors.grey,  fontSize: 10,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _requestDetailsData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _createView(),
    );
  }

  void _requestDetailsData() async {
    await getMovieDetails(widget.movieId).then((data){
      print("详情数据：${data.toString()}");
      setState(() {
        widget.data = data;
      });
    });
  }
}
