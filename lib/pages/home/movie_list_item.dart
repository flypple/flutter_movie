import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_movie/bean/movie_bean.dart';
import 'package:flutter_movie/global_config.dart';
import 'package:flutter_movie/view/static_rating_bar.dart';

class MovieListItem extends StatelessWidget {
  final SubjectsBean item;
  MovieListItem(this.item);

  @override
  Widget build(BuildContext context) {

    String directors  = "";
    if (item.directors != null && item.directors.isNotEmpty) {
      for (var directorBean in item.directors) {
        if (directors.isEmpty) {
          directors = "导演：${directorBean.name}";
        } else {
          directors = "$directors/${directorBean.name}";
        }
      }
    }

    String casts = "";
    if (item.casts != null && item.casts.isNotEmpty) {
      for (var castBean in item.casts) {
        if (casts.isEmpty) {
          casts = "主演：${castBean.name}";
        } else {
          casts = "$casts/${castBean.name}";
        }
      }
    }

    String collectNum;
    if (item.collect_count > 10000) {
      var num = (item.collect_count * 10.0 / 100000);
      collectNum = "${num.toStringAsFixed(1)}万人看过";
    } else {
      collectNum = "${item.collect_count}人看过";
    }

    var view = Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            child: Image.network(item.images.small, fit: BoxFit.fill,),
            alignment: Alignment.center,
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: GlobalConfig.fontColorBlack2,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: <Widget>[
                    StaticRatingBar(
                      size: 11,
                      rate: item.rating.average / 2,
                    ),
                    Text(
                      item.rating.average.toString(),
                      style: TextStyle(
                          fontSize: 11,
                          color: GlobalConfig.fontColorGray,
                          height: 1.3
                      ),
                    )
                  ],
                ),
                Text(
                  directors,
                  style: TextStyle(
                    fontSize: 11,
                    color: GlobalConfig.fontColorGray,
                  ),
                ),
                Text(
                  casts,
                  style: TextStyle(
                    fontSize: 11,
                    color: GlobalConfig.fontColorGray,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 6,),
                  child: Text(collectNum, style: TextStyle(color: Colors.pinkAccent, fontSize: 11,),),
                ),
                InkWell(
                  child: Container(
                    width: ScreenUtil().setWidth(160),
                    height: ScreenUtil().setHeight(80),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border: Border.all(color: Colors.pinkAccent, width: 1,)
                    ),
                    child: Text("购票", style: TextStyle(color: Colors.pinkAccent, fontSize: 14),),
                    alignment: Alignment.center,
                  ),
                  onTap: (){
                    print("购票");
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );

    return Container(
      height: ScreenUtil().setHeight(380),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12,),
          ),
          color: Colors.white
      ),
      child: FlatButton(
        onPressed: (){},
        padding: EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
          child: view,
        ),
      ),
    );
  }
}
