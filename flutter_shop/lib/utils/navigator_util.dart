import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/router/application.dart';
import 'package:fluttershop/router/routers.dart';

// 路由跳转 时  方法的封装
class NavigatorUtil {
  // 跳转至 首页
  static goShopMainPage(BuildContext context) {
    Application.router.navigateTo(context, Routers.home,
        transition: TransitionType.inFromRight, replace: true);
  }

  // 跳转至 商品列表 页面
  static goCategoryGoodsListPage(
      BuildContext context, String categoryName, int categoryId) {}
}
