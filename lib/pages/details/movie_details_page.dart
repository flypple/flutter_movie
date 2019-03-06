import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_movie/bean/movie_details_bean.dart';
import 'package:flutter_movie/network/network_manager.dart';
import 'package:flutter_movie/view/static_rating_bar.dart';
import 'package:flutter_movie/global_config.dart';
import 'package:flutter_movie/bean/filmmaker_bean.dart';

class MovieDetailsPage extends StatefulWidget {

  final String movieId;
  MovieDetailsBean data;

  MovieDetailsPage({Key key, this.movieId}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {

  Size appbarSize;
  bool _isIntroOpen = false;
  TapGestureRecognizer _tapGestureRecognizer;

  Widget _createView(){
    AppBar appBar = _createAppBar();
    appbarSize = appBar.preferredSize;

    print("详情页Id = ${widget.hashCode}");
    if (widget.data == null) {
      //没有数据时展示的widget
      print("data为空");
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.green),),
        ),
      );
    } else {
      //有数据时展示的widget
      print("data不为空");
      return Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              color: Color(0xFFF4F7FF),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _createHeaderView(appbarSize.height),
                  _createInfoView(),
                  _createActiveView(),
                  _createIntroView(),
                  _createFilmmaker(),
                ],
              ),
            ),
          ),
          Container(
            height: appbarSize.height + MediaQuery.of(context).padding.top, //这里不加限制的话，会覆盖到底下的一层，拦截其操作
            child: appBar,
          ),
        ],
      );
    }
  }

  //appBar
  AppBar _createAppBar(){
    return AppBar(
      backgroundColor: Color(0x00FFFFFF),
      elevation: 0,
      leading: FlatButton(
        padding: EdgeInsets.all(0),
        child: Icon(Icons.arrow_back_ios, color: Colors.white,),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
          Container(
            width: 56,
            child: FlatButton(
              child: Icon(Icons.share, color: Colors.white,),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  //头部widget
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

  //信息Widget
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

  Widget _createActiveView(){
    return Container(
      margin: EdgeInsets.only(top: 36),
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orangeAccent, width: 1,),
                    borderRadius: BorderRadius.all(Radius.circular(3))
                ),
                child: Text(
                  "想看",
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 14, fontWeight: FontWeight.bold,),
                ),
              ),
              onTap: (){print("想看");},
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.only(left: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orangeAccent, width: 1,),
                  borderRadius: BorderRadius.all(Radius.circular(3))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    child: Text(
                      "看过",
                      style: TextStyle(color: Colors.orangeAccent, fontSize: 14, fontWeight: FontWeight.bold,),
                    ),
                  ),
                  StaticRatingBar(
                    rate: 0,
                    size: 14,
                    colorDark: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createIntroView(){
    String intro = _isIntroOpen ? widget.data.summary
        : widget.data.summary.substring(0, 100) + "…";
    return Container(
      margin: EdgeInsets.only(top: 24),
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("简介", style: TextStyle(color: Colors.grey, fontSize: 13),),
          Text.rich(
            TextSpan(
              text: intro,
              style: TextStyle(color: GlobalConfig.fontColorBlack, fontSize: 14),
              children: [
                TextSpan(
                  text: _isIntroOpen ? " 折叠" : "展开",
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                  recognizer: _tapGestureRecognizer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createFilmmaker(){
    List<FilmmakerBean> filmmakerList = [];
    filmmakerList.addAll(widget.data.directors);
    filmmakerList.addAll(widget.data.casts);
    return Container(
      margin: EdgeInsets.only(top: 24),
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("影人", style: TextStyle(color: Colors.grey, fontSize: 13),),
          Container(
            height: ScreenUtil().setHeight(400),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filmmakerList.length,
              itemBuilder: (context, index){
                return _createFilmmakerItem(filmmakerList[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createFilmmakerItem(FilmmakerBean item, int index){
    String title = index < widget.data.directors.length ? "导演" : "主要演员";
    return Container(
      width: ScreenUtil().setWidth(240),
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(4),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.network(item.avatars.small),
          ),
          Text(
            item.name,
            style: TextStyle(color: GlobalConfig.fontColorBlack, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            title,
            style: TextStyle(color: GlobalConfig.fontColorGray, fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _requestDetailsData();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = (){
      setState(() {
        print("点击富文本");
        _isIntroOpen = !_isIntroOpen;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: _createView(),
      ),
    );
  }

  void _requestDetailsData() async {
    await getMovieDetails(widget.movieId).then((data){
      setState(() {
        widget.data = data;
      });
    });
  }
}
