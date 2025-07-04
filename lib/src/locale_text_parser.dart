part of '../locale_text.dart';

class LocaleTextParser {
  static String parseText({
    required String page,
    required String? category,
    required String key,
    required Locale? locale,
    required List<String>? args,
  }) {
    dynamic value = _findMap(
        data: LocaleTextStorage()._texts,
        page: page,
        category: category,
        key: key,
        locale: locale ??
            LocaleTextStorage()._locale ??
            PlatformDispatcher.instance.locale);
    if (value is String) {
      value = value.replaceAll("\\n", '\n');
      for (var a in args ?? []) {
        value = value?.replaceFirst("%s", "${a}");
      }
    }
    return value ?? '[$key]';
  }

  static LocaleTextProp? parseProp({
    required String page,
    required String? category,
    required String key,
    required Locale? locale,
  }) {
    final Map<String, dynamic>? value = _findMap(
        data: LocaleTextStorage()._styles,
        page: page,
        category: category,
        key: key,
        locale: locale ??
            LocaleTextStorage()._locale ??
            PlatformDispatcher.instance.locale);

    if (value != null) {
      final props = [
        "font_size",
        "font_weight",
        "align",
        "color",
        "border_color",
        "background_color",
        "padding",
        "margin",
        "border_radius",
        "border_width",
        "font_family",
        "line_height",
      ];
      bool hasProp = false;
      for (final p in props) {
        if (value.containsKey(p) && value[p] != null) {
          hasProp = true;
          break;
        }
      }
      LocaleTextProp? prop;
      if (hasProp) {
        prop = LocaleTextProp(
          lineHeight: double.tryParse("${value['line_height']}"),
          fontFamily: value["font_family"],
          borderWidth: double.tryParse("${value['border_width']}"),
          fontSize: double.tryParse("${value['font_size']}"),
          fontWeight: _fontWeight(value['font_weight']),
          align: value['align'] == 'center'
              ? TextAlign.center
              : value['align'] == 'left'
                  ? TextAlign.left
                  : value['align'] == 'right'
                      ? TextAlign.right
                      : value['align'] == 'justify'
                          ? TextAlign.justify
                          : null,
          color: _parseColor(value['color']),
          borderColor: _parseColor(value['border_color']),
          backgroundColor: _parseColor(value['background_color']),
          padding: double.tryParse("${value['padding']}"),
          margin: double.tryParse("${value['margin']}"),
          borderRadius: double.tryParse("${value['border_radius']}"),
        );
      }
      // print("toTextStyle:$value,$prop");
      return prop;
    }

    return null;
  }
}

FontWeight? _fontWeight(value) {
  switch ("$value") {
    case "100":
      return FontWeight.w100;
    case "200":
      return FontWeight.w200;
    case "300":
      return FontWeight.w300;
    case "400":
      return FontWeight.w400;
    case "500":
      return FontWeight.w500;
    case "600":
      return FontWeight.w600;
    case "700":
      return FontWeight.w700;
    case "800":
      return FontWeight.w800;
    case "900":
      return FontWeight.w900;
  }
  return null;
}

Color? _parseColor(value) {
  if (value != null && value is String) {
    final array = (value as String)
        .replaceAll("rgba(", "")
        .replaceAll(")", "")
        .split(",");
    return Color.fromARGB((255 * double.parse(array[3])).toInt(),
        int.parse(array[0]), int.parse(array[1]), int.parse(array[2]));
  }
  return null;
}

dynamic _findMap(
    {required Map<String, dynamic> data,
    required String page,
    required String? category,
    required String key,
    required Locale locale}) {
  Map<String, dynamic>? languageMap;
  Map? map = data[page];
  // print("page:${map}");
  if (map?.containsKey(category) == true) {
    map = map?[category];
    // print("category:${map}");
    if (map?.containsKey(key) == true) {
      languageMap = map?[key];
    }
  } else {
    if (map?.containsKey(key) == true) {
      languageMap = map?[key];
    }
  }
  Locale l = locale;

  String localeKey = [l.scriptCode ?? '', l.countryCode ?? '']
      .fold(l.languageCode, (p, n) => n.isEmpty ? p : "${p}_${n}");
  // print("languageMap:${languageMap},localeKey:${localeKey}");
  dynamic value;
  if (languageMap?.containsKey(localeKey) == true) {
    value = languageMap![localeKey];
  }
  if (value == null) {
    localeKey = "${l.languageCode}_${l.scriptCode}";
    if (languageMap?.containsKey(localeKey) == true) {
      value = languageMap![localeKey];
    }
  }
  if (value == null) {
    localeKey = "${l.languageCode}_${l.countryCode}";
    if (languageMap?.containsKey(localeKey) == true) {
      value = languageMap![localeKey];
    }
  }
  if (value == null) {
    localeKey = "${l.languageCode}";
    if (languageMap?.containsKey(localeKey) == true) {
      value = languageMap![localeKey];
    }
  }
  if (value == null) {
    localeKey = "${l.languageCode}_${l.scriptCode}";
    if (languageMap != null) {
      for (var m in languageMap.entries) {
        if (m.key.startsWith(localeKey)) {
          value = m.value;
          break;
        }
      }
    }
  }
  if (value == null) {
    localeKey = "${l.languageCode}";
    if (languageMap != null) {
      for (var m in languageMap.entries) {
        if (m.key.startsWith(localeKey)) {
          value = m.value;
          break;
        }
      }
    }
  }
  return value;
}
