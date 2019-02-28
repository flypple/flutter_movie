import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("电影"),
        ),
        body: Center(
          child: Text("电影"),
        ),
      ),
    );
  }
}

