import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io'; // Required to use File for loading image from file path.

import 'package:megamart_admin/utils/colors.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = '/UploadBannerScreen';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? _image; // Using File for storing image path
  String? fileName;

  bool _uploading = false;
  double _uploadProgress = 0.0;

  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, type: FileType.image);
    if (result != null) {
      setState(() {
        _image = File(result.files.first.path!); // Use File to get the path
        fileName = result.files.first.name; // Get the file name
      });
    }
  }

  _uploadBannerToStorage(File image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);

    String contentType;
    if (fileName!.toLowerCase().endsWith('.jpg') ||
        fileName!.toLowerCase().endsWith('.jpeg')) {
      contentType = 'image/jpeg';
    } else if (fileName!.toLowerCase().endsWith('.png')) {
      contentType = 'image/png';
    } else {
      throw 'Unsupported file type';
    }

    UploadTask uploadTask = ref.putFile(image, SettableMetadata(contentType: contentType));
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      setState(() {
        _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
      });
    });

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _uploadImageToFirestore() async {
    if (_image != null) {
      EasyLoading.show();
      try {
        String? imageUrl = await _uploadBannerToStorage(_image!);
        if (imageUrl != null) {
          await _firestore.collection('banners').doc(fileName).set({
            'image': imageUrl,
            'fileName': fileName,
          }).whenComplete(() {
            EasyLoading.dismiss();
            setState(() {
              _image = null;
              fileName = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Image uploaded successfully')));
          });
        } else {
          throw 'Failed to get image URL';
        }
      } catch (e) {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload image: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please pick an image first')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxImageWidth = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Banner'),
        backgroundColor: AppColors.buttonColor,
      ),
      body: Container(
        color: AppColors.backgroundColor,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(color: Color(0xff879fff)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _image != null
                        ? Image.file(
                      _image!,
                      fit: BoxFit.contain,
                      width: maxImageWidth,
                    )
                        : Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(child: Text("Banner")),
                    ),
                  ),
                  if (_uploading)
                    Container(
                      width: 150,
                      height: 150,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF5EE),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: _uploadProgress,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Uploading... ${(100 * _uploadProgress).toStringAsFixed(2)}%',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade100,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      fileName ?? "No file chosen", // Display file name or fallback
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                'Pick a banner',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: _uploadImageToFirestore,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                'Upload image',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
