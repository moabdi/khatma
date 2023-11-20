import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/routing/app_router.dart';
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
  // ignore: unused_field
  bool _showAppBar = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    const PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setBackgroundColor(HexColor("#FFF9EF"))
      ..enableZoom(true)
      ..goBack()
      ..canGoForward()
      ..canGoBack()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://tanzil.net/#${widget.idSourat}:${widget.idVerse}'));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        minimum: EdgeInsets.only(top: 50),
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            Positioned(
                top: 0,
                left: 0,
                child: OutlinedButton.icon(
                  onPressed: () => context.goNamed(AppRoute.home.name),
                  icon: Icon(Icons.chevron_left),
                  label: Text("Return"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(HexColor("#E6E6EB"))),
                ))
          ],
        ),
      ),
    );
  }
}
