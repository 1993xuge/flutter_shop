import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: KColor.toastBgColor,
        textColor: KColor.toastTextColor,
        fontSize: ScreenUtil.instance.setSp(28.0));
  }


}
