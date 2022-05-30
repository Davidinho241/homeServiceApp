import 'package:flutter/material.dart';
import 'package:home_service/src/utils/colors.dart';
import 'package:home_service/src/utils/sizes.dart';

class SearchOptionTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function onTap;

  SearchOptionTextField({
    @required this.controller,
    @required this.label,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TextField(
        controller: controller,
        enabled: false,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: FontSize.s20,
        ),
        decoration: InputDecoration(
          labelText: "$label",
          labelStyle: TextStyle(
            fontSize: FontSize.s18,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}

class OutlineTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final double height;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final bool obscureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final bool enable;

  OutlineTextField({
    this.hintText,
    this.labelText,
    this.controller,
    this.height,
    this.hintStyle,
    this.labelStyle,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputType,
    this.enable = true,
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);
    return Container(
      height: height != null ? height : Sizes.s50,
      child: TextField(
        enabled: enable,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: "$hintText",
          labelText: "$labelText",
          hintStyle: hintStyle,
          labelStyle: labelStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(Sizes.s10)),
            borderSide: BorderSide(width: 1, color: Colors.grey[100]),
          ),
          fillColor: mode.brightness == Brightness.dark
              ? Colors.grey[800]
              : Colors.grey[100],
          filled: !enable,
        ),
      ),
    );
  }
}
