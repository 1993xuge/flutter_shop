import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/provider/user_info.dart';
import 'package:fluttershop/router/application.dart';
import 'package:fluttershop/router/routers.dart';
import 'package:provider/provider.dart';

void main() => runApp(ShopApp());

class ShopApp extends StatelessWidget {
  ShopApp() {
    final router = Router();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => UserInfoProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.redAccent),

        //生成路由的回调函数，当导航的命名路由的时候，会使用这个来生成界面
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
