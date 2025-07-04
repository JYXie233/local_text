part of '../locale_text.dart';

class InheritedLocaleTextApp extends InheritedWidget {
  const InheritedLocaleTextApp({
    super.key,
    required this.stream,
    required this.page,
    this.category,
    required this.update,
    required this.reloadFromLocale,
    required this.reloadFromRemote,
    this.locale,
    required super.child,
  });

  final Locale? locale;
  final String page;
  final String? category;

  final void Function(Locale? locale) update;
  final Future Function() reloadFromLocale;
  final Future Function() reloadFromRemote;

  final Stream<Locale?> stream;

  @override
  bool updateShouldNotify(InheritedLocaleTextApp oldWidget) {
    return page != oldWidget.page ||
        category != oldWidget.category ||
        locale != oldWidget.locale;
  }
}

class LocaleTextApp extends StatefulWidget {
  const LocaleTextApp({
    super.key,
    this.locale,
    required this.page,
    this.category,
    required this.builder,
    this.filePath,
    this.loadingBuilder,
    this.textAssetsPath,
    this.styleAssetsPath,
    this.textUrl,
    this.styleUrl,
  });
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, Locale? locale) builder;
  final Locale? locale;
  final String page;
  final String? category;

  final String? filePath;
  final String? textAssetsPath;
  final String? styleAssetsPath;
  final String? textUrl;
  final String? styleUrl;

  static InheritedLocaleTextApp? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<InheritedLocaleTextApp>();
  }

  @override
  State<StatefulWidget> createState() {
    return _LocaleTextAppState();
  }
}

class _LocaleTextAppState extends State<LocaleTextApp>
    with TickerProviderStateMixin {
  late Locale? _locale;
  bool _firstLaunch = true;

  final StreamController<Locale?> _streamController =
      StreamController.broadcast();

  @override
  void initState() {
    _locale = widget.locale;
    LocaleTextStorage()._locale = _locale;
    print("$this locale:$_locale");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await LocaleTextStorage().init(
          filePath: widget.filePath,
          textAssetsPath: widget.textAssetsPath,
          styleAssetsPath: widget.styleAssetsPath,
          textUrl: widget.textUrl,
          styleUrl: widget.styleUrl);
      setState(() {
        _firstLaunch = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedLocaleTextApp(
      stream: _streamController.stream,
      page: widget.page,
      category: widget.category,
      locale: _locale,
      update: _update,
      reloadFromLocale: LocaleTextStorage().reloadFromLocale,
      reloadFromRemote: LocaleTextStorage().reloadFromRemote,
      child: _firstLaunch && !LocaleTextStorage()._installed
          ? widget.loadingBuilder != null
              ? widget.loadingBuilder!(context)
              : const MaterialApp(
                  home: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
          : widget.builder(context, _locale),
    );
  }

  void _update(Locale? locale) {
    LocaleTextStorage()._locale = locale;
    _streamController.add(locale);
    setState(() {
      _locale = locale;
    });
  }
}
