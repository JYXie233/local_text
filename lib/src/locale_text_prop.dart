part of '../locale_text.dart';

class LocaleTextProp {
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? align;
  final Color? color;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? padding;
  final double? margin;
  final double? borderRadius;
  final double? borderWidth;
  final double? lineHeight;
  final String? fontFamily;

  LocaleTextProp(
      {required this.fontSize,
      required this.fontWeight,
      required this.lineHeight,
      required this.fontFamily,
      required this.align,
      required this.color,
      required this.borderColor,
      required this.backgroundColor,
      required this.padding,
      required this.margin,
      required this.borderWidth,
      required this.borderRadius});

  TextStyle? get textStyle {
    if (color != null ||
        backgroundColor != null ||
        fontSize != null ||
        fontWeight != null) {
      print("color:$color");
      return TextStyle(
          color: color,
          backgroundColor: backgroundColor,
          height: lineHeight,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          fontSize: fontSize);
    }
    return null;
  }

  @override
  String toString() {
    return 'LocalTextProp{fontSize: $fontSize, fontWeight: $fontWeight, align: $align, color: $color, borderColor: $borderColor, backgroundColor: $backgroundColor, padding: $padding, margin: $margin, borderRadius: $borderRadius, borderWidth: $borderWidth}';
  }
}
