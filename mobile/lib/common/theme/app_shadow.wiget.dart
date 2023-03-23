import 'package:flutter/material.dart';

abstract class AppShadow {
  static final List<BoxShadow> primary = [
    BoxShadow(
      blurRadius: 12,
      offset: const Offset(0, 2),
      color: Colors.black.withOpacity(0.1),
    )
  ];
}
