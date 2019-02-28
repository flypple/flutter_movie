import 'package:flutter/material.dart';

import 'pages/index/index_page.dart';
import 'global_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'douban',
      theme: GlobalConfig.themeData,
      home: IndexPage(),
    );
  }
}