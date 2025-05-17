// lib/screens/study_materials_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StudyMaterialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Materials'),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Search and Filter Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search materials...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: (value) {
                          // Implement search logic
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        // Implement filter logic
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Materials List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('study_materials')
                    .orderBy('uploadedAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No materials available'));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      final uploadedAt =
                          (data['uploadedAt'] as Timestamp?)?.toDate();

                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.book, color: Colors.blue),
                          ),
                          title: Text(
                            data['title'] ?? 'Untitled',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Subject: ${data['subject'] ?? 'N/A'}'),
                              Text(
                                  'Uploaded on: ${uploadedAt != null ? DateFormat('yyyy-MM-dd').format(uploadedAt) : 'N/A'}'),
                            ],
                          ),
                          // Inside StudyMaterialsScreen widget
                          trailing: IconButton(
                            icon: Icon(Icons.download),
                            onPressed: () async {
                              try {
                                // Assuming each material has a fileUrl in the data
                                final String fileUrl = data['fileUrl'];
                                if (fileUrl != null && fileUrl.isNotEmpty) {
                                  // Show download progress indicator
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Downloading material...')),
                                  );

                                  // Implement your download logic here
                                  // You might want to use packages like dio or flutter_downloader
                                  // Example:
                                  // await downloadFile(fileUrl);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Download complete!')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Download URL not available')),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Error downloading material: $e')),
                                );
                              }
                            },
                          ),
                          onTap: () {
                            // Navigate to material details screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MaterialDetailsScreen(
                                  materialData:
                                      data, // Pass the material data to details screen
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> materialData;

  MaterialDetailsScreen({required this.materialData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${materialData['title'] ?? 'N/A'}'),
            Text('Subject: ${materialData['subject'] ?? 'N/A'}'),
            Text('Uploaded on: ${materialData['uploadedAt'] ?? 'N/A'}'),
            SizedBox(height: 16),
            Text('Description: ${materialData['description'] ?? 'N/A'}'),
            // Add more material details as needed
          ],
        ),
      ),
    );
  }
}
