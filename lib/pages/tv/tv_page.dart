import 'package:flutter/material.dart';

class TvPage extends StatefulWidget {
  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("电视剧"),
        ),
        body: Center(
          child: Text("电视剧"),
        ),
      ),
    );
  }
}

