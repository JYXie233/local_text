import 'package:flutter/material.dart';
import 'package:locale_text/locale_text.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> with LocaleTextDelegate {
  int _count = 0;

  @override
  String get localePage => "主页面";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DelegateText(
          '标题',
        ),
      ),
      body: Column(
        children: [
          FilledButton(
              onPressed: () async {
                await LocaleTextApp.of(context)?.reloadFromRemote();
                await showDialog(
                    context: context,
                    builder: (context) {
                      var localeTextProvider = LocaleTextProvider.of(context);
                      print('localeTextProvider:${localeTextProvider}');
                      return AlertDialog(
                        title: DelegateText(
                          "弹窗标题",
                          category: "弹窗",
                        ),
                        content: DelegateText(
                          "语言已加载完成",
                          category: "弹窗",
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {},
                              child: DelegateText(
                                "好的",
                                category: "弹窗",
                              ))
                        ],
                      );
                    });
                setState(() {});
              },
              child: DelegateText(
                '重新加载语言',
              )),
          FilledButton(
            onPressed: () async {
              int type = _count % 3;
              if (type == 0) {
                LocaleTextApp.of(context)
                    ?.update(const Locale.fromSubtags(languageCode: "en"));
              } else if (type == 1) {
                LocaleTextApp.of(context)?.update(const Locale.fromSubtags(
                    languageCode: "zh", scriptCode: "Hant"));
              } else {
                LocaleTextApp.of(context)?.update(const Locale.fromSubtags(
                    languageCode: "zh", scriptCode: "Hans"));
              }
              _count++;
            },
            child: DelegateText(
              '切换语言',
              style: TextStyle(color: Colors.amber),
            ),
          ),
          DelegateText(
            '文本',
          ),
          Text.rich(TextSpan(children: [
            DelegateTextSpan(text: "第一段", args: ["不知道"]),
            DelegateTextSpan(text: "第二段"),
            DelegateTextSpan(text: "第三段"),
            DelegateTextSpan(text: "第四段"),
          ])),
          LocaleText("来自LocaleTextApp的Page")
        ],
      ),
    );
  }
}
