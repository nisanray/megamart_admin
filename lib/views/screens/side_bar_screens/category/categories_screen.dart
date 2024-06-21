import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:megamart_admin/utils/colors.dart';
import 'package:megamart_admin/utils/custom_text_form_field.dart';
import '../../../../utils/button_styles/button_styles.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);
  static const String routeName = '/categoryScreen';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Uint8List? _image;
  String? fileName;
  late String categoryName;

  bool _uploading = false;
  double _uploadProgress = 0.0;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
      print("Image selected: $fileName");
      print("Image bytes length: ${_image?.length}");
    } else {
      print("No image selected.");
    }
  }

  Future<String> _uploadCategoryBannerToStorage(Uint8List imageBytes) async {
    Reference ref = _storage.ref().child('categoryImages').child(fileName!);

    String contentType;
    if (fileName!.toLowerCase().endsWith('.jpg') || fileName!.toLowerCase().endsWith('.jpeg')) {
      contentType = 'image/jpeg';
    } else if (fileName!.toLowerCase().endsWith('.png')) {
      contentType = 'image/png';
    } else {
      throw 'Unsupported file type';
    }

    UploadTask uploadTask = ref.putData(imageBytes, SettableMetadata(contentType: contentType));

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      setState(() {
        _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
      });
    });

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadCategoryName() async {
    print("Validating form...");
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a category image')),
        );
        return;
      }

      setState(() {
        _uploading = true;
      });

      try {
        print("Uploading image...");
        String imageUrl = await _uploadCategoryBannerToStorage(_image!);
        await _firestore.collection('categories').doc(fileName).set({
          'image': imageUrl,
          'categoryName': categoryName,
        }).then((_) {
          setState(() {
            _image = null;
            _uploading = false;
            _uploadProgress = 0.0;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image uploaded successfully')),
          );
        });
      } catch (e) {
        setState(() {
          _uploading = false;
          _uploadProgress = 0.0;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxImageWidth = MediaQuery.of(context).size.width * 0.5;

    return Container(
      color: AppColors.backgroundColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
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
                        ? Image.memory(
                      _image!,
                      fit: BoxFit.scaleDown,
                      width: maxImageWidth,
                    )
                        : Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(child: Text("Category")),
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
              SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade100,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(fileName ?? ""),
                  ),
                ),
              ),
              SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: CustomTextFormField(
                  onChanged: (value) {
                    categoryName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Category name needed.";
                    } else {
                      return null;
                    }
                  },
                  key: Key('category'),
                  labelText: 'Category',
                  hintText: 'Enter category name',
                  prefixIcon: Icons.category_rounded,
                  controller: TextEditingController(),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 15,bottom: 30,left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.deepPurple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                'Pick an Image',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: uploadCategoryName,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                'Save Category',
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
