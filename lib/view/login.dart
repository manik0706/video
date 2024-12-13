import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sourcecad_app/utils/extensions/goto.dart';
import 'package:sourcecad_app/utils/extensions/space.dart';
import 'package:sourcecad_app/utils/extensions/theme_extension.dart';
import 'package:sourcecad_app/utils/image_path.dart';
import 'package:sourcecad_app/view/sign_up.dart';
import 'package:sourcecad_app/view_models/sign_up_vm.dart';
import '../view_models/login_vm.dart';
import '../widgets/theme_button.dart';
import '../constant/my_theme.dart';
import '../utils/Validator.dart';
import '../utils/appString.dart';
import '../utils/constants.dart';
import '../widgets/base_widgets.dart';
import '../widgets/textfield.dart';

class Login extends BaseWidget<LoginVM> {
  const Login({super.key});

  @override
  Widget buildUI(BuildContext context, LoginVM viewModel) {
    return Scaffold(
      backgroundColor: MyColor.white,
      body: Container(
        decoration: BoxDecoration(color: MyColor.subPrimary),
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              ImagePaths.loginIn,
              height: 200,
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: context.theme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome To SourceCAD",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: MyColor.black)),
                ],
              ),
              Form(
                key: viewModel.loginKey,
                child: Column(
                  children: [
                    spaceY(extra: 20),
                    MyTextFormField(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: MyColor.border,
                      ),
                      hintText: "Email",
                      labelText: "Email*",
                      validator: (value) {
                        return Validator.validateEmail(
                            value!, "Enter email", "Enter valid email");
                      },
                      controller: viewModel.email,
                    ),
                    spaceY(extra: 10),
                    MyTextFormField(
                      prefixIcon: Icon(
                        Icons.password,
                        color: MyColor.border,
                      ),
                      hintText: "Password",
                      labelText: "Password",
                      obscureText: viewModel.passenable,
                      suffixIcon: IconButton(
                          onPressed: () {
                            //add Icon button at end of TextField
                            if (viewModel.passenable) {
                              viewModel.passenable = false;
                            } else {
                              viewModel.passenable = true;
                            }
                          },
                          icon: Icon(
                            viewModel.passenable == true
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined,
                            color: MyColor.subPrimary,
                          )),
                      validator: (value) {
                        return Validator.validateFormField(
                            value!,
                            strEmptyPassword,
                            strErrorInvalidPassword,
                            Constants.NORMAL_VALIDATION);
                      },
                      controller: viewModel.password,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(16),
                      ],
                    ),
                    spaceY(extra: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text("",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: MyColor.subPrimary)),
                    ),
                    spaceY(extra: 30),
                  ],
                ),
              ),
              MyElevatedButton(
                height: 50,
                width: double.infinity,
                borderRadius: BorderRadius.circular(30),
                onPressed: () {
                  viewModel.goToLogin();
                },
                child: const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              spaceY(extra: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Don’t have an account yet?',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.grey),
                ),
                TextButton(
                    onPressed: () {
                      context.pushReplacement(signUp());
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: MyColor.subPrimary),
                    )),
              ]),
              spaceY(extra: 20),
            ],
          ),
        ),
      ),
    );
  }
}
