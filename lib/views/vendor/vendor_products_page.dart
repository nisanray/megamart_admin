import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:megamart_admin/views/vendor/vendors_product_details_page.dart';
// import 'vendor_product_detail_page.dart';

class VendorProductsPage extends StatelessWidget {
  final String vendorId;

  VendorProductsPage({required this.vendorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Products'),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').where('vendorId', isEqualTo: vendorId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products added by this vendor.'));
          }

          var products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              var fixedFields = List<Map<String, dynamic>>.from(product['fixedFields']);
              var productName = fixedFields.firstWhere(
                    (field) => field['fieldName'] == 'Product Name',
                orElse: () => {'value': 'Unknown'},
              )['value'];
              var productDescription = fixedFields.firstWhere(
                    (field) => field['fieldName'] == 'Description',
                orElse: () => {'value': 'Unknown'},
              )['value'];
              var productImageUrl = fixedFields.firstWhere(
                    (field) => field['fieldName'] == 'Product Image URL',
                orElse: () => {'value': ''},
              )['value'];

              return ListTile(
                leading: productImageUrl.isNotEmpty
                    ? Image.network(productImageUrl, width: 50, height: 50, fit: BoxFit.cover)
                    : Container(width: 50, height: 50, color: Colors.grey),
                title: Text(productName),
                subtitle: Text(productDescription),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VendorProductDetailPage(productId: product.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
