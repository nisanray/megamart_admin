import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CategoryAdd extends StatefulWidget {
  @override
  _CategoryAddState createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _categoryImage;
  String? _categoryImageUrl;
  String? _productImageUrl;

  List<Map<String, dynamic>> fields = [];
  List<Map<String, dynamic>> fixedFields = [];

  @override
  void initState() {
    super.initState();
    fixedFields = [
      {'fieldName': 'Product Name', 'fieldType': 'text'},
      {'fieldName': 'Description', 'fieldType': 'text'},
      {'fieldName': 'Regular Price', 'fieldType': 'number'},
      {'fieldName': 'Offer Price', 'fieldType': 'number'},
      {'fieldName': 'Stock', 'fieldType': 'number'},
      {'fieldName': 'Dimensions (L x W x H)', 'fieldType': 'text'},
      {'fieldName': 'Weight', 'fieldType': 'number'},
      {'fieldName': 'Manufacturer Name', 'fieldType': 'text'},
      {'fieldName': 'Manufacturer Address', 'fieldType': 'text'},
      {'fieldName': 'Manufacturer Contact Number', 'fieldType': 'text'},
      {'fieldName': 'Shipping Available Regions', 'fieldType': 'text'},
      {'fieldName': 'Estimated Delivery Time', 'fieldType': 'text'},
      {'fieldName': 'Product Image URL', 'fieldType': 'text'},
    ];
  }

  Future<void> _pickCategoryImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _categoryImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadCategoryImage() async {
    if (_categoryImage == null) return;
    final storageRef = FirebaseStorage.instance.ref().child('category_images/${DateTime.now().toIso8601String()}.jpg');
    final uploadTask = storageRef.putFile(_categoryImage!);

    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      _categoryImageUrl = downloadUrl;
    });
  }

  void _addField() {
    setState(() {
      fields.add({
        'fieldName': '',
        'fieldType': 'text',
      });
    });
  }

  void _saveCategory() async {
    if (_categoryImage != null) {
      await _uploadCategoryImage();
    }

    // Adding category with fixed fields and additional fields
    await FirebaseFirestore.instance.collection('categories').add({
      'name': _nameController.text,
      'description': _descriptionController.text,
      'categoryImageUrl': _categoryImageUrl,
      'productImageUrl': _productImageUrl,
      'fields': fields.map((field) {
        return {
          'fieldName': field['fieldName'],
          'fieldType': field['fieldType'],
        };
      }).toList(),
      'fixedFields': fixedFields.map((field) {
        return {
          'fieldName': field['fieldName'],
          'fieldType': field['fieldType'],
        };
      }).toList(),
    });

    Navigator.of(context).pop();
  }

  Widget _buildFieldItem(Map<String, dynamic> field, int index) {
    return Column(
      children: [
        TextFormField(
          onChanged: (value) {
            fields[index]['fieldName'] = value;
          },
          decoration: InputDecoration(labelText: 'Field Name'),
        ),
        DropdownButton<String>(
          value: field['fieldType'],
          onChanged: (String? newValue) {
            setState(() {
              fields[index]['fieldType'] = newValue!;
            });
          },
          items: <String>['text', 'number', 'dropdown', 'date']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildFixedFieldItem(Map<String, dynamic> field) {
    return TextFormField(
      initialValue: field['fieldName'],
      decoration: InputDecoration(labelText: field['fieldName']),
      readOnly: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Category Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Category Description'),
            ),
            SizedBox(height: 20),
            if (_categoryImage != null)
              Image.file(
                _categoryImage!,
                height: 200,
              ),
            ElevatedButton(
              onPressed: _pickCategoryImage,
              child: Text('Pick Category Image'),
            ),
            SizedBox(height: 20),
            Text('Fixed Fields', style: TextStyle(fontWeight: FontWeight.bold)),
            ...fixedFields.map((field) => _buildFixedFieldItem(field)).toList(),
            SizedBox(height: 20),
            Text('Fields', style: TextStyle(fontWeight: FontWeight.bold)),
            ...fields.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> field = entry.value;
              return _buildFieldItem(field, index);
            }).toList(),
            ElevatedButton(
              onPressed: _addField,
              child: Text('Add Field'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveCategory,
              child: Text('Save Category'),
            ),
          ],
        ),
      ),
    );
  }
}
