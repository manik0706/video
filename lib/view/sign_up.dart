import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sourcecad_app/utils/extensions/goto.dart';
import 'package:sourcecad_app/utils/extensions/space.dart';
import 'package:sourcecad_app/utils/extensions/theme_extension.dart';
import 'package:sourcecad_app/utils/image_path.dart';
import 'package:sourcecad_app/view/login.dart';
import 'package:sourcecad_app/view_models/sign_up_vm.dart';
import '../view_models/login_vm.dart';
import '../widgets/drop_down_field.dart';
import '../widgets/theme_button.dart';
import '../constant/my_theme.dart';
import '../utils/Validator.dart';
import '../utils/appString.dart';
import '../utils/constants.dart';
import '../widgets/base_widgets.dart';
import '../widgets/textfield.dart';

class signUp extends BaseWidget<SignUpVM> {
  const signUp({super.key});

  @override
  Widget buildUI(BuildContext context, SignUpVM viewModel) {
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
              height: 100,
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
                  Text("Signup for free, no credit card required",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: MyColor.black)),
                ],
              ),
              Form(
                key: viewModel.signUpKey,
                child: Column(
                  children: [
                    spaceY(extra: 20),
                    MyTextFormField(
                      prefixIcon: Icon(
                        Icons.person,
                        color: MyColor.border,
                      ),
                      hintText: "Name",
                      labelText: "Name*",
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                        FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))
                      ],
                      validator: (value) {
                        return Validator.validateFormField(value!, "Enter name",
                            "Enter valid name", Constants.MIN_CHAR_VALIDATION);
                      },
                      controller: viewModel.name,
                    ),
                    spaceY(extra: 10),
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
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Your primary topic of interest*",
                          style: TextStyle(
                              fontSize: 14,
                              color: MyColor.onBackground,
                              fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    DropDownField(
                        controller: viewModel.intrest,
                        hintText: "Your primary topic of interest",
                        item: viewModel.optionList,
                        validator: (value) {
                          return value == null ? "Select " : null;
                        },
                        value: viewModel.selectInterest,
                        onTap: (value) {
                          viewModel.selectIntrest = value.toString();
                        },
                        setText: (String item) {
                          return item ?? "";
                        }),
                    spaceY(extra: 30),
                  ],
                ),
              ),
              MyElevatedButton(
                height: 50,
                width: double.infinity,
                borderRadius: BorderRadius.circular(30),
                onPressed: () {
                  viewModel.goToSignUp();
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              spaceY(extra: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.grey),
                ),
                TextButton(
                    onPressed: () {
                      context.pushReplacement(Login());
                    },
                    child: Text(
                      "Log In",
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
