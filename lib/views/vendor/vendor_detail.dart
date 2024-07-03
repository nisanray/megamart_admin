import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:megamart_admin/views/vendor/vendor_orders_page.dart';
import 'package:megamart_admin/views/vendor/vendor_products_page.dart';

class VendorDetail extends StatelessWidget {
  final String vendorId;

  VendorDetail({required this.vendorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('vendors').doc(vendorId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var vendor = snapshot.data!.data() as Map<String, dynamic>;
          var profile = vendor['profile'] as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: CachedNetworkImageProvider(profile['storeLogoUrl']),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      vendor['name'],
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      profile['storeName'],
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildInfoCard('Contact Information', [
                    _buildInfoRow('Email', vendor['email']),
                    _buildInfoRow('Phone', profile['phone']),
                    _buildInfoRow('Address', profile['address']),
                    _buildInfoRow('Date of Birth', profile['dateOfBirth'] != null ? profile['dateOfBirth'].toDate().toString() : 'N/A'),
                  ]),
                  _buildInfoCard('Business Information', [
                    _buildInfoRow('Ratings', profile['ratings'].toString()),
                    _buildInfoRow('Date Joined', profile['dateJoined'] != null ? profile['dateJoined'].toDate().toString() : 'N/A'),
                    _buildInfoRow('Last Login', profile['lastLogin'] != null ? profile['lastLogin'].toDate().toString() : 'N/A'),
                    _buildProductCountRow('Products Added', vendorId),
                  ]),
                  _buildImageCard('Owner Photo', profile['ownerPhotoUrl']),
                  _buildImageCard('NID Photo', profile['nidPhotoUrl']),
                  _buildInfoCard('Bank Account Details', [
                    _buildInfoRow('Account Number', profile['bankAccountDetails']['accountNumber']),
                    _buildInfoRow('Bank Name', profile['bankAccountDetails']['bankName']),
                    _buildInfoRow('IFSC', profile['bankAccountDetails']['IFSC']),
                  ]),
                  _buildInfoCard('Emergency Contact', [
                    _buildInfoRow('Name', profile['emergencyContact']['name']),
                    _buildInfoRow('Phone', profile['emergencyContact']['phone']),
                  ]),
                  _buildInfoCard('Social Media', [
                    _buildInfoRow('LinkedIn', profile['socialMedia']['linkedin']),
                    _buildInfoRow('Twitter', profile['socialMedia']['twitter']),
                    _buildInfoRow('Facebook', profile['socialMedia']['facebook']),
                  ]),
                  _buildInfoCard('Bio', [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(profile['bio'], style: TextStyle(fontSize: 18)),
                    ),
                  ]),
                  _buildInfoCard('Additional Information', _buildAdditionalInfo(profile['additionalInfo'])),
                  SizedBox(height: 20),
                  _buildActionButton(context, 'View Orders', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VendorOrdersPage(vendorId: vendorId),
                      ),
                    );
                  }),
                  _buildActionButton(context, 'View Products', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VendorProductsPage(vendorId: vendorId),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: _sectionTitleStyle()),
            Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String title, String imageUrl) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: _sectionTitleStyle()),
            Divider(),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _sectionTitleStyle() {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent);
  }

  Widget _buildInfoRow(String title, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$title:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              info,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCountRow(String title, String vendorId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').where('vendorId', isEqualTo: vendorId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _buildInfoRow(title, 'Loading...');
        }
        int productCount = snapshot.data!.docs.length;
        return _buildInfoRow(title, productCount.toString());
      },
    );
  }

  List<Widget> _buildAdditionalInfo(Map<String, dynamic> additionalInfo) {
    List<Widget> widgets = [];
    additionalInfo.forEach((key, value) {
      widgets.add(_buildInfoRow(key, value));
    });
    return widgets;
  }

  Widget _buildActionButton(BuildContext context, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
          child: Text(title,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
