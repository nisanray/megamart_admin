import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  ProductDetailPage({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('products').doc(productId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var product = snapshot.data!.data() as Map<String, dynamic>;
          var fixedFields = List<Map<String, dynamic>>.from(product['fixedFields']);
          var additionalFields = List<Map<String, dynamic>>.from(product['fields']);
          var imageUrl = fixedFields.firstWhere((field) => field['fieldName'] == 'Product Image URL')['value'];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  fixedFields.firstWhere((field) => field['fieldName'] == 'Product Name')['value'],
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  fixedFields.firstWhere((field) => field['fieldName'] == 'Product Description')['value'],
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text('Additional Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Divider(),
                ...additionalFields.map((field) => _buildFieldItem(field)).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFieldItem(Map<String, dynamic> field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field['fieldName'],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            field['value'],
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
