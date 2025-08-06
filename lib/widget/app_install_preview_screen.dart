import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AppInstallPreviewScreen extends StatefulWidget {
  final String packageName;

  const AppInstallPreviewScreen({super.key, required this.packageName});

  @override
  State<AppInstallPreviewScreen> createState() =>
      _AppInstallPreviewScreenState();
}

class _AppInstallPreviewScreenState extends State<AppInstallPreviewScreen> {
  late InAppWebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    final String playStoreUrl = widget.packageName;

    return Scaffold(
        appBar: AppBar(
          title: const Text("App Preview"),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(widget.packageName),
          ),
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final uri = navigationAction.request.url;

            if (uri.toString().startsWith("intent://")) {
              final actualUrl = Uri.decodeFull(uri.toString());
              final match = RegExp(r'id=([^&]+)').firstMatch(actualUrl);
              final pkg = match?.group(1);

              if (pkg != null) {
                // open native Play Store overlay or app
                //  NativeInstallHelper.openPlayStore(pkg);
              }
              return NavigationActionPolicy.CANCEL;
            }

            return NavigationActionPolicy.ALLOW;
          },
        ));
  }
}
