import 'package:bhumibd/app/resource/widget/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  final String url;
  final JavaScriptMode javaScriptMode;

  final bool? isShowAppBar;

  const CustomWebView({
    super.key,
    required this.url,
    this.javaScriptMode = JavaScriptMode.unrestricted,
    this.isShowAppBar = false
  });

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(widget.javaScriptMode)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => isLoading = true),
          onPageFinished: (_) => setState(() => isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: widget.isShowAppBar ==true? AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.green,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24) ,
          ),
          automaticallyImplyLeading: true,
        ) : null,
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              Center(
                child: CustomLoader(),
              ),
          ],
        ),
      ),
    );
  }
}
