import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:big_news/Router.gr.dart';

main() {
  runApp(MaterialApp(
    builder: ExtendedNavigator.builder(router: Router()),
  ));
}