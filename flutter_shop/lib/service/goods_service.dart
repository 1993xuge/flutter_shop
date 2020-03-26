import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/model/category_title_model.dart';
import 'package:fluttershop/model/goods_detail_model.dart';
import 'package:fluttershop/model/goods_model.dart';
import 'package:fluttershop/model/home_model.dart';
import 'package:fluttershop/utils/http_util.dart';

typedef OnSuccessList<T>(List<T> list);

typedef OnSuccess<T>(T t);

typedef OnFail(String message);

class GoodsService {
  Future getGoodsCategory(
      Map<String, dynamic> params, OnSuccess onSuccess, OnFail onFail) async {
    try {
      var response =
          await HttpUtil.instance.get(ServerUrl.GOODS_CATEGORY, params: params);

      print("response = $response");
      if (response['errno'] == 0) {
        var data = response['data'];
        CategoryTitleModel model = CategoryTitleModel.fromJson(data);
        onSuccess(model);
      } else {
        onFail(response['errmsg']);
      }
    } catch (e) {
      onFail(KString.SERVER_EXCEPTION);
    }
  }

  Future getGoodsList(
    Map<String, dynamic> params, OnSuccessList onSuccess, {OnFail onFail}) async {
    try {

      var responseList = [];

      var response =
      await HttpUtil.instance.get(ServerUrl.GOODS_LIST, params: params);

      print("response = $response");
      if (response['errno'] == 0) {
        var data = response['data'];
        responseList = data['list'];
        GoodsListModel model = GoodsListModel.fromJson(responseList);
        onSuccess(model.goodsModels);
      } else {
        onFail(response['errmsg']);
      }
    } catch (e) {
      onFail(KString.SERVER_EXCEPTION);
    }
  }

  Future getGoodsDetailData(
    Map<String, dynamic> params, OnSuccess onSuccess, {OnFail onFail}) async {
    try {
      var response =
      await HttpUtil.instance.get(ServerUrl.GOODS_DETAILS_URL, params: params);

      print("response = $response");
      if (response['errno'] == 0) {
        var data = response['data'];
        GoodsDetailModel model = GoodsDetailModel.fromJson(data);
        onSuccess(model);
      } else {
        onFail(response['errmsg']);
      }
    } catch (e) {
      onFail(KString.SERVER_EXCEPTION);
    }
  }
}
