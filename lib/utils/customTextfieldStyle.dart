import 'package:assignment/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldStyle {
  static InputDecoration decor({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 20),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors.primaryAccent),
        borderRadius: BorderRadius.circular(10),
      ),
      fillColor: Colors.white.withOpacity(0.05),
    );
  }
}
