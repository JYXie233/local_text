import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:locale_text/locale_text.dart';

import 'main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleTextStorage().init(
      textUrl: 'http://192.168.0.108:5173/locale/text?appId=1',
      styleUrl: 'http://192.168.0.108:5173/locale/style?appId=1',
      textAssetsPath: "assets/text.json",
      styleAssetsPath: "assets/style.json");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LocaleTextApp(
        page: "公共",
        // locale: Locale.fromSubtags(languageCode: "zh", scriptCode: "Hant", countryCode: "CN"),
        builder: (context, locale) => MaterialApp(
              locale: locale,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [Locale("en", "US"), Locale("zh", "CN")],
              home: MainPage(),
            ));
  }
}
