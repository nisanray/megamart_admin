import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryDetail extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> category;

  const CategoryDetail({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fixedFields = category['fixedFields'] as List<dynamic>?;
    final additionalFields = category['fields'] as List<dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(category['name']),
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
