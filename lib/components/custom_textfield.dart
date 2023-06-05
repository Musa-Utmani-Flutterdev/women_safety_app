import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final  Function(String?)? onSave;
  final int? maxLines;
  final bool isPassword;
  final bool enable;
  final bool? check;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;

  CustomTextField(
      {this.focusNode,
      this.textInputAction,
      this.controller,
      this.prefix,
      this.validate,
      this.check,
      this.enable = true,
      this.hintText,
      this.isPassword = false,
      this.keyboardType,
      this.maxLines,
      this.onSave,
      this.suffix});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: enable == true ? true : enable,
        maxLines: maxLines == null ? 1 : maxLines,
        onSaved: onSave,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardType == null ? TextInputType.name : keyboardType,
        controller: controller,
        validator: validate,
        obscureText: isPassword == false ? false : isPassword,
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          labelText: hintText,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Color(0xFF909A9E),
              ),
              borderRadius: BorderRadius.circular(30)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(30)),
        ));
  }
}
