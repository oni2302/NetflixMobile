import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:netflix_mobile/data/api.dart';
import 'package:netflix_mobile/models/user_model.dart';
import 'package:netflix_mobile/models/user_singleton.dart';
import 'package:netflix_mobile/screens/nav_screen.dart';


class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 100);

  Future<String?> _authUser(LoginData data) async {
    Person user = await API.validateLogin(data.name, data.password);

    return Future.delayed(loginTime).then((_) {
      if (user.username == "") {
        return "Đăng nhập không thành công";
      }
      if (user.isLoggedIn) {
        return "Tài khoản đã được đăng nhập ở nơi khác, tối đa 1 thiết bị.";
      } else if(user.currentPlan==-1){
        return "Vui lòng đăng ký gói để sử dụng dịch vụ.";
      } else{
        API.changeSession(user.id,true);
        CurrentUser().getInstance.put('user', user);
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
          primaryColor: Colors.black,
          accentColor: Colors.white,
          buttonTheme: LoginButtonTheme(backgroundColor: Colors.red),
          cardTheme: CardTheme(elevation: 0),
          inputTheme: InputDecorationTheme(
              fillColor: Colors.white,
              outlineBorder: BorderSide(color: Colors.grey))),
      title: 'Netflix',
      messages: LoginMessages(
          loginButton: "Đăng nhập",
          goBackButton: "Quay lại",
          userHint: "Tên đăng nhập",
          passwordHint: "Mật khẩu",
          confirmPasswordError: "Sai mật khẩu"),
      userType: LoginUserType.name,
      userValidator: (value) {
        return null;
      },
      passwordValidator: (value) {
        return null;
      },
      hideForgotPasswordButton: true,
      validateUserImmediately: false,
      onLogin: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => NavScreen(),
        ));
      },
      onRecoverPassword: (data) {
        return null;
      },
    );
  }
}
