import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constant/my_theme.dart';


class MyTextFormField extends StatelessWidget {
  final Widget? prefixIcon;
  final String? labelText;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final String? Function(String?)? onSaved;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmitted;
  final bool? readOnly;
  final int? minLines;
  final int? maxLines;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;

  const MyTextFormField({
    Key? key,
    this.prefixIcon,
    required this.hintText,
    this.focusNode,
    this.labelText,
    this.minLines,
    this.maxLines,
    this.obscureText = false,
    this.suffixIcon,
    this.onTap,
    this.onSaved,
    this.onFieldSubmitted,
    this.onChanged,
    this.readOnly = false,
    this.initialValue,
    this.controller,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.validator, this.autofillHints,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:MainAxisAlignment.start,
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Text("$labelText",style:TextStyle(fontSize:14,color:MyColor.onBackground,fontWeight:FontWeight.w500),),
        const SizedBox(height:8,),
        TextFormField(
          autofillHints:autofillHints,
          textAlign:TextAlign.start,
          focusNode: focusNode,
          style:const TextStyle(fontSize:16),
          autocorrect:true,
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          cursorColor:MyColor.onBackground,
          controller: controller,
          onTap: onTap,
          onSaved:onSaved,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          readOnly: readOnly!,
          initialValue: initialValue,
          keyboardType: keyboardType,
          maxLines: maxLines??1,
          minLines: minLines,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            fillColor:MyColor.background,
            hoverColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide:  BorderSide(color: MyColor.border,width:1),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: MyColor.border,width:1),
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color:MyColor.border),
              borderRadius: BorderRadius.circular(6),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color:MyColor.border),
              borderRadius: BorderRadius.circular(6),
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            // isDense:true,
            hintStyle: TextStyle(fontSize:14,color: MyColor.subTextGrey,fontWeight:FontWeight.w400),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: prefixIcon,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth:10,
              minHeight:50,
            ),
            suffixIcon: suffixIcon,
          ),
          obscureText: obscureText,
        ),
      ],
    );
  }
}
