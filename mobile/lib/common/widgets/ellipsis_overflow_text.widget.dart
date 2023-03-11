import 'package:flutter/material.dart';

///
/// Flutter widget that automatically sets the number of lines to be shown on a text
/// with the ellipsis overflow type.
///
class EllipsisOverflowText extends StatelessWidget {
  const EllipsisOverflowText(
    this.data, {
    Key? key,
    this.textKey,
    this.locale,
    this.maxLines,
    this.semanticsLabel,
    this.selectionColor,
    this.softWrap,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    this.textScaleFactor,
    this.textWidthBasis,
  })  : assert(
          maxLines == null || maxLines > 0,
          'maxLines must be greather than 0.',
        ),
        assert(
          key == null || key != textKey,
          'Key and textKey must not be equal.',
        ),
        super(key: key);

  final Key? textKey;
  final String data;
  final TextStyle? style;
  static const double _defaultFontSize = 14;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final double? textScaleFactor;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final int? maxLines;

  int? _calculateMaxLines(BoxConstraints constraints, TextPainter textPainter) {
    if (!constraints.hasBoundedHeight || !constraints.hasBoundedWidth) {
      return null;
    }

    final boxes = textPainter.getBoxesForSelection(
      TextSelection(baseOffset: 0, extentOffset: data.length),
    );

    final textHeight = boxes.first.toRect().height;

    final maxLines = constraints.maxHeight ~/
        (textHeight - (textPainter.text?.style?.height ?? 1));

    if (maxLines < 1) {
      return null;
    }

    return maxLines;
  }

  List _loadData(
    constraints,
    TextStyle style,
    double? textScale,
    int? initMaxLines,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(text: data, style: style),
      textDirection: TextDirection.ltr,
      locale: locale ?? style.locale,
      textScaleFactor: textScale ?? 1,
      textHeightBehavior: textHeightBehavior,
      strutStyle: strutStyle,
    );

    textPainter.layout(maxWidth: constraints.maxWidth);

    int? finalMaxLines =
        initMaxLines ?? _calculateMaxLines(constraints, textPainter);

    return [finalMaxLines, data];
  }

  @override
  Widget build(BuildContext context) {
    if (data.trim().isEmpty) {
      return Text(
        data,
        style: style,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final defaultTextStyle = DefaultTextStyle.of(context);

        TextStyle textStyle = style ?? defaultTextStyle.style;

        if (textStyle.fontSize == null) {
          textStyle = textStyle.copyWith(
            fontSize: EllipsisOverflowText._defaultFontSize,
          );
        }

        final textScale =
            textScaleFactor ?? MediaQuery.textScaleFactorOf(context);

        int? maxLinesFinal = maxLines ?? defaultTextStyle.maxLines;

        final r = _loadData(constraints, textStyle, textScale, maxLinesFinal);

        String newString = r[1];
        maxLinesFinal = r[0];

        return Text(
          newString,
          key: textKey,
          style: textStyle,
          overflow: TextOverflow.ellipsis,
          textHeightBehavior: textHeightBehavior,
          textAlign: textAlign,
          softWrap: softWrap,
          textDirection: textDirection,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScale,
          locale: locale,
          selectionColor: selectionColor,
          semanticsLabel: semanticsLabel,
          strutStyle: strutStyle,
          maxLines: maxLinesFinal,
        );
      },
    );
  }
}
