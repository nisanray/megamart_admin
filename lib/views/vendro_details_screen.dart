import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorDetailScreen extends StatefulWidget {
  final String vendorId;

  VendorDetailScreen({required this.vendorId});

  @override
  _VendorDetailScreenState createState() => _VendorDetailScreenState();
}

class _VendorDetailScreenState extends State<VendorDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DocumentSnapshot? _vendorData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchVendorData();
  }

  Future<void> _fetchVendorData() async {
    DocumentSnapshot vendorData = await _firestore.collection('vendors').doc(widget.vendorId).get();
    setState(() {
      _vendorData = vendorData;
      _isLoading = false;
    });
  }

  Future<void> _approveVendor() async {
    await _firestore.collection('vendors').doc(widget.vendorId).update({
      'isApproved': true,
      'pendingApproval': false,
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vendor approved')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Vendor Details'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${_vendorData!['name']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Business Name: ${_vendorData!['businessName']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Email: ${_vendorData!['email']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Short Description: ${_vendorData!['shortDescription']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              _buildImage('Vendor Photo', _vendorData!['vendorPhotoUrl']),
              _buildImage('Business Logo', _vendorData!['businessLogoUrl']),
              _buildImage('NID Photo', _vendorData!['nidPhotoUrl']),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _approveVendor,
                child: Text('Approve Vendor'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String label, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Image.network(imageUrl, height: 150),
        SizedBox(height: 8),
        Divider(),
      ],
    );
  }
}
