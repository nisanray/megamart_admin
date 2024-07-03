import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorOrdersPage extends StatelessWidget {
  final String vendorId;

  VendorOrdersPage({required this.vendorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Orders'),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').where('vendorId', isEqualTo: vendorId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return Center(child: Text('No orders for this vendor.'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index];
              return ListTile(
                title: Text('Order ID: ${order.id}'),
                subtitle: Text('Status: ${order['status']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailPage(orderId: order.id),
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

class OrderDetailPage extends StatelessWidget {
  final String orderId;

  OrderDetailPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('orders').doc(orderId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var order = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order ID: $orderId', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Status: ${order['status']}', style: TextStyle(fontSize: 18)),
                Text('Customer ID: ${order['customerId']}', style: TextStyle(fontSize: 18)),
                // Add more order details here
              ],
            ),
          );
        },
      ),
    );
  }
}
