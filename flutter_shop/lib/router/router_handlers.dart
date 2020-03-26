import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/page/home/index_page.dart';
import 'package:fluttershop/page/loading/loading_page.dart';
import 'package:fluttershop/page/login/login_page.dart';
import 'package:fluttershop/page/login/register_page.dart';
import 'package:fluttershop/utils/fluro_convert_util.dart';
import 'package:fluttershop/widget/webview_widget.dart';

var loadingHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> paramerters) {
  return LoadingPage();
});

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> paramerters) {
  return IndexPage();
});

var webViewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> paramerters) {
  var title = FluroConvertUtil.fluroCnParamsDecode(paramerters["title"].first);
  var url = FluroConvertUtil.fluroCnParamsDecode(paramerters["url"].first);
  return WebViewWidget(title, url);
});

var categoryGoodsListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> paramerters) {
  var categoryName =
      FluroConvertUtil.fluroCnParamsDecode(paramerters["categoryName"].first);
  var categoryId = int.parse(paramerters["categoryId"].first);

  print(
      "categoryGoodsListHandler => categoryName = $categoryName  categoryId = $categoryId");

  // TODO
  return null;
});

var goodsDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> paramerters) {
  var goodsId = int.parse(paramerters["goodsId"].first);

  print("goodsDetailHandler => goodsId = $goodsId");

  // TODO 商品详情页
  return null;
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> paramerters) {
  return LoginPage();
});

var registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> paramerters) {
  return RegisterPage();
});
