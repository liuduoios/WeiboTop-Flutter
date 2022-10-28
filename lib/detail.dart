import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailScreenArguments {
  final String title;
  final String url;

  DetailScreenArguments(this.title, this.url);
}

class Detail extends StatefulWidget {
  const Detail({super.key});

  static const routeName = '/detail';

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    } else if (Platform.isIOS || Platform.isMacOS) {
      WebView.platform = CupertinoWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailScreenArguments;
    final url =
        'https://s.weibo.com/weibo?q=${Uri.encodeQueryComponent(args.title)}';

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
