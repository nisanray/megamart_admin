import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminVendorApprovalView extends StatefulWidget {
  static const String routeName = '\AdminVendorApprovalView';
  @override
  _AdminVendorApprovalViewState createState() => _AdminVendorApprovalViewState();
}

class _AdminVendorApprovalViewState extends State<AdminVendorApprovalView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> _getPendingVendors() {
    return _firestore.collection('vendors')
        .where('profile.approved', isEqualTo: 'pending')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Vendor Approvals'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getPendingVendors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No pending approvals'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              String vendorId = doc.id;
              String name = data['name'];
              String email = data['email'];
              String storeName = data['profile']['storeName'];

              return ListTile(
                title: Text(name),
                subtitle: Text('$storeName - $email'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => VendorDetailPage(vendorId: vendorId)),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class VendorDetailPage extends StatelessWidget {
  final String vendorId;

  VendorDetailPage({required this.vendorId});

  void _approveVendor(BuildContext context) async {
    await FirebaseFirestore.instance.collection('vendors').doc(vendorId).update({
      'profile.approved': 'approved',
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vendor approved')));
    Navigator.of(context).pop();
  }

  void _rejectVendor(BuildContext context) async {
    await FirebaseFirestore.instance.collection('vendors').doc(vendorId).update({
      'profile.approved': 'rejected',
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vendor rejected')));
    Navigator.of(context).pop();
  }

  String _formatTimestamp(Timestamp timestamp) {
    return DateFormat.yMMMd().add_jm().format(timestamp.toDate());
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
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Vendor not found'));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          var profile = data['profile'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Container(
                  height: 200,
                  child:Image(image:NetworkImage(profile['ownerPhotoUrl']),)
                ),
                SizedBox(height: 20),
                Text('Name: ${data['name']}', style: TextStyle(fontSize: 18)),
                Text('Email: ${data['email']}', style: TextStyle(fontSize: 18)),
                Text('Store Name: ${profile['storeName']}', style: TextStyle(fontSize: 18)),
                Text('Phone: ${profile['phone']}', style: TextStyle(fontSize: 18)),
                Text('Address: ${profile['address']}', style: TextStyle(fontSize: 18)),
                Text('Date of Birth: ${_formatTimestamp(profile['dateOfBirth'])}', style: TextStyle(fontSize: 18)),

                Text('Business Registration Number: ${profile['businessRegistrationNumber']}', style: TextStyle(fontSize: 18)),
                Text('Tax ID: ${profile['taxId']}', style: TextStyle(fontSize: 18)),
                Text('Ratings: ${profile['ratings']}', style: TextStyle(fontSize: 18)),
                Text('Date Joined: ${_formatTimestamp(profile['dateJoined'])}', style: TextStyle(fontSize: 18)),
                Text('Last Login: ${profile['lastLogin'] != null ? _formatTimestamp(profile['lastLogin']) : 'N/A'}', style: TextStyle(fontSize: 18)),
                Text('Emergency Contact Name: ${profile['emergencyContact']['name']}', style: TextStyle(fontSize: 18)),
                Text('Emergency Contact Phone: ${profile['emergencyContact']['phone']}', style: TextStyle(fontSize: 18)),
                Text('LinkedIn: ${profile['socialMedia']['linkedin']}', style: TextStyle(fontSize: 18)),
                Text('Twitter: ${profile['socialMedia']['twitter']}', style: TextStyle(fontSize: 18)),
                Text('Facebook: ${profile['socialMedia']['facebook']}', style: TextStyle(fontSize: 18)),
                Text('Bio: ${profile['bio']}', style: TextStyle(fontSize: 18)),
                Text('Additional Info: ${profile['additionalInfo']}', style: TextStyle(fontSize: 18)),
                Text('Store Logo:', style: TextStyle(fontSize: 18)),
                Image.network(profile['storeLogoUrl'], height: 100, width: 100),
                Text('NID Photo:', style: TextStyle(fontSize: 18)),
                Image.network(profile['nidPhotoUrl'], height: 100, width: 100),
                SizedBox(height: 20),
                Text('Status: ${profile['approved']}', style: TextStyle(fontSize: 18, color: profile['approved'] == 'pending' ? Colors.orange : (profile['approved'] == 'approved' ? Colors.green : Colors.red))),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _approveVendor(context),
                      child: Text('Approve',style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    ),
                    ElevatedButton(
                      onPressed: () => _rejectVendor(context),
                      child: Text('Reject',style: TextStyle(color: Colors.white),),
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
