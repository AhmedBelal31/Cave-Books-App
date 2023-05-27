import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatelessWidget {
  // const WebViewScreen({Key? key}) : super(key: key);
  final String url;
// / var controller  =WebViewController();
  WebViewController controller  =WebViewController();



  WebViewScreen({required this.url});
  @override
  Widget build(BuildContext context) {
    // controller = WebViewController().loadRequest(Uri.parse(url))  ;
    controller.loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: AppBar(),

      body: WebViewWidget(
          controller:controller
      ),
    );
  }


// void loadurl() async
// {
// await  controller.loadRequest(Uri.parse(url));
// }



}
