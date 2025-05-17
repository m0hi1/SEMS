import 'package:flutter/material.dart';

class FeeCollectionReport extends StatefulWidget {
  const FeeCollectionReport({super.key});

  @override
  State<FeeCollectionReport> createState() => _FeeCollectionReportState();
}

class _FeeCollectionReportState extends State<FeeCollectionReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fees Collection'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'export_pdf') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exporting PDF...')),
                );
              } else if (value == 'share_pdf') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sharing PDF...')),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'export_pdf',
                  child: Text('Export PDF'),
                ),
                const PopupMenuItem<String>(
                  value: 'share_pdf',
                  child: Text('Share PDF'),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Use Filter For Desired Data and click on entry to get options',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: double.infinity,
              color: Colors.blue,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Amount: 0.0', // Example amount
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ClipRRect(
        borderRadius:
            BorderRadius.circular(50), // Customize the border radius here
        child: FloatingActionButton(
          onPressed: () {
            // Action for filter button
          },
          backgroundColor:
              const Color.fromRGBO(31, 63, 225, 1.0), // Blue background color
          child: const Icon(
            Icons.filter_alt,
            color: Colors.white, // White icon color
          ),
        ),
      ),
    );
  }
}
