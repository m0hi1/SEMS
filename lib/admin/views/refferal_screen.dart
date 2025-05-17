import 'package:sems/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back), // Back arrow icon
        //   onPressed: () {
        //     context.go(AppRoute.adminHome.path);
        //   },
        // ),
        title: const Text('TCMS'),
      ),
      body: SingleChildScrollView(
        // Allows the content to scroll
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: screenWidth * 0.15, // Responsive radius
                backgroundColor: Colors.blue,
                child: const Icon(Icons.card_giftcard,
                    size: 50, color: Colors.white),
              ),
              SizedBox(height: screenHeight * 0.03), // Responsive height
              Text(
                'Get Free Subscription Days',
                style: TextStyle(
                  fontSize: screenWidth * 0.05, // Responsive font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive height
              Text(
                'Get 10% free days for each friend\'s subscription plan who pays with your referral code. They get 5% off too!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: screenWidth * 0.04), // Responsive font size
              ),
              SizedBox(height: screenHeight * 0.03), // Responsive height
              SelectableText(
                '21aac9b429',
                style: TextStyle(
                  fontSize: screenWidth * 0.05, // Responsive font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // Responsive height
              ElevatedButton(
                onPressed: () {
                  // Copy referral code to clipboard
                  Clipboard.setData(const ClipboardData(text: '21aac9b429'))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Referral code copied to clipboard!')),
                    );
                  });
                },
                child: const Text('COPY'),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive height
              ElevatedButton(
                onPressed: () {
                  // Implement share functionality here
                  Share.share(
                      'Check out this referral code: 21aac9b429'); // Sharing the referral code
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                ),
                child: const Text('SHARE REFERRAL CODE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
