import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../router.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back), // Back arrow icon
        //   onPressed: () {
        //     context.pop;
        //   },
        // ),
        title: const Text('Help'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                const email = 'smartgalaxylabs@gmail.com';
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: email,
                  query: Uri.encodeComponent(
                      'Subject: Support Request'), // Add a subject if needed
                );

                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                } else {
                  throw 'Could not launch $emailLaunchUri';
                }
              },
              child: const Text.rich(
                TextSpan(
                  text: 'contact us, at ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 4, 55, 97),
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: 'smartgalaxylabs@gmail.com',
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 55, 97),
                        decoration:
                            TextDecoration.underline, // Underline the email
                      ),
                    ),
                    TextSpan(
                      text: '\nfor more help.',
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // child: const Text(
            //   'contact us, at smartgalaxylabs@gmail.com \nfor more help.',
            //   // 'smartgalaxylabs@gmail.com',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Color.fromARGB(255, 4, 55, 97),
            //     fontSize: 16,
            //     // decoration: TextDecoration.underline,
            //   ),
            // ),
            //),
            const SizedBox(height: 20),
            const Icon(
              // Icons.whatsapp,
              Icons.chat,
              size: 50,
              color: Colors.green,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                //print(email);
                const phone =
                    '+919053169278'; // Replace with the actual phone number of company (smart galaxy lab)

                const message =
                    'SEMS\n  \nMobile:\nPlan:\nHello Developer'; // Your custom message
                final urlString =
                    'https://wa.me/$phone?text=${Uri.encodeComponent(message)}';
                final url = Uri.parse(urlString);

                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text(
                'WhatsApp Us',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tutorials',
              style: TextStyle(
                fontSize: 24,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.play_circle_filled,
                  color: Colors.red,
                  size: 40,
                ),
                title: const Text('Youtube Help Videos'),
                subtitle: const Text('Hindi Tutorials'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  const url =
                      'https://www.youtube.com/channel/UCLcz8cuHhH3jUV0DSPbT1fA/featured'; // Replace with the correct package name
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
