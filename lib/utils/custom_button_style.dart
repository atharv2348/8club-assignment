import 'package:flutter/material.dart';

class CustomButtonStyle {
  static BoxDecoration buttonStyle1() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          const Color(0xFF222222).withOpacity(0.4),
          const Color(0xFF999999).withOpacity(0.4),
          const Color(0xFF222222).withOpacity(0.4),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: Colors.white.withOpacity(0.08)),
      color: Colors.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
