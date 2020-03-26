import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/router/router_handlers.dart';

class Routers {
  static String root = '/';

  static String home = '/home';
  static String brandDetail = '/brandDetail';
  static String categoryGoodsList = '/categoryGoodsList';
  static String goodsDetail = '/goodsDetail';

  static String login = '/login';
  static String register = '/register';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("handler not find");
    });

    router.define(root, handler: loadingHandler);
    router.define(home, handler: homeHandler);
    router.define(brandDetail, handler: webViewHandler);
    router.define(categoryGoodsList, handler: categoryGoodsListHandler);
    router.define(goodsDetail, handler: goodsDetailHandler);
    router.define(login, handler: loginHandler);
    router.define(register, handler: registerHandler);
  }
}
