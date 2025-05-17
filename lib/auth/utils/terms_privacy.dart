import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndPrivacyWidget extends StatelessWidget {
  // URLs for Privacy Policy and Terms of Services
  final String privacyPolicyUrl;
  final String termsOfServiceUrl;
  final Color textColor;
  final Color linkColor;

  const TermsAndPrivacyWidget({
    super.key,
    required this.privacyPolicyUrl,
    required this.termsOfServiceUrl,
    this.textColor = Colors.white,
    this.linkColor = Colors.blue,
  });

  // Function to open URLs
  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "By signing up you accept our ",
            style: TextStyle(color: textColor),
          ),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(
              color: linkColor,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL(privacyPolicyUrl);
              },
          ),
          TextSpan(
            text: " and ",
            style: TextStyle(color: textColor),
          ),
          TextSpan(
            text: "Terms of Services",
            style: TextStyle(
              color: linkColor,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL(termsOfServiceUrl);
              },
          ),
        ],
      ),
    );
  }
}
