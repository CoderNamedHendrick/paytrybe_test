import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class TrybeWebview extends StatefulWidget {
  const TrybeWebview({Key? key, this.title, required this.url})
      : super(key: key);
  final String? title;
  final String url;

  @override
  State<TrybeWebview> createState() => _TrybeWebviewState();
}

class _TrybeWebviewState extends State<TrybeWebview> {
  late final PlatformWebViewControllerCreationParams params;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{});
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params)
      ..loadRequest(Uri.parse(widget.url));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: widget.title != null ? Text(widget.title!) : null,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(IconsaxOutline.arrow_circle_left),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
