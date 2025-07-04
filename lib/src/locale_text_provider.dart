part of '../locale_text.dart';

class LocaleTextProvider extends InheritedWidget {
  const LocaleTextProvider({
    super.key,
    required this.page,
    this.category,
    required super.child,
  });

  final String page;
  final String? category;

  static LocaleTextProvider? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<LocaleTextProvider>();
  }

  @override
  bool updateShouldNotify(LocaleTextProvider oldWidget) {
    return page != oldWidget.page || category != oldWidget.category;
  }
}
