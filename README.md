# easy_tips

简单提示插件.


## TODO

* [ ] 支持TOAST
* [ ] 支持动态设置加载文本

## Example

```dart
import 'package:flutter/material.dart';
import 'package:easy_tips/easy_tips.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: EasyWrapContext(   // Context节点
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: const Text('加载'),
              onPressed: () async {
                EasyLoading.task(() async {
                  // to do something
                  await Future.delayed(Duration(seconds: 2));
                });
              },
            ),
            RaisedButton(
              child: const Text('加载+文字'),
              onPressed: () {
                EasyLoading.task(() async {
                  // to do something
                  await Future.delayed(Duration(seconds: 2));
                }, text: "Loading...");
              },
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
