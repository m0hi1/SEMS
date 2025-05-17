import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'subscription_page.dart';

class SubscriptionDetails extends StatefulWidget {
  final String durationText;
  final int durationNumeric;
  final int amount;
  final String username;
  final String mobileNo;
  final String emailId;

  const SubscriptionDetails({
    super.key,
    required this.durationText,
    required this.durationNumeric,
    required this.amount,
    required this.username,
    required this.mobileNo,
    required this.emailId,
  });

  @override
  _SubscriptionDetailsState createState() => _SubscriptionDetailsState();
}

class _SubscriptionDetailsState extends State<SubscriptionDetails> {
  late Razorpay _razorpay;
  final TextEditingController referralCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(
      PaymentSuccessResponse response, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Successful: ${response.paymentId}"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handlePaymentError(
      PaymentFailureResponse response, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Failed: ${response.code} | ${response.message}"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleExternalWallet(
      ExternalWalletResponse response, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("External Wallet Selected: ${response.walletName}"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': widget.amount * 100,
      'name': widget.username,
      'description': 'Subscription Payment',
      'prefill': {
        'contact': widget.mobileNo,
        'email': widget.emailId,
      },
      'external': {
        'wallets': ['paytm'],
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoRow(label: 'Username:', value: widget.username),
              const SizedBox(height: 10),
              InfoRow(label: 'Mobile No:', value: widget.mobileNo),
              const SizedBox(height: 10),
              InfoRow(label: 'Email ID:', value: widget.emailId),
              const SizedBox(height: 20),
              InfoRow(label: 'Subscription:', value: widget.durationText),
              const SizedBox(height: 10),
              InfoRow(label: 'Amount (INR):', value: '₹${widget.amount} /-'),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: referralCodeController,
                      decoration: const InputDecoration(
                        labelText: 'Referral Code',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      String referralCode = referralCodeController.text;
                      print('Applying referral code: $referralCode');
                      // Add logic to apply referral code
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Apply'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _openCheckout, // Initiates payment on click
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Purchase'),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "100% secure payment powered by Razorpay",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                  "assets/images/payment_options.png"), // Payment options image
            ],
          ),
        ),
      ),
    );
  }
}
