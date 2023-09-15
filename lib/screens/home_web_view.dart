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
    double _progress = 0;
   

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse(
              'https://app.dadipay.co/android.php?login_token=2507|dVefvYbijC4nFeCm63nPMYL6UFAbmp2HNp2xNQqu',
            ),
            headers: {
              'Accept': 'application/vnd.api+json',
              'Content-Type': 'application/json',
            }),
       onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
              },
              onProgressChanged: (InAppWebViewController controller, int progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
        
      )),
      
    );
  }
}
