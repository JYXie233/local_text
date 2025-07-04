part of '../locale_text.dart';

class LocaleTextSpan extends TextSpan {
  LocaleTextSpan({
    required String text,
    required String page,
    List<String>? args,
    String? category,
    super.locale,
    TextStyle? style,
    super.recognizer,
    MouseCursor? mouseCursor,
    super.onEnter,
    super.onExit,
    super.semanticsLabel,
    super.spellOut,
  }) : super(
          text: LocaleTextParser.parseText(
            key: text,
            page: page,
            category: category,
            locale: locale,
            args: args,
          ),
          style: style != null
              ? style.merge(LocaleTextParser.parseProp(
                      key: text, page: page, category: category, locale: locale)
                  ?.textStyle)
              : LocaleTextParser.parseProp(
                      key: text, page: page, category: category, locale: locale)
                  ?.textStyle,
        );
}
