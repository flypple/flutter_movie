import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_movie/bean/movie_bean.dart';
import 'package:flutter_movie/view/static_rating_bar.dart';
import 'package:flutter_movie/pages/details/movie_details_page.dart';

/// 自定义GridView子控件样式
class MovieGridItem extends StatelessWidget {
  
  final SubjectsBean item;

  MovieGridItem(this.item);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        child: FlatButton(
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
              return MovieDetailsPage(movieId: item.id,);
            }));
          },
          padding: EdgeInsets.all(0),
          child: _createBody(),
        ),
      ),
    );
  }

  Widget _createBody(){
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(400),
          child: AspectRatio(
            aspectRatio: 0.7,
            child: Container( //实现带圆角的图片
              foregroundDecoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.images.small),
                    centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6))
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, top: 2),
          child: Text(
            item.title,
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.centerLeft,
        ),
        Container(
          padding: EdgeInsets.only(left: 16, top: 2),
          child: Row(
            children: <Widget>[
              StaticRatingBar( //星星
                size: 12,
                rate: item.rating.average / 2, //由于星星最大值为5颗，数据是以10分为满分的，所以除以2
                colorDark: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(left: 4),
                child: Text(
                  item.rating.average.toString(),
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
