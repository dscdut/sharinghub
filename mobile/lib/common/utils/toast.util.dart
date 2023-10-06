import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/generated/locale_keys.g.dart';

enum ToastPosition { TOP, BOTTOM }

abstract class ToastUtil {
  static void showSuccess(
    BuildContext context, {
    String? text,
    ToastPosition position = ToastPosition.TOP,
  }) {
    _showToast(
      context,
      text: text ?? LocaleKeys.texts_success.tr(),
      backgroundColor: Colors.green,
      position: position,
      leading: const Icon(
        Icons.check_circle_rounded,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  static void showError(
    BuildContext context, {
    String? text,
    ToastPosition position = ToastPosition.TOP,
  }) {
    _showToast(
      context,
      text: text ?? LocaleKeys.texts_error_occur.tr(),
      backgroundColor: Colors.redAccent,
      position: position,
      leading: const Icon(
        Icons.warning_amber_outlined,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  static void _showToast(
    BuildContext context, {
    required String text,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.BOTTOM,
    Color backgroundColor = const Color(0xAA000000),
    TextStyle textStyle = const TextStyle(fontSize: 15, color: Colors.white),
    double borderRadius = 10.0,
    Border? border,
    Widget? leading,
    Widget? trailing,
  }) {
    ToastView.dismiss();
    ToastView.createView(
      context,
      text: text,
      duration: duration,
      position: position,
      backgroundColor: backgroundColor,
      textStyle: textStyle,
      borderRadius: borderRadius,
      border: border,
      leading: leading,
      trailing: trailing,
    );
  }
}

class ToastView {
  static final ToastView _instance = ToastView._internal();

  factory ToastView() => _instance;

  ToastView._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void createView(
    BuildContext context, {
    required String text,
    Duration? duration,
    ToastPosition position = ToastPosition.BOTTOM,
    required Color backgroundColor,
    required TextStyle textStyle,
    required double borderRadius,
    Border? border,
    Widget? leading,
    Widget? trailing,
  }) async {
    overlayState = Overlay.of(context);

    final Widget toastChild = ToastCard(
      duration: duration ??
          const Duration(
            seconds: 2,
          ),
      position: position,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading ?? const SizedBox.shrink(),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: Text(text, style: textStyle),
            ),
            const SizedBox(
              width: 6,
            ),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return _showWidgetBasedOnPosition(
          toastChild,
          position,
          context,
        );
      },
    );

    _isVisible = true;
    overlayState!.insert(_overlayEntry!);
    await Future.delayed(duration ?? const Duration(seconds: 2));
    dismiss();
  }

  static Positioned _showWidgetBasedOnPosition(
    Widget child,
    ToastPosition toastPosition,
    BuildContext context,
  ) {
    switch (toastPosition) {
      case ToastPosition.TOP:
        return Positioned(
          top: context.paddingTop + 10,
          left: 10,
          right: 10,
          child: child,
        );
      default:
        return Positioned(
          bottom: context.paddingBottom + 10,
          left: 10,
          right: 10,
          child: child,
        );
    }
  }

  static void dismiss() {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastCard extends StatefulWidget {
  const ToastCard({
    Key? key,
    this.fadeDuration = 500,
    required this.child,
    required this.duration,
    required this.position,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final int fadeDuration;
  final ToastPosition position;

  @override
  ToastStateFulState createState() => ToastStateFulState();
}

class ToastStateFulState extends State<ToastCard>
    with SingleTickerProviderStateMixin {
  void showAnimation() {
    _animationController!.forward();
  }

  void hideAnimation() {
    _animationController!.reverse();
    _timer?.cancel();
  }

  AnimationController? _animationController;
  late Animation _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Timer? _timer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.fadeDuration),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.position == ToastPosition.BOTTOM ? 1 : -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();

    showAnimation();
    _timer = Timer(widget.duration, hideAnimation);
  }

  @override
  void deactivate() {
    _timer?.cancel();
    _animationController!.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation as Animation<double>,
      child: SlideTransition(
        position: _slideAnimation,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
