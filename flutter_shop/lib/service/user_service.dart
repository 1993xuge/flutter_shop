import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/model/user_model.dart';
import 'package:fluttershop/utils/http_util.dart';

typedef OnSuccessList<T>(List<T> list);

typedef OnSuccess<T>(T t);

typedef OnFail(String message);

class UserService {

  Future register(Map<String, dynamic> params, OnSuccess onSuccess, OnFail onFail) async {
    try {
      var response = await HttpUtil.instance.post(ServerUrl.REGISTER, params: params);

      print("response = $response");
      if (response['errno'] == 0) {
        onSuccess("");
      } else {
        onFail(response['errmsg']);
      }
    } catch (e) {
      onFail(KString.SERVER_EXCEPTION);
    }
  }

  Future login(Map<String, dynamic> params, OnSuccess onSuccess, OnFail onFail) async {
    try {
      var response = await HttpUtil.instance.post(ServerUrl.LOGIN, params: params);

      print("response = $response");
      if (response['errno'] == 0) {
        var data = response['data'];
        UserModel userModel = UserModel.fromJson(data);
        onSuccess(userModel);
      } else {
        onFail(response['errmsg']);
      }
    } catch (e) {
      onFail(KString.SERVER_EXCEPTION);
    }
  }

  Future loginOut(OnSuccess onSuccess, OnFail onFail) async {
    try {
      var response = await HttpUtil.instance.post(ServerUrl.LOGIN_OUT);

      print("response = $response");
      if (response['errno'] == 0) {
        onSuccess(KString.SUCCESS);
      } else {
        onFail(response['errmsg']);
      }
    } catch (e) {
      onFail(KString.SERVER_EXCEPTION);
    }
  }
}
