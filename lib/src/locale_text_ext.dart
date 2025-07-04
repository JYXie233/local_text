part of '../locale_text.dart';

extension LocalTextExtString on String {
  /// 本地化文本
  ///
  /// [args] 文本参数
  /// [context] 上下文
  /// [page] 页面为空的话，组件必须包裹在LocaleTextProvider中或者LocaleTextApp中
  /// [category] 类别
  /// [locale] 本地化
  String lt(
      {List<String>? args,
      BuildContext? context,
      String? page,
      String? category,
      Locale? locale}) {
    final LocaleTextProvider? localeTextProvider =
        context == null ? null : LocaleTextProvider.of(context);
    final InheritedLocaleTextApp? localeTextApp =
        context == null ? null : LocaleTextApp.of(context);

    final finalPage = page ?? localeTextProvider?.page ?? localeTextApp?.page;
    final finalLocale = locale ?? localeTextApp?.locale;
    final finalCategory =
        category ?? localeTextProvider?.category ?? localeTextApp?.category;
    if (finalPage == null) {
      throw Exception(
          "page is null, please wrap widget with LocaleTextProvider or LocaleTextApp");
    }
    final str = LocaleTextParser.parseText(
        page: finalPage,
        category: finalCategory,
        key: this,
        locale: finalLocale,
        args: args);
    return str;
  }
}
