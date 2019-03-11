import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_movie/pages/search/search_page.dart';

class SearchBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 8, 6, 8,),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 4),
                child: Icon(Icons.search, color: Colors.white70, size: 16,),
              ),
              Text("电影/电视剧/影人", style: TextStyle(color: Colors.white70, fontSize: 14),),
            ],
          ),
        ),
        onTap: (){
          Navigator.of(context).push(CupertinoPageRoute(builder: (context){
            return SearchPage();
          }));
        },
      ),
    );
  }
}
