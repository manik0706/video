import 'package:flutter/material.dart';
import 'package:sourcecad_app/utils/extensions/theme_extension.dart';
import '../constant/my_theme.dart';


class DropDownField<T> extends StatelessWidget {
  final String hintText;
  final String ?lableText;
  final void Function(T value) onTap;
  final TextEditingController? controller;
  final List<T> item;
  final T? value;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final String Function(T item) setText;
  final String? Function(dynamic)? validator;
  const DropDownField({
    Key? key,
    required this.hintText,
    this.lableText,
    required this.onTap,
    required this.setText,
    this.value,
    this.hintStyle,
    this.fillColor,
    this.borderColor,
    this.controller,
    this.validator, required this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField<T>(
      isExpanded: true,
      validator:validator,
      decoration: InputDecoration(
          labelText:lableText??"",
          labelStyle: TextStyle(fontSize:14,color:context.theme.onBackground),
          hintStyle: hintStyle,
          fillColor: fillColor ?? context.theme.background,
          filled: true,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 0,horizontal:14),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8) //                 <--- border radius here
            ),
            borderSide: BorderSide(color: borderColor ?? MyColor.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: borderColor ?? MyColor.border,width:1),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:borderColor ?? MyColor.border),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8) //                 <--- border radius here
            ),
            borderSide: BorderSide(color: Colors.red),
          )),
      hint: hintStyle != null ?Text(hintText,style:hintStyle,) :Text(hintText,style:const TextStyle(fontSize:14),),
      style:const TextStyle(fontSize:14),
      items:item.map((value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(setText(value),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize:14,color:context.theme.onBackground),),
        );
      }).toList(),
      onChanged: (dynamic newValue) {
        onTap(newValue);
      },
      value: value,
    );
  }
}
