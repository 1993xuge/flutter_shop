import 'package:flutter/material.dart';
import 'package:fluttershop/model/user_model.dart';

class UserInfoProvider with ChangeNotifier {
  UserModel userModel;

  updateInfo(UserModel userModel) {
    this.userModel = userModel;
    notifyListeners();
  }
}
