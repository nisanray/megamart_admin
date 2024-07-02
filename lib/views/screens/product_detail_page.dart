import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fixedFields = List<Map<String, dynamic>>.from(product['fixedFields']);
    var additionalFields = List<Map<String, dynamic>>.from(product['fields']);
    var productImageUrl = fixedFields.firstWhere((field) => field['fieldName'] == 'Product Image URL')['value'];
    var vendorId = product['vendorId'];
    var createdAt = product['createdAt'] as Timestamp;
    var updatedAt = product['updatedAt'] as Timestamp;

    return Scaffold(
      appBar: AppBar(
        title: Text(fixedFields.firstWhere((field) => field['fieldName'] == 'Product Name')['value']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (productImageUrl.isNotEmpty)
              Image.network(productImageUrl, height: 200),
            SizedBox(height: 20),
            Text('Product Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...fixedFields.map((field) => _buildField(field)),
            SizedBox(height: 20),
            if (additionalFields.isNotEmpty) ...[
              Text('Additional Fields', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...additionalFields.map((field) => _buildField(field)),
              SizedBox(height: 20),
            ],
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('vendors').doc(vendorId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error loading vendor info');
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text('Vendor not found');
                }

                var vendorData = snapshot.data!.data() as Map<String, dynamic>;
                var vendorName = vendorData['name'] ?? 'Unknown';
                var storeName = vendorData['storeName'] ?? 'Unknown';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Vendor: $vendorName', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Store: $storeName'),
                    Text('Created At: ${createdAt.toDate()}'),
                    Text('Updated At: ${updatedAt.toDate()}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(Map<String, dynamic> field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field['fieldName'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(field['value']),
        ],
      ),
    );
  }
}
