import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AppInstallPreviewBottomSheet extends StatefulWidget {
  final String packageName;

  const AppInstallPreviewBottomSheet({super.key, required this.packageName});

  @override
  State<AppInstallPreviewBottomSheet> createState() =>
      _AppInstallPreviewBottomSheetState();
}

class _AppInstallPreviewBottomSheetState
    extends State<AppInstallPreviewBottomSheet> with WidgetsBindingObserver {
  static const platform = MethodChannel('native_helper');
  late InAppWebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Detect if user comes back from Play Store
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Navigator.of(context).pop();
      Future.delayed(const Duration(milliseconds: 300), () {
        //  _showInstalledDialog();
      });
    }
  }

  void _showInstalledDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("App Installed?"),
        content: const Text("Did you install the app from Play Store?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Great! Proceed further.")),
              );
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  Future<void> _openPlayStoreOverlay(String packageName) async {
    try {
      await platform.invokeMethod('openPlayStore', {
        'packageName': packageName,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to open Play Store: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final playStoreUrl = widget.packageName;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(playStoreUrl)),
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
                    await _openPlayStoreOverlay(pkg);
                  }
                  return NavigationActionPolicy.CANCEL;
                }

                return NavigationActionPolicy.ALLOW;
              },
            ),
          ),
        ],
      ),
    );
  }
}
