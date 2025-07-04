part of '../locale_text.dart';

mixin LocaleTextDelegate {
  late String localePage;
  String? localeCategory;
  Locale? locale;

  String DelegateString(
    String text, {
    List<String>? args,
    String? category,
    String? defaultValue,
    Locale? locale,
  }) {
    return LocaleTextParser.parseText(
        page: localePage,
        category: category ?? localeCategory,
        key: text,
        locale: locale ?? this.locale,
        args: args);
  }

  LocaleTextSpan DelegateTextSpan({
    required String text,
    List<String>? args,
    String? category,
    Locale? locale,
    TextStyle? style,
    GestureRecognizer? recognizer,
    MouseCursor? mouseCursor,
    PointerEnterEventListener? onEnter,
    PointerExitEventListener? onExit,
    String? semanticsLabel,
    bool? spellOut,
  }) {
    return LocaleTextSpan(
      text: text,
      args: args,
      page: localePage,
      category: category ?? localeCategory,
      locale: locale ?? this.locale,
      style: style,
      recognizer: recognizer,
      mouseCursor: mouseCursor,
      onEnter: onEnter,
      onExit: onExit,
      semanticsLabel: semanticsLabel,
      spellOut: spellOut,
    );
  }

  LocaleText DelegateText(
    final String data, {
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    final Locale? locale,
    final bool? softWrap,
    final TextOverflow? overflow,
    final double? textScaleFactor,
    final TextScaler? textScaler,
    final int? maxLines,
    final String? semanticsLabel,
    final TextWidthBasis? textWidthBasis,
    final ui.TextHeightBehavior? textHeightBehavior,
    final Color? selectionColor,
    final String? category,
    final List<String>? args,
  }) {
    return LocaleText(
      data,
      page: localePage,
      category: category ?? localeCategory,
      locale: locale ?? this.locale,
      args: args,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
