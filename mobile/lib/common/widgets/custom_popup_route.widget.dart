import 'package:flutter/material.dart';

class CustomPopupRoute<T> extends PopupRoute<T> {
  CustomPopupRoute({
    required this.child,
    Color barrierColor = const Color(0x80000000),
    bool barrierDismissible = true,
    String? barrierLabel,
    Duration transitionDuration = const Duration(milliseconds: 200),
    this.useSafeArea = true,
  })  : _barrierColor = barrierColor,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _transitionDuration = transitionDuration;

  final Widget child;
  final Color _barrierColor;
  final bool _barrierDismissible;
  final String? _barrierLabel;
  final Duration _transitionDuration;
  final bool useSafeArea;

  @override
  Color? get barrierColor => _barrierColor;

  @override
  bool get barrierDismissible => _barrierDismissible;

  @override
  String? get barrierLabel => _barrierLabel;

  @override
  Duration get transitionDuration => _transitionDuration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: useSafeArea ? SafeArea(child: child) : child,
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.linear,
      ),
      child: child,
    );
  }
}
