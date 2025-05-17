import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';

class About extends StatelessWidget {
  const About({super.key});

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
        title: const Text("About SEMS"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/logo/sems_logo.png',
                height: 100,
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                "Smart Education",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Subtitle
              const Text(
                "Management System",
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              // Version Info
              const Text(
                "Version : 1.2.00",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Powered by
              const Text(
                "Powered by SmartGalaxy Labs",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Links
              GestureDetector(
                onTap: () {
                  // Handle Privacy Policy tap
                },
                child: const Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Handle Warranty tap
                },
                child: const Text(
                  "Warranty",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    //decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Disclaimer Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Prevention against any defects or cause of data loss or damage. Please backup your data time to time",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDisclaimerDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12)),
                  child: const Text("DISCLAIMER"),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDisclaimerDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12)),
                  child: const Text("DATA DELETION REQUEST"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDisclaimerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                8.0), // Rounded corners for the whole dialog
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(top: 20), // Margin from the top
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 20, 64, 99),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(8.0), // Rounded top corners
                  //   topRight: Radius.circular(20.0),
                  // ),
                ),
                padding: const EdgeInsets.all(15),
                child: const Center(
                  child: Text(
                    'DISCLAIMER',
                    style: TextStyle(
                      color: Colors.white, // White text color
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListBody(
                    children: <Widget>[
                      const Text(
                        'Following permissions are required for proper functioning of app:\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                          '1. Read Profile Permission: To get email id for the registration of user account.'),
                      const Text(
                          '2. Get Account Permission: To auto-complete the email text field in the login.'),
                      const Text(
                          '3. Send SMS Permission: To send SMS to students and parents.'),
                      const Text(
                          '4. Read and Write External Storage Permission: To store app data and exported files on SD-Card.'),
                      const Text(
                          '5. Call Permission: To call students and parents directly from app.'),
                      const Text(
                          '6. Internet Connection Permission: For registration of user and check app notification.'),
                      const Text(
                          '7. Camera Permission: To take student pictures for profile.'),
                      const Text(
                          '8. RECEIVE BOOT COMPLETED Permission: To set alarms of different alerts in Batch Time, Fees Alert, Expense Alert etc.'),
                      const Text(
                          '9. Integrated Payment gateway for purchase subscription plans.\n'),
                      const Text(
                        'We do not treat this data as personal or sensitive data subject to the Privacy Policy.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                          'Press Accept to allow all these permissions.'),
                      GestureDetector(
                        onTap: () {
                          // Handle Privacy Policy tap
                        },
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextButton(
                  child: const Text(
                    'ACCEPT',
                    textAlign: TextAlign.right,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Handle permission acceptance logic
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
