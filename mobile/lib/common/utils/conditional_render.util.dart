import 'package:flutter/material.dart';

abstract class ConditionalRenderUtil {
  static Widget single<T>(
    BuildContext context, {
    required T value,
    required Map<T, Widget Function(BuildContext context)> caseBuilders,
    required Widget Function(BuildContext context) fallbackBuilder,
  }) {
    if (caseBuilders[value] != null) {
      return caseBuilders[value]!(context);
    } else {
      return fallbackBuilder(context);
    }
  }
}
