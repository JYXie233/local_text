part of '../locale_text.dart';

class LocaleText extends StatefulWidget {
  final String? data;

  final TextStyle? style;

  final StrutStyle? strutStyle;

  final TextAlign? textAlign;

  final TextDirection? textDirection;

  final Locale? locale;
  final bool? softWrap;

  final TextOverflow? overflow;

  final double? textScaleFactor;

  final TextScaler? textScaler;

  final int? maxLines;

  final String? semanticsLabel;

  final TextWidthBasis? textWidthBasis;

  final ui.TextHeightBehavior? textHeightBehavior;

  final Color? selectionColor;

  final String? page;
  final String? category;
  final List<String>? args;
  const LocaleText(
    String this.data, {
    super.key,
    this.style,
    this.args,
    this.page,
    this.category,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    @Deprecated(
      'Use textScaler instead. '
      'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
      'This feature was deprecated after v3.12.0-2.0.pre.',
    )
    this.textScaleFactor,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  @override
  State<StatefulWidget> createState() {
    return _LocaleTextState();
  }
}

class _LocaleTextState extends State<LocaleText> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final localeTextApp = LocaleTextApp.of(context);
      _subscription = localeTextApp?.stream.listen((value) {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeTextProvider = LocaleTextProvider.of(context);
    final localeTextApp = LocaleTextApp.of(context);

    final page = widget.page ?? localeTextProvider?.page ?? localeTextApp!.page;
    final locale = widget.locale ?? localeTextApp?.locale;
    final category = widget.category ??
        localeTextProvider?.category ??
        localeTextApp?.category;
    final prop = LocaleTextParser.parseProp(
      page: page,
      category: category,
      key: widget.data!,
      locale: locale,
    );
    final str = LocaleTextParser.parseText(
        page: page,
        category: category,
        key: widget.data!,
        locale: locale,
        args: widget.args);
    final text = Text(
      str,
      key: widget.key,
      style: widget.style != null
          ? widget.style?.merge(prop?.textStyle)
          : prop?.textStyle,
      strutStyle: widget.strutStyle,
      textAlign: prop?.align ?? widget.textAlign,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      textScaleFactor: widget.textScaleFactor,
      textScaler: widget.textScaler,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior,
      selectionColor: widget.selectionColor,
    );

    if (prop?.padding != null ||
        prop?.margin != null ||
        prop?.borderColor != null ||
        prop?.borderWidth != null ||
        prop?.borderRadius != null) {
      // print("$this $prop");
      return Container(
        padding: EdgeInsets.all(prop?.padding ?? 0),
        margin: EdgeInsets.all(prop?.margin ?? 0),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(prop?.borderRadius ?? 0)),
          border: Border.all(
              color: prop?.borderColor ?? Colors.transparent,
              width: prop?.borderWidth ?? 0),
          color: prop?.backgroundColor,
        ),
        child: text,
      );
    } else {
      return text;
    }
  }
}
