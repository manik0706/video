import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sourcecad_app/utils/extensions/goto.dart';
import 'package:sourcecad_app/view/login.dart';
import '../constant/Toasty.dart';
import 'base_vm.dart';

class SignUpVM extends BaseViewModel{
  var signUpKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var intrest = TextEditingController();
  var id = TextEditingController();
  bool _passenable = true;
  String? _selectIntrest;
  String? get selectInterest => _selectIntrest;

  set selectIntrest(String? value) {
    _selectIntrest = value;
    notifyListeners();
  }
  var optionList = ["AutoCAD","Fusion","Solidworks"];



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
    name.clear();
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
void goToSignUp() {
  FocusScope.of(context).unfocus();
  if(signUpKey.currentState!.validate()){
    call(path: "sign-up.php", onSuccess: (statusCode, data) {
      Map object = jsonDecode(data);
      Toasty.showtoast(object['message'].toString());
      context.pushReplacement(const Login());
    },method: Method.post,params: {
      "name":name.text.toString(),
      "username":email.text.toString(),
      "password":password.text.toString(),
      "mapping_select_650":_selectIntrest.toString(),
    });

  }else{
    autoValidate = AutovalidateMode.always;
  }
}



}