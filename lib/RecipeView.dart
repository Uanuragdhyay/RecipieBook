import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String url;
  RecipeView(this.url, {Key? key}) : super(key: key);

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late String finalUrl;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Convert "http" to "https" if needed
    finalUrl = widget.url.startsWith("http://")
        ? widget.url.replaceAll("http://", "https://")
        : widget.url;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(finalUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Recipe App"),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
