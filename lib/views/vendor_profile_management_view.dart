import 'package:flutter/material.dart';
import 'vendor/vendor_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class VendorProfileManagementView extends StatelessWidget {
  static const String routeName = '\VendorProfileManagementView';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('vendors')
          .where('profile.approved', isEqualTo: 'approved')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final vendors = snapshot.data!.docs;

        return ListView.builder(
          itemCount: vendors.length,
          itemBuilder: (context, index) {
            var vendor = vendors[index];
            return ListTile(
              title: Text(vendor['name']),
              subtitle: Text(vendor['email']),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VendorDetail(vendorId: vendor.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

