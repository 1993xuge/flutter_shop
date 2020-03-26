import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/event/login_event.dart';
import 'package:fluttershop/model/user_model.dart';
import 'package:fluttershop/service/user_service.dart';
import 'package:fluttershop/utils/navigator_util.dart';
import 'package:fluttershop/utils/shared_preferences_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _accountTextControl = TextEditingController();
  TextEditingController _passwordTextControl = TextEditingController();

  UserService userService = UserService();

  UserModel userModel;

  bool _autoValidator = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil.instance.setWidth(30),
                    right: ScreenUtil.instance.setWidth(30)),
                height: ScreenUtil.instance.setWidth(800),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil.instance.setWidth(60)),
                      ),

                      // 账户
                      Container(
                        margin:
                            EdgeInsets.all(ScreenUtil.instance.setWidth(30)),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 11,
                          autovalidate: _autoValidator,
                          keyboardType: TextInputType.phone,
                          validator: _validatorAccount,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: KColor.loginIconColor,
                              size: ScreenUtil.instance.setWidth(60),
                            ),
                            hintText: KString.ACCOUNT_HINT,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil.instance.setWidth(28)),
                            labelStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: ScreenUtil.instance.setWidth(28)),
                            labelText: KString.ACCOUNT,
                          ),
                          controller: _accountTextControl,
                        ),
                      ),

                      // 密码
                      Container(
                        margin:
                            EdgeInsets.all(ScreenUtil.instance.setWidth(30)),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 12,
                          obscureText: true,
                          autovalidate: _autoValidator,
                          keyboardType: TextInputType.phone,
                          validator: _validatorPassword,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: KColor.loginIconColor,
                              size: ScreenUtil.instance.setWidth(60),
                            ),
                            hintText: KString.PASSWORD_HINT,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil.instance.setWidth(28)),
                            labelStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: ScreenUtil.instance.setWidth(28)),
                            labelText: KString.PASSWORD,
                          ),
                          controller: _passwordTextControl,
                        ),
                      ),

                      // 登录按钮
                      Container(
                        margin:
                            EdgeInsets.all(ScreenUtil.instance.setWidth(30)),
                        child: SizedBox(
                          width: ScreenUtil.instance.setWidth(600),
                          height: ScreenUtil.instance.setHeight(80),
                          child: RaisedButton(
                            onPressed: _login,
                            color: KColor.loginButtonColor,
                            child: Text(
                              KString.LOGIN,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil.instance.setWidth(28)),
                            ),
                          ),
                        ),
                      ),

                      // 马上注册按钮
                      Container(
                        margin:
                            EdgeInsets.all(ScreenUtil.instance.setWidth(20)),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => _register(),
                          child: Text(
                            KString.NOW_REGISTER,
                            style: TextStyle(
                                color: KColor.registerTextColor,
                                fontSize: ScreenUtil.instance.setWidth(28)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validatorAccount(String value) {
    if (value == null || value.length < 11) {
      return KString.ACCOUNT_RULE;
    }
    return null;
  }

  String _validatorPassword(String value) {
    if (value == null || value.length < 6) {
      return KString.PASSWORD_RULE;
    }

    return null;
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: KColor.toastBgColor,
        textColor: KColor.toastTextColor,
        fontSize: ScreenUtil.instance.setSp(28.0));
  }

  _login() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      Map<String, dynamic> map = Map();
      map.putIfAbsent('username', () => _accountTextControl.text.toString());
      map.putIfAbsent('password', () => _passwordTextControl.text.toString());

      userService.login(map, (success) {
        print("login success: $success");
        userModel = success;
        _showToast(KString.LOGIN_SUCESS);

        _saveUserInfo();
        loginEventBus.fire(LoginEvent(true,
            nickName: userModel.userInfo.nickName,
            url: userModel.userInfo.avatarUrl));

        // 退出当前界面
        Navigator.pop(context);
      }, (fail) {
        print("login fail: $fail");
        _showToast(fail);
      });
    } else {
      setState(() {
        _autoValidator = true;
      });
    }
  }

  _register() {
    NavigatorUtil.goRegister(context);
  }

  _saveUserInfo() async {
    SharedPreferencesUtil.token = userModel.token;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(KString.TOKEN, userModel.token);
    await preferences.setString(KString.HEAD_URL, userModel.userInfo.avatarUrl);
    await preferences.setString(KString.NICK_NAME, userModel.userInfo.nickName);
  }
}
