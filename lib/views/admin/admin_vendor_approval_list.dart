import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminApproval extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _approveVendor(String uid) async {
    await _firestore.collection('vendors').doc(uid).update({
      'approved': true,
      'pendingApproval': false,
    });
  }

  Future<void> _rejectVendor(String uid) async {
    await _firestore.collection('vendors').doc(uid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Approval'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('vendors').where('pendingApproval', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No pending approvals.'));
          }

          final vendors = snapshot.data!.docs;

          return ListView.builder(
            itemCount: vendors.length,
            itemBuilder: (context, index) {
              final vendor = vendors[index];
              return ListTile(
                title: Text(vendor['businessName']),
                subtitle: Text(vendor['email']),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => VendorDetails(vendorId: vendor.id),
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

class VendorDetails extends StatelessWidget {
  final String vendorId;
  VendorDetails({required this.vendorId});

  Future<void> _approveVendor(BuildContext context) async {
    await FirebaseFirestore.instance.collection('vendors').doc(vendorId).update({
      'approved': true,
      'pendingApproval': false,
    });
    Navigator.of(context).pop();
  }

  Future<void> _rejectVendor(BuildContext context) async {
    await FirebaseFirestore.instance.collection('vendors').doc(vendorId).delete();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('vendors').doc(vendorId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Vendor not found.'));
          }

          final vendor = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vendor Name: ${vendor['vendorName']}', style: TextStyle(fontSize: 18)),
                Text('Business Name: ${vendor['businessName']}', style: TextStyle(fontSize: 18)),
                Text('Email: ${vendor['email']}', style: TextStyle(fontSize: 18)),
                Text('Short Description: ${vendor['shortDescription']}', style: TextStyle(fontSize: 18)),
                vendor['profileImageUrl'] != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Image.network(vendor['profileImageUrl']),
                      )
                    : Text('No profile image uploaded', style: TextStyle(fontSize: 18, color: Colors.red)),
                vendor['nidImageUrl'] != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),

                        child: Image.network(vendor['nidImageUrl']),
                      )
                    : Text('No NID image uploaded', style: TextStyle(fontSize: 18, color: Colors.red)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _approveVendor(context),
                      child: Text('Approve'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    ),
                    ElevatedButton(
                      onPressed: () => _rejectVendor(context),
                      child: Text('Reject'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
