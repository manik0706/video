import 'package:flutter/material.dart';
import 'package:sourcecad_app/utils/extensions/theme_extension.dart';
import 'package:sourcecad_app/utils/image_path.dart';
import '../constant/my_theme.dart';
import '../view_models/splash_vm.dart';
import '../widgets/base_widgets.dart';

class SplashWidget extends BaseWidget<SplashVM>{
  const SplashWidget({super.key});

  @override
  Widget buildUI(BuildContext context, SplashVM viewModel) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.primary,
        body:  Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:10),
            child: Image.asset(ImagePaths.sourceCad,
            ),
          ),
        ),
      ),
    );
  }

}
