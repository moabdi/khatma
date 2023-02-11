import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoushafScreen extends StatefulWidget {
  const MoushafScreen({super.key, this.idSourat = 1, this.idVerse = 1});

  final int idSourat;
  final int idVerse;

  @override
  State<MoushafScreen> createState() => _MoushafScreenState();
}

class _MoushafScreenState extends State<MoushafScreen> {
  late final WebViewController _controller;
  // ignore: unused_field
  final bool _showAppBar = false;

  @override
  void initState() {
    super.initState();

    const PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://tanzil.net/#${widget.idSourat}:${widget.idVerse}'));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
