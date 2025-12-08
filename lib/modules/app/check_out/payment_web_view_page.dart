import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/theme/extensions/spacing_theme.dart';
import '../../../core/widgets/appbars/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/navigation/nav.dart';
import '../../../core/localization/gen/loc.dart';

class PaymentWebViewPage extends StatefulWidget {
  final String paymentUrl;
  final String callbackUrl;

  const PaymentWebViewPage({
    super.key,
    required this.paymentUrl,
    required this.callbackUrl,
  });

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late final WebViewController controller;
  bool isLoading = true;
  bool _isProcessingCallback = false;
  String? _errorMessage;
  String? orderId;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent('DriveThrough iOS App/1.0')
      ..enableZoom(false)
      ..addJavaScriptChannel(
        'PaymentStatus',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('Payment status received: ${message.message}');
          _handlePaymentStatusMessage(message.message);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('onPageStarted: $url');
            setState(() {
              isLoading = true;
              _errorMessage = null;
            });
          },
          onPageFinished: (String url) {
            debugPrint('onPageFinished: $url');
            setState(() => isLoading = false);

            // ✅ Only check for status after payment
            if (_isCallbackUrl(url) || _isStatusUrl(url)) {
              debugPrint('Final payment page detected: $url');
              _injectJavaScriptToGetPageContent();
            }
          },
          // onNavigationRequest: (NavigationRequest request) {
          //   debugPrint('onNavigationRequest: ${request.url}');
          //   if (_isCallbackUrl(request.url)) {
          //     _handlePaymentCallback(request.url);
          //   }
          //   return NavigationDecision.navigate;
          // },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
            setState(() {
              isLoading = false;
              _errorMessage = error.description;
            });
            if (error.description.contains('SSL') ||
                error.description.contains('certificate') ||
                error.description.contains('secure connection')) {
              _showSSLErrorDialog();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  void dispose() {
    controller.clearCache();
    super.dispose();
  }

  bool _isStatusUrl(String url) {
    return url.contains('/payment/etisalat/status') ||
        url.contains('/status');
  }

  void _injectJavaScriptToGetPageContent() {
    controller.runJavaScript('''
      setTimeout(function() {
        try {
          var statusElement = document.querySelector('.payment-status') ||
                             document.querySelector('[data-payment-status]') ||
                             document.getElementById('paymentStatus');

          var orderIdParam = null;
          var queryParams = new URLSearchParams(window.location.search);
          for(let key of queryParams.keys()) {
            if(key.startsWith('order_id')) {
              orderIdParam = queryParams.get(key);
              break;
            }
          }

          if (statusElement) {
            PaymentStatus.postMessage(JSON.stringify({
              success: statusElement.textContent.toLowerCase().includes('success'),
              message: statusElement.textContent,
              order_id: orderIdParam
            }));
            return;
          }

          var bodyText = document.body.innerText || document.body.textContent;
          var isSuccess = bodyText.toLowerCase().includes('success') ||
                          bodyText.toLowerCase().includes('approved') ||
                          bodyText.toLowerCase().includes('confirmed');

          PaymentStatus.postMessage(JSON.stringify({
            success: isSuccess,
            message: bodyText.substring(0, 100),
            order_id: orderIdParam
          }));
        } catch (e) {
          PaymentStatus.postMessage(JSON.stringify({
            error: "Could not parse response",
            details: e.message
          }));
        }
      }, 100);
    ''');
  }

  void _handlePaymentStatusMessage(String message) {
    if (_isProcessingCallback) return;
    _isProcessingCallback = true;

    try {
      final Map<String, dynamic> statusData = json.decode(message);
      final bool success = statusData['success'] ?? false;
      final String statusMessage = statusData['message'] ?? '';
      final String? orderId = statusData['order_id']?.toString();

      debugPrint('Payment success: $success');
      debugPrint('Payment message: $statusMessage');
      debugPrint('Order ID: $orderId');

      if (mounted) {
        Navigator.of(context).pop();
        if (success) {
          Nav.confirmPaymentPage.push(context);
        } else {
          _showPaymentError(statusMessage);
        }
      }
    } catch (e) {
      debugPrint('Error parsing payment status: $e');
      _showPaymentError('Payment verification failed');
    }
  }

  bool _isCallbackUrl(String url) {
    if (widget.callbackUrl.isEmpty) return false;
    try {
      return url.contains('/payment/callback/') ||
          url.toLowerCase().contains(widget.callbackUrl.toLowerCase());
    } catch (e) {
      debugPrint('Error parsing callback URL: $e');
      return false;
    }
  }

  // void _handlePaymentCallback(String callbackUrl) {
  //   if (_isProcessingCallback) return;
  //   try {
  //     Uri uri = Uri.parse(callbackUrl);
  //     print('_PaymentWebViewPageState._handlePaymentCallback ${uri.queryParameters}');
  //     print('_PaymentWebViewPageState._handlePaymentCallback ${uri.query}');
  //     orderId = uri.queryParameters['order_id'];
  //
  //     debugPrint('Callback detected: $callbackUrl | OrderID: $orderId');
  //
  //     // ✅ Parse payment result only at callback
  //     _injectJavaScriptToGetPageContent();
  //   } catch (e) {
  //     debugPrint('Payment callback error: $e');
  //     _showPaymentError('Payment verification failed: $e');
  //   }
  // }

  void _showPaymentError(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Try Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Nav.root.replaceAll(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showSSLErrorDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connection Error'),
        content: const Text('Unable to establish a secure connection to the payment server. Please check your internet connection and try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              controller.loadRequest(Uri.parse(widget.paymentUrl));
            },
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: Text(Loc.of(context).payment),
      ),
      body: Padding(
        padding: SpacingTheme.of(context).pagePadding,
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (isLoading)
              Container(
                color: Colors.white,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Processing payment...'),
                    ],
                  ),
                ),
              ),
            if (_errorMessage != null && !isLoading)
              Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      const Text('Connection Error', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(_errorMessage!, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _errorMessage = null;
                            isLoading = true;
                          });
                          controller.loadRequest(Uri.parse(widget.paymentUrl));
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
