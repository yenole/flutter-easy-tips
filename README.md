# easy_tips

简单易用的Toast和loading插件.


## TODO

* [x] 支持明暗主题
* [x] 支持TOAST吐司
* [x] 支持动态设置加载文本

## Example

```dart
import 'package:flutter/material.dart';
import 'package:easy_tips/easy_tips.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ValueNotifier<ThemeData> _theme =
      ValueNotifier<ThemeData>(ThemeData.light());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: _theme,
      builder: (context, theme, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          home: EasyWrapContext(
            child: MyHomePage(
              theme: _theme,
              title: 'Flutter Demo Home Page',
            ),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ValueNotifier<ThemeData> theme;

  MyHomePage({Key key, this.theme, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: const Text('亮色主题'),
                  onPressed: () {
                    theme.value = ThemeData.light();
                  },
                ),
                RaisedButton(
                  child: const Text('暗色主题'),
                  onPressed: () {
                    theme.value = ThemeData.dark();
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: const Text('加载'),
                  onPressed: () async {
                    EasyLoading load;
                    load = EasyLoading.task(() async {
                      await Future.delayed(Duration(seconds: 2));
                      load.setText('构建中...');
                      await Future.delayed(Duration(seconds: 2));
                      load.setText('签名中...');
                      await Future.delayed(Duration(seconds: 2));
                    });
                  },
                ),
                RaisedButton(
                  child: const Text('加载+文字'),
                  onPressed: () {
                    EasyLoading.task(() async {
                      await Future.delayed(Duration(seconds: 2));
                    }, text: "Loading...");
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: const Text("Toast-中间"),
                  onPressed: () {
                    EasyToast.delayed(Duration(seconds: 1), "中间-自定义时间",
                        align: Alignment.center);
                  },
                ),
                RaisedButton(
                  child: const Text("Toast-底部"),
                  onPressed: () {
                    EasyToast.short("底部-短时间");
                  },
                ),
                RaisedButton(
                  child: const Text("Toast-头部"),
                  onPressed: () {
                    EasyToast.long("头部-长时间", align: Alignment.topCenter);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```


## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
