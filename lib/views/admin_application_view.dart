import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:megamart_admin/views/vendro_details_screen.dart';
// import 'vendor_detail_screen.dart';

class ApplicationListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Applications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('vendors').where('pendingApproval', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var applications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              var vendor = applications[index];
              return ListTile(
                title: Text(vendor['name']),
                subtitle: Text(vendor['businessName']),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => VendorDetailScreen(vendorId: vendor.id),
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
