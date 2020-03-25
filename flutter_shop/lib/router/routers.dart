import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/router/router_handlers.dart';

class Routers {
  static String root = '/';

  static String home = '/home';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("handler not find");
    });

    router.define(root, handler: loadingHandler);
    router.define(home, handler: homeHandler);
  }
}
