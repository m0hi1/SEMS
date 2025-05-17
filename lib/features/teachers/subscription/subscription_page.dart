import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sems/admin/utils/admin_drawer.dart';

import '../../../profile/cubit/profile_cubit.dart';
import '../../../profile/cubit/profile_cubit.dart';
import 'subscription_details.dart';

class SubscriptionList extends StatelessWidget {
  final List<Map<String, dynamic>> subscriptions = [
    {'durationText': 'Three Months', 'durationNumeric': 3, 'amount': 9000},
    {'durationText': 'Six Months', 'durationNumeric': 6, 'amount': 18000},
    {'durationText': 'One Year', 'durationNumeric': 12, 'amount': 36000},
    {'durationText': 'Three Years', 'durationNumeric': 36, 'amount': 108000},
    {'durationText': 'Five Years', 'durationNumeric': 60, 'amount': 180000},
  ];

  SubscriptionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text('Select Subscription'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: subscriptions.length,
          itemBuilder: (context, index) {
            final subscription = subscriptions[index];
            return SubscriptionCard(subscription: subscription);
          },
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final Map<String, dynamic> subscription;

  const SubscriptionCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    final sems = context.watch<FirestoreDataCubit>().getUserData();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      color: Colors.white,
      child: ListTile(
        title: Text(
          subscription['durationText'],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 25, color: Color(0xFF49C1E6)),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoRow(
                    label: 'Duration(Months):',
                    value: '${subscription['durationNumeric']}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoRow(
                    label: 'Amount(INR):',
                    value: '₹${subscription['amount']} /-'),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubscriptionDetails(
                username: sems?.name ?? '',
                durationText: subscription['durationText'],
                durationNumeric: subscription['durationNumeric'],
                amount: subscription['amount'],
                mobileNo: '',
                emailId: sems?.email ?? '',
              ),
            ),
          );
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label ',
          style: const TextStyle(
              fontSize: 18, color: Color.fromARGB(255, 36, 66, 122)),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
