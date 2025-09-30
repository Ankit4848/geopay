import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:geopay/core/core.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final Function(bool isSuccess, String? message)? onPaymentComplete;

  const PaymentWebViewScreen({
    Key? key,
    required this.paymentUrl,
    this.onPaymentComplete,
  }) : super(key: key);

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController controller;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
            setState(() {
              isLoading = true;
              errorMessage = null;
            });
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            setState(() {
              isLoading = false;
            });
            _checkPaymentStatus(url);
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.description}');
            setState(() {
              isLoading = false;
              errorMessage = 'Failed to load payment page: ${error.description}';
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            print('Navigation request: ${request.url}');
            _checkPaymentStatus(request.url);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _checkPaymentStatus(String url) {
    print('Checking payment status for URL: $url');
    
    // Check for success: status=AUTHORISED
    if (_isPaymentSuccess(url)) {
      _handlePaymentSuccess(url);
    }
    // Check for failure: any other status from your domain
    else if (_isPaymentFailure(url)) {
      _handlePaymentFailure(url);
    }
  }

  bool _isPaymentSuccess(String url) {
    // Only success when status=AUTHORISED
    return url.contains('status=AUTHORISED') || url.contains('status=AUTHORIZED');
  }

  bool _isPaymentFailure(String url) {
    // Any callback from your domain that is NOT authorized
    bool isYourCallback = url.contains('geo.travelieons.com/deposit/payment');
    bool isNotAuthorized = !url.contains('status=AUTHORISED') && !url.contains('status=AUTHORIZED');
    
    return isYourCallback && isNotAuthorized;
  }

  void _handlePaymentSuccess(String url) {
    print('✅ Payment AUTHORISED detected: $url');
    
    // Extract transaction details if available
    String? transactionId = _extractTransactionId(url);
    String? amount = _extractAmount(url);
    
    String successMessage = 'Your payment was authorized. It will be reviewed shortly and the final status (approved/rejected) will be updated. You can check your transaction list for the latest update';
    if (transactionId != null) {
      successMessage += '\\nTransaction ID: $transactionId';
    }
    if (amount != null) {
      successMessage += '\\nAmount: $amount';
    }

    // Auto-close WebView and return success
    widget.onPaymentComplete?.call(true, successMessage);
    Get.back(result: {'success': true, 'message': successMessage});
  }

  void _handlePaymentFailure(String url) {
    print('❌ Payment FAILED detected: $url');
    
    // Extract status for better error message
    String? status = _extractStatus(url);
    String failureMessage = 'Your payment attempt failed.';
    
    if (status != null && status.isNotEmpty) {
      failureMessage += ' (Status: $status)';
    } else {
      failureMessage += 'Please try again or use a different payment method';
    }

    // Auto-close WebView and return failure
    widget.onPaymentComplete?.call(false, failureMessage);
    Get.back(result: {'success': false, 'message': failureMessage});
  }

  String? _extractTransactionId(String url) {
    // Try different parameter names for transaction ID
    for (String param in ['transaction_id', 'txn_id', 'id', 'reference', 'ref']) {
      RegExp regExp = RegExp('$param=([^&]+)');
      Match? match = regExp.firstMatch(url);
      if (match != null) {
        return Uri.decodeComponent(match.group(1)!);
      }
    }
    return null;
  }

  String? _extractAmount(String url) {
    // Try different parameter names for amount
    for (String param in ['amount', 'total', 'value', 'sum']) {
      RegExp regExp = RegExp('$param=([^&]+)');
      Match? match = regExp.firstMatch(url);
      if (match != null) {
        return Uri.decodeComponent(match.group(1)!);
      }
    }
    return null;
  }

  String? _extractStatus(String url) {
    // Extract status parameter
    RegExp regExp = RegExp('status=([^&]+)');
    Match? match = regExp.firstMatch(url);
    if (match != null) {
      return Uri.decodeComponent(match.group(1)!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      appBar: AppBar(
        backgroundColor: VariableUtilities.theme.primaryColor,
        title: Text(
          'Payment',
          style: FontUtilities.style(
            fontSize: 18,
            fontWeight: FWT.semiBold,
            fontColor: VariableUtilities.theme.whiteColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: VariableUtilities.theme.whiteColor,
          ),
          onPressed: () {
            _showCancelConfirmation();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: VariableUtilities.theme.whiteColor,
            ),
            onPressed: () {
              controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Loading payment page...',
                      style: FontUtilities.style(
                        fontSize: 16,
                        fontWeight: FWT.medium,
                        fontColor: VariableUtilities.theme.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (errorMessage != null)
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Payment Error',
                      style: FontUtilities.style(
                        fontSize: 20,
                        fontWeight: FWT.bold,
                        fontColor: Colors.red.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: FontUtilities.style(
                          fontSize: 14,
                          fontWeight: FWT.medium,
                          fontColor: VariableUtilities.theme.blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          errorMessage = null;
                        });
                        controller.reload();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VariableUtilities.theme.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showCancelConfirmation() {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Payment'),
        content: const Text('Are you sure you want to cancel the payment?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              widget.onPaymentComplete?.call(false, 'Payment cancelled by user');
              Get.back(result: {'success': false, 'message': 'Payment cancelled by user'});
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
