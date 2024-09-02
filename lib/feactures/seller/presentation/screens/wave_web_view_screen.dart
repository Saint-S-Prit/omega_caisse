import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/services/subscription/subscription_service.dart';
import '../../../../core/utils/styles/color.dart';


class WaveWebViewScreen extends StatefulWidget {
  final String url;

  const WaveWebViewScreen({super.key, required this.url});

  @override
  State<WaveWebViewScreen> createState() => WebViewState();
}

WebViewController webViewController = WebViewController();

class WebViewState extends State<WaveWebViewScreen> {
  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setUserAgent(
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15')
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    webViewController.loadRequest(Uri.parse('about:blank'));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        //SystemNavigator.pop(); // Ferme l'application
        SubscriptionService().login(context);
        return false;
      },
      child: Scaffold(


        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top),
          child: SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
        ),


        body: WebViewWidget(controller: webViewController),
      )
  );
}