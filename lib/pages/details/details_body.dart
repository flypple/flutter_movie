import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_movie/bean/filmmaker_bean.dart';
import 'package:flutter_movie/bean/movie_details_bean.dart';
import 'package:flutter_movie/network/network_manager.dart';
import 'package:flutter_movie/global_config.dart';
import 'package:flutter_movie/pages/web/web_view_page.dart';
import 'package:flutter_movie/view/static_rating_bar.dart';

class DetailsBody extends StatefulWidget {
  final String movieId;
  final String type;
  MovieDetailsBean data;

  DetailsBody({Key key, this.movieId, this.type}) : super(key: key);

  @override
  _DetailsBodyState createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {

  Size appbarSize;
  bool _isIntroOpen = false;
  TapGestureRecognizer _tapGestureRecognizer;


  @override
  void initState() {
    super.initState();
    _requestDetailsData();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = (){
      setState(() {
        _isIntroOpen = !_isIntroOpen;
      });
    };
  }

  void _requestDetailsData() async {
    await getMovieDetails(widget.movieId).then((data){
      if (data != null) {
        setState(() {
          widget.data = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _createView(),
    );
  }

  Widget _createView(){
    AppBar appBar = _createAppBar();
    appbarSize = appBar.preferredSize;

    if (widget.data == null) {
      //没有数据时展示的widget
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.green),),
        ),
      );
    } else {
      //有数据时展示的widget
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
                    widget.type,
                    style: TextStyle(color: Colors.white,),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Container(
          width: 56,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Icon(Icons.share, color: Colors.white,),
            onPressed: () {},
          ),
        ),
      ],
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
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.only(top: 12, bottom: 24),
                        alignment: Alignment.center,
                        child: Image.network(widget.data.images.large),
                      ),
                      onTap: (){
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) {;
                        return WebViewPage(widget.data.alt, widget.data.title,);
                        }));
                      },
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
    var summary = widget.data.summary;
    String intro;
    if (summary.length > 120) {
      intro = _isIntroOpen ? summary
          : summary.substring(0, 100) + "…";
    } else {
      intro = summary;
    }
    return Container(
      margin: EdgeInsets.only(top: 24,),
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text("简介", style: TextStyle(color: Colors.grey, fontSize: 13),),
          ),
          Text.rich(
            TextSpan(
              text: intro,
              style: TextStyle(color: GlobalConfig.fontColorBlack, fontSize: 14),
              children: [
                summary.length <= 120
                    ? TextSpan()
                    : TextSpan(
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
      margin: EdgeInsets.only(top: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 24),
            margin: EdgeInsets.only(bottom: 8),
            child: Text("影人", style: TextStyle(color: Colors.grey, fontSize: 13),),
          ),
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
    String title = index < widget.data.directors.length ? "导演" : "主演";
    var large = item.avatars == null ? "" : item.avatars.medium;
    return InkWell(
      onTap: () {
        if (item.alt != null) {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {;
            return WebViewPage(item.alt, item.name,);
          }));
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(240),
        height: ScreenUtil().setHeight(400),
        margin: EdgeInsets.only(left: index == 0 ? 20 : 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.network(large),
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
      ),
    );
  }
}
