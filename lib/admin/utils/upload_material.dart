import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

class UploadMaterialScreen extends StatefulWidget {
  @override
  _UploadMaterialScreenState createState() => _UploadMaterialScreenState();
}

class _UploadMaterialScreenState extends State<UploadMaterialScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _selectedFile;
  final _subjectController = TextEditingController();

  bool _isUploading = false;

  List<String> subjects = [
    'Mathematics',
    'Science',
    'English',
    'History',
    'Geography'
  ];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'jpg',
        'jpeg',
        'png',
        'txt',
        'ppt',
        'pptx',
        'xls',
        'xlsx'
      ],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadMaterial() async {
    if (_formKey.currentState!.validate() && _selectedFile != null) {
      try {
        setState(() {
          _isUploading = true;
        });

        // Upload file to Firebase Storage
        final fileName = path.basename(_selectedFile!.path);
        final destination = 'study_materials/$fileName';

        final ref = FirebaseStorage.instance.ref().child(destination);
        final uploadTask = ref.putFile(_selectedFile!);

        final snapshot = await uploadTask.whenComplete(() {});
        final fileUrl = await snapshot.ref.getDownloadURL();

        // Save material metadata to Firestore
        await FirebaseFirestore.instance.collection('study_materials').add({
          'title': _titleController.text,
          'description': _descriptionController.text,
          'subject': _subjectController.text,
          'fileUrl': fileUrl,
          'fileName': fileName,
          'uploadedAt': FieldValue.serverTimestamp(),
          'uploadedBy': FirebaseAuth.instance.currentUser?.uid,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Material uploaded successfully')),
        );

        // Clear form
        _titleController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedFile = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading material: $e')),
        );
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Study Material'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a subject';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pickFile,
                    child: Text(_selectedFile != null
                        ? 'File Selected: ${path.basename(_selectedFile!.path)}'
                        : 'Select File'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: _isUploading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Upload Material'),
                    onPressed: _isUploading ? null : _uploadMaterial,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isUploading)
            Container(
              color: Colors.black26,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
