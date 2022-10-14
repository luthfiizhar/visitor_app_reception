import 'package:flutter/material.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/responsive.dart';

class LoginInputField extends StatefulWidget {
  LoginInputField(
      {required this.controller,
      this.hintText,
      this.focusNode,
      this.obsecureText,
      this.onSaved,
      this.validator,
      this.alignCenter,
      this.textInputAction,
      this.keyboardType,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final FocusNode? focusNode;
  final bool? obsecureText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final bool? alignCenter;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  @override
  State<LoginInputField> createState() => _LoginInputFieldState();
}

class _LoginInputFieldState extends State<LoginInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.obsecureText!,
      validator: widget.validator,
      onSaved: widget.onSaved,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textAlign: widget.alignCenter! ? TextAlign.center : TextAlign.left,
      cursorColor: eerieBlack,
      decoration: InputDecoration(
        isDense: true,
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(
            vertical: Responsive.isSmallTablet(context) ? 20 : 25,
            horizontal: 30),
        focusColor: silver,
        focusedErrorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: eerieBlack,
              width: 10,
            )),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: eerieBlack, width: 10)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF929AAB), width: 2.5)),
        fillColor: graySand,
        filled: true,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: orangeRed, width: 2.5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF929AAB), width: 2.5)),
        errorStyle: TextStyle(color: orangeRed, fontSize: 18),
      ),
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFF393E46)),
    );
  }
}
