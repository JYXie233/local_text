part of '../locale_text.dart';

class LocaleTextStorage {
  static final LocaleTextStorage _instance = LocaleTextStorage._internal();

  factory LocaleTextStorage() {
    return _instance;
  }

  LocaleTextStorage._internal() {}

  final Map<String, dynamic> _texts = {};
  final Map<String, dynamic> _styles = {};
  Locale? _locale;

  late String _path;
  String? _textAssetsPath;
  String? _styleAssetsPath;
  late String _textFilePath;
  late String _styleFilePath;
  String? _textUrl;
  String? _styleUrl;
  Dio? _dio;
  bool _installed = false;
  Future init(
      {String? filePath,
      String? textAssetsPath,
      String? styleAssetsPath,
      String? textUrl,
      String? styleUrl,
      bool reload = false}) async {
    _path = filePath ?? (await getApplicationCacheDirectory()).path;
    _textUrl = textUrl;
    _styleUrl = styleUrl;
    _textAssetsPath = textAssetsPath;
    _styleAssetsPath = styleAssetsPath;

    _textFilePath = p.join(_path, 'text.json');
    _styleFilePath = p.join(_path, 'style.json');
    File textFile = File(_textFilePath);
    File styleFile = File(_styleFilePath);
    if (reload) {
      if (await textFile.exists()) {
        await textFile.delete();
      }
      if (await styleFile.exists()) {
        await styleFile.delete();
      }
    }
    if (!(await textFile.exists())) {
      if (_textUrl != null) {
        _dio ??= Dio();
        await _dio?.download("${_textUrl}", _textFilePath);
      } else if (_textAssetsPath != null) {
        String jsonString = await rootBundle.loadString(_textAssetsPath!);
        await textFile.writeAsString(jsonString);
      }
    }

    if (!(await styleFile.exists())) {
      if (_styleUrl != null) {
        _dio ??= Dio();
        await _dio?.download("${_styleUrl}", _styleFilePath);
      } else if (_styleAssetsPath != null) {
        String jsonString = await rootBundle.loadString(_styleAssetsPath!);
        await styleFile.writeAsString(jsonString);
      }
    }

    await reloadFromLocale();

    _installed = true;
  }

  Future reloadFromRemote() async {
    if (await File(_textFilePath).exists()) {
      await File(_textFilePath).delete();
    }
    if (await File(_styleFilePath).exists()) {
      await File(_styleFilePath).delete();
    }
    await init();
  }

  Future reloadFromLocale() async {
    _texts.clear();
    File textFile = File(_textFilePath);
    if (await textFile.exists()) {
      var json = await textFile.readAsString();
      _texts.addAll(jsonDecode(json));
    }

    _styles.clear();
    File styleFile = File(_styleFilePath);
    if (await styleFile.exists()) {
      var json = await styleFile.readAsString();

      _styles.addAll(jsonDecode(json));
    }
  }
}
