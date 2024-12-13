import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';


class CustomProgressDialog extends StatelessWidget {

  const CustomProgressDialog({
    Key? key,
    required this.child,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.shape,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The duration of the animation to show when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve insetAnimationCurve;

  /// {@template flutter.material.dialog.shape}
  /// The shape of this dialog's border.
  ///
  /// Defines the dialog's [Material.shape].
  ///
  /// The default shape is a [RoundedRectangleBorder] with a radius of 2.0.
  /// {@endtemplate}
  final ShapeBorder? shape;

  Color _getColor(BuildContext context) {
    return Theme.of(context).dialogBackgroundColor;
  }

  static const RoundedRectangleBorder _defaultDialogShape =
  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)));

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets +
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
        duration: insetAnimationDuration,
        curve: insetAnimationCurve,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Material(
                elevation: 24.0,
                type: MaterialType.card,
                shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//the code below is writeen by Vikas-Jilla and the above code is from existing material dialog library
class ProgressDialog {
  bool isDismissed = true;
  var lock = Lock();
  Timer? _timer;
  Future<void> dismissProgressDialog(BuildContext context) async {
    _timer?.cancel();
    await lock.synchronized(() async {
      if (isDismissed) {
        return;
      }
      isDismissed = true;
      Navigator.of(context, rootNavigator: true).pop(true);
    });
  }

  void showProgressDialog(BuildContext context,{
    Color barrierColor = Colors.black12,
    String? textToBeDisplayed,
    Duration dismissAfter =const Duration(seconds: 30),
    Function? onDismiss
  })
  {
    dismissProgressDialog(context).then((_){
      isDismissed = false;
      showGeneralDialog<bool>(
        context: context,
        barrierColor: barrierColor,
        pageBuilder: (context, animation1, animation2) {

          return CustomProgressDialog(
            child: Container(
                clipBehavior: Clip.hardEdge,
                decoration:  BoxDecoration(
                    color: Theme.of(context).primaryColor.withAlpha(20),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.all(15),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:  <Widget>[
                      const CupertinoActivityIndicator(
                        radius: 15,
                      ),

                      textToBeDisplayed == null
                          ? const Padding(
                        padding: EdgeInsets.all(0),
                      )
                          : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child:Text(
                            textToBeDisplayed,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )
                      )
                    ]
                )),
          );
        },
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 100),
      ).then((dismissed) {
        isDismissed = dismissed!;
      });
      // _timer = Timer(dismissAfter,() {
      //   dismissProgressDialog(context);
      //   if (onDismiss != null) onDismiss();
      // });
    });

  }

}