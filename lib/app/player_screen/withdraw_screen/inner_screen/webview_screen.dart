import 'package:flutter/material.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:protippz/app/utils/app_colors.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String? title;

  const WebViewScreen({super.key, required this.url, this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  var loadingPercentage = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
              loadingPercentage = 100;
            });
          },
          onHttpError: (error) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (error) {
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            if (request.url.contains("")) {
              print("====================${request.url}");
              _showRedirectDialog();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;

          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _showRedirectDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text(
              'Your onboarding process is complete. Click below to return to the home page.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoute.playerHomeScreen);
                // Get.offAllNamed('/home'); // Replace '/home' with your home page route
              },
              child: const Text(
                'Go to Home',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white600,
        centerTitle: true,
        title: Text(
          widget.title ?? 'Stripe',
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          if (_isLoading)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
              backgroundColor: Colors.grey[200],
              minHeight: 3,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
        ],
      ),
    );
  }
}
