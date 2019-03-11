import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const SearchBar({Key key, this.controller}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(8, 10, 0, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Icon(Icons.search, color: Colors.grey,),
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: TextField(
//              style: TextStyle(),
                autofocus: true,
                controller: controller,
                onSubmitted: (text){
                  print("搜索：$text");
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  border: InputBorder.none,
                  hintText: "搜索电影/电视剧/影人",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14,),
                  fillColor: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
