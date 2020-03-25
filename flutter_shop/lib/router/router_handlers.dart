import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/page/loading/loading_page.dart';

var loadingHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> paramerters) {
  return LoadingPage();
});
