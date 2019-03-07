import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/pages/details/details_body.dart';


class MovieDetailsPage extends StatelessWidget {

  final String movieId;
  final String type;

  MovieDetailsPage({Key key, this.movieId, this.type = "电影"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: DetailsBody(movieId: movieId, type: type,),
      ),
    );
  }
}
