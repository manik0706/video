import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:sourcecad_app/constant/Toasty.dart';
import 'package:sourcecad_app/h/HomeScreens/home.dart';
import 'package:sourcecad_app/utils/extensions/goto.dart';
import 'base_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginVM extends BaseViewModel {
  var loginKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var id = TextEditingController();
  bool _passenable = true;

  bool get passenable => _passenable;

  set passenable(bool value) {
    _passenable = value;
    notifyListeners();
  }

  var _countryCode = "91";
  var _countryName = "India";
  var _autoValidate = AutovalidateMode.disabled;
  get autoValidate => _autoValidate;
  set autoValidate(value) {
    _autoValidate = value;
    notifyListeners();
  }

  @override
  initView() {
    return super.initView();
  }

  @override
  dispose() {
    email.clear();
    password.clear();
    return super.dispose();
  }

  get countryName => _countryName;

  set countryName(value) {
    _countryName = value;
  }

  get countryCode => _countryCode;

  set countryCode(value) {
    _countryCode = value;
    notifyListeners();
  }

  void goToLogin() async {
    FocusScope.of(context).unfocus();
    if (loginKey.currentState!.validate()) {
      call(
          path: "log-in.php",
          onSuccess: (statusCode, data) async {
            Map object = jsonDecode(data);
            Toasty.showtoast(object['message'].toString());

            // Store the username in SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString("username", email.text.toString());
            if (object.containsKey('token')) {
              await prefs.setString("token", object['token'].toString());
            }

            context.push(const HomeScreen());
          },
          method: Method.post,
          params: {
            "username": email.text.toString(),
            "password": password.text.toString()
          });
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }

  // Method to retrieve the stored username
  Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }
}
