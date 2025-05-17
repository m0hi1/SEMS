import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sems/features/batches/bloc/batch_bloc.dart';
import 'package:sems/features/batches/batch_model.dart';

class FeesReminder extends StatefulWidget {
  const FeesReminder({super.key});

  @override
  State<FeesReminder> createState() => _FeesReminderState();
}

class _FeesReminderState extends State<FeesReminder> {
  // Get today's date formatted as "dd/MM/yyyy"
  final String todayDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  // Variable to store the selected batch
  String? selectedBatch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fees Reminders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Action for search button
            },
          ),
          TextButton(
            onPressed: () {
              // Action for SMS button
            },
            child: const Text(
              'SMS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'export_pdf') {
                // Implement Export PDF functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exporting PDF...')),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'export_pdf',
                  child: Text('Export PDF'),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Field
          TextField(
            readOnly: true, // Prevent editing
            decoration: InputDecoration(
              labelText: "As per date",
              hintText: todayDate,
              // Use UnderlineInputBorder for bottom border
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Optional: Change border color
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Batch Dropdown (custom design without underline)
          BlocBuilder<BatchBloc, BatchState>(
            builder: (context, state) {
              if (state is BatchLoading) {
                // Show loading spinner while waiting for the data
                return const Center(child: CircularProgressIndicator());
              } else if (state is BatchLoaded) {
                // Assuming 'batchName' is the correct property in BatchModel
                List<String> batchNames = state.batches.map((batch) => batch.batchName).toList();

                return GestureDetector(
                  onTap: () {
                    // Open the dropdown menu when clicked
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: const Text('Select Batch'),
                          children: batchNames.map((batch) {
                            return SimpleDialogOption(
                              onPressed: () {
                                setState(() {
                                  selectedBatch = batch;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(batch),
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedBatch ?? "All Batches",
                          style: TextStyle(
                            color: selectedBatch == null ? Colors.blue : Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.blue),
                      ],
                    ),
                  ),
                );
              } else if (state is FailureState) {
                // Handle failure state if needed
                return Center(child: Text(state.message));
              }
              return const SizedBox(); // Return empty space if no state
            },
          ),

          const Spacer(),

          // Bottom Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Total Amount:', // Example amount
                      style: TextStyle(
                        color: Color.fromRGBO(14, 41, 165, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Text(
                      '0.0', // Example amount
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Total Students:', // Example student count
                      style: TextStyle(
                        color: Color.fromRGBO(14, 41, 165, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Text(
                      '0', // Example student count
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
