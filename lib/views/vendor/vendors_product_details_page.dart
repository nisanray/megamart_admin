import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VendorProductDetailPage extends StatelessWidget {
  final String productId;

  VendorProductDetailPage({required this.productId});

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
          var imageUrl = fixedFields.firstWhere(
                (field) => field['fieldName'] == 'Product Image URL',
            orElse: () => {'value': ''},
          )['value'];

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
                  fixedFields.firstWhere(
                        (field) => field['fieldName'] == 'Product Name',
                    orElse: () => {'value': 'Unknown'},
                  )['value'],
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  fixedFields.firstWhere(
                        (field) => field['fieldName'] == 'Description',
                    orElse: () => {'value': 'Unknown'},
                  )['value'],
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                _buildTimestampInfo('Created At', product['createdAt']),
                _buildTimestampInfo('Updated At', product['updatedAt']),
                _buildTextFieldInfo('Category ID', product['categoryId']),
                _buildTextFieldInfo('Vendor ID', product['vendorId']),
                SizedBox(height: 16),
                Text('Additional Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Divider(),
                ..._buildFieldItems(fixedFields),
                SizedBox(height: 16),
                Text('Custom Fields', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Divider(),
                ..._buildFieldItems(additionalFields),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimestampInfo(String title, Timestamp? timestamp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            timestamp != null ? timestamp.toDate().toString() : 'Unknown',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldInfo(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value ?? 'Unknown',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFieldItems(List<Map<String, dynamic>> fields) {
    return fields.map((field) => _buildFieldItem(field)).toList();
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
