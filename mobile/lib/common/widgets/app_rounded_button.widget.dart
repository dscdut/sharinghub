import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/loading_dot.widget.dart';

class AppRoundedButton extends StatefulWidget {
  final VoidCallback onPressed;

  final double? width;
  final double height;
  final double borderRadius;
  final double elevation;

  final Color backgroundColor;
  final Color disableBackgroundColor;
  final Color? shadowColor;

  final String content;

  final TextStyle textStyle;

  final bool isLoading;
  final bool isDisable;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? child;

  final BorderSide? borderSide;

  AppRoundedButton({
    Key? key,
    required this.onPressed,
    this.width,
    this.height = 48,
    this.borderRadius = 7,
    this.elevation = 0,
    this.backgroundColor = ColorStyles.blue400,
    this.disableBackgroundColor = ColorStyles.gray300,
    this.shadowColor,
    required this.content,
    TextStyle? textStyle,
    this.isDisable = false,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.borderSide,
  })  : textStyle =
            textStyle ?? TextStyles.s14BoldText.copyWith(color: Colors.white),
        super(key: key);

  @override
  State<AppRoundedButton> createState() => _AppRoundedButtonState();
}

class _AppRoundedButtonState extends State<AppRoundedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Theme(
        data: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                widget.isDisable
                    ? widget.disableBackgroundColor
                    : widget.backgroundColor,
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                widget.isDisable
                    ? widget.disableBackgroundColor
                    : widget.backgroundColor,
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                widget.isDisable
                    ? widget.disableBackgroundColor
                    : widget.backgroundColor,
              ),
              elevation: MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused)) {
                    return 0;
                  }

                  return widget.elevation;
                },
              ),
            ),
          ),
        ),
        child: ElevatedButton(
          onPressed:
              (widget.isLoading || widget.isDisable) ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              side: widget.borderSide ?? BorderSide.none,
            ),
            shadowColor: widget.shadowColor,
            splashFactory: NoSplash.splashFactory,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            disabledBackgroundColor: widget.disableBackgroundColor,
            disabledForegroundColor: widget.disableBackgroundColor,
            enableFeedback: false,
          ),
          child: widget.isLoading
              ? const LoadingDot()
              : (widget.child ??
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.prefixIcon != null)
                          Row(
                            children: [
                              widget.prefixIcon!,
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        Text(
                          widget.content,
                          style: widget.textStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.suffixIcon != null)
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              widget.suffixIcon!
                            ],
                          ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
