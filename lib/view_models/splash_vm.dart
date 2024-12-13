// import 'package:sourcecad_app/utils/extensions/goto.dart';

// import '../view/login.dart';
// import 'base_vm.dart';

// class SplashVM extends BaseViewModel {
//   void checkIsLogin() async {
//     Future.delayed(const Duration(seconds: 2), () {
//       context.push(Login());
//     });
//   }

//   show() {}
//   @override
//   initView() {
//     checkIsLogin();
//     return super.initView();
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sourcecad_app/utils/extensions/goto.dart';
import '../view/login.dart';
import '../h/HomeScreens/home.dart';
import 'base_vm.dart';

class SplashVM extends BaseViewModel {
  void checkIsLogin() async {
    // Retrieve the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    // Delay for the splash screen animation
    Future.delayed(const Duration(seconds: 2), () {
      if (token != null && token.isNotEmpty) {
        // If token is present, navigate to HomeScreen
        context.push(const HomeScreen());
      } else {
        // If token is not present, navigate to Login screen
        context.push(Login());
      }
    });
  }

  @override
  initView() {
    checkIsLogin();
    return super.initView();
  }
}
