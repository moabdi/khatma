import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khatma/src/themes/theme.dart';
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
  bool _showAppBar = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    const PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color.fromARGB(0, 154, 24, 24))
      ..loadRequest(Uri.parse(
          'https://tanzil.net/#${widget.idSourat}:${widget.idVerse}'));

    _controller = controller;
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return GestureDetector(
      onVerticalDragEnd: showAppBar,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: AppTheme.getTheme().backgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: _showAppBar
              ? AppBar(
                  title: Text(
                    "Close",
                    style: AppTheme.getTheme().textTheme.bodySmall,
                  ),
                  leading: IconButton(
                      onPressed: () => {
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.edgeToEdge),
                            Navigator.pop(context),
                          },
                      icon: const Icon(Icons.close)),
                )
              : null,
          body: WebViewWidget(
            controller: _controller,
          ),
        ),
      ),
    );
  }

  void showAppBar(details) {
    if (details.velocity.pixelsPerSecond.dy < 0 ||
        details.velocity.pixelsPerSecond.dy > 0) {
      setState(() {
        _showAppBar = true;
        _timer = Timer(const Duration(seconds: 3), () {
          setState(() {
            _showAppBar = false;
          });
        });
      });
    }
  }
}
