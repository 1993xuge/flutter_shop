import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/model/first_category_model.dart';
import 'package:fluttershop/model/sub_category_model.dart';
import 'package:fluttershop/utils/http_util.dart';

typedef OnSuccessList<T>(List<T> list);

typedef OnSuccess<T>(T t);

typedef OnFail(String message);

class CategoryService {
  Future getFirstCategoryData(OnSuccessList onSuccess, {OnFail onFail}) async {
    try {
      var responseList = [];
      var response = await HttpUtil.instance.get(ServerUrl.CATEGORY_FIRST);

      print("response = $response");
      if (response['errno'] == 0) {
        responseList = response['data'];

        FirstListCategoryModel firstListCategoryModel =
            FirstListCategoryModel.fromJson(responseList);
        onSuccess(firstListCategoryModel.firstLevelCategory);
      } else {
        onFail(response['errmsg']);
      }
    } catch (e) {
      onFail(KString.SERVER_EXCEPTION);
    }
  }

  Future getSubCategoryData(
      Map<String, dynamic> params, OnSuccessList onSuccess,
      {OnFail onFail}) async {
    try {
      var responseList = [];
      var response = await HttpUtil.instance
          .get(ServerUrl.CATEGORY_SECOND, params: params);

      print("response = $response");
      if (response['errno'] == 0) {
        responseList = response['data'];

        SubCategoryListModel subCategoryListModel =
            SubCategoryListModel.fromJson(responseList);
        onSuccess(subCategoryListModel.subCategoryModels);
      } else {
        onFail(response['errmsg']);
      }
    } catch (e) {
      onFail(KString.SERVER_EXCEPTION);
    }
  }
}
