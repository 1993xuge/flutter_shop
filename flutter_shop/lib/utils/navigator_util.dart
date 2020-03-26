import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/router/application.dart';
import 'package:fluttershop/router/routers.dart';
import 'package:fluttershop/utils/fluro_convert_util.dart';

// 路由跳转 时  方法的封装
class NavigatorUtil {
  // 跳转至 首页
  static goShopMainPage(BuildContext context) {
    Application.router.navigateTo(context, Routers.home,
        transition: TransitionType.inFromRight, replace: true);
  }

  // 跳转至 商品列表 页面
  static goCategoryGoodsListPage(
      BuildContext context, String category, int categoryId) {
    String categoryName = FluroConvertUtil.fluroCnParamsEncode(category);
    Application.router.navigateTo(context,
        "${Routers.categoryGoodsList}?categoryName=$categoryName&categoryId=$categoryId",
        transition: TransitionType.inFromRight);
  }

  // 跳转至 商品详情 页面
  static goGoodsDetails(BuildContext context, int goodsId) {
    Application.router.navigateTo(
        context, "${Routers.goodsDetail}?goodsId=$goodsId",
        transition: TransitionType.inFromRight);
  }

  // 跳转至 WebView
  static goWebView(BuildContext context, String title, String url) {
    String encodeTitle = FluroConvertUtil.fluroCnParamsEncode(title);
    String encodeUrl = FluroConvertUtil.fluroCnParamsEncode(url);
    Application.router.navigateTo(
        context, "${Routers.brandDetail}?title=$encodeTitle&url=$encodeUrl",
        transition: TransitionType.inFromRight);
  }

  // 跳转到 登录页面
  static goLogin(BuildContext context) {
    Application.router.navigateTo(context, Routers.login,
        transition: TransitionType.inFromRight);
  }

  // 跳转到 注册页面
  static goRegister(BuildContext context) {
    Application.router.navigateTo(context, Routers.register,
        transition: TransitionType.inFromRight);
  }

  // 跳出 注册页面
  static popRegister(BuildContext context) {
    Application.router.pop(context);
  }
}
