import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'category_products_page.dart';

class CategoryDetail extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> category;

  const CategoryDetail({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category['name']);
    _descriptionController = TextEditingController(text: widget.category['description']);
  }

  Future<void> _updateCategory() async {
    await FirebaseFirestore.instance.collection('categories').doc(widget.category.id).update({
      'name': _nameController.text,
      'description': _descriptionController.text,
    });
    Navigator.of(context).pop();
  }

  Future<void> _deleteCategory() async {
    await FirebaseFirestore.instance.collection('categories').doc(widget.category.id).delete();
    Navigator.of(context).pop();
  }

  Future<void> _confirmDeleteCategory() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Category"),
          content: Text("Are you sure you want to delete this category?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () async {
                await _deleteCategory();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Category Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Category Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: _updateCategory,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fixedFields = widget.category['fixedFields'] as List<dynamic>?;
    final additionalFields = widget.category['fields'] as List<dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category['name']),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _showEditCategoryDialog,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _confirmDeleteCategory,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (fixedFields != null) ...[
              ...fixedFields.map((field) {
                return _buildField(field['fieldName'], field['fieldType']);
              }).toList(),
            ],
            if (additionalFields != null && additionalFields.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                'Additional Fields',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...additionalFields.map((field) {
                return _buildField(field['fieldName'], field['fieldType']);
              }).toList(),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryProductsPage(category: widget.category),
                  ),
                );
              },
              child: Text('View Products'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(type),
        ],
      ),
    );
  }
}
