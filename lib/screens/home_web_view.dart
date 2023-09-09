import 'package:dadipay_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeWebView extends StatefulWidget {
  const HomeWebView({super.key});

  @override
  State<HomeWebView> createState() => _HomeWebViewState();
}

class _HomeWebViewState extends State<HomeWebView> {
  //initialised the webview Controller
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse(
              'https://app.dadipay.co/',
            ),
            headers: {
              'Accept': 'application/vnd.api+json',
              'Content-Type': 'application/json',
            }),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
      )),
    );
  }
}
