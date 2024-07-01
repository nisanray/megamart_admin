import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerProfileManagementView extends StatelessWidget {
  static const String routeName = '\CustomerProfileManagementView';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('customers').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var customer = snapshot.data!.docs[index];
            return ListTile(
              title: Text(customer['fullName']),
              subtitle: Text(customer['email']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerDetailsPage(customer: customer),
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

// import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDetailsPage extends StatelessWidget {
  final DocumentSnapshot customer;

  CustomerDetailsPage({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: customer['profile']?['profilePicture'] != null
                      ? NetworkImage(customer['profile']['profilePicture'])
                      : AssetImage('assets/images/default_profile.png') as ImageProvider,
                ),
              ),
              SizedBox(height: 16),
              Card(
                child: ListTile(
                  title: Text('Full Name'),
                  subtitle: Text(customer['fullName'] ?? 'Not specified'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Email'),
                  subtitle: Text(customer['email'] ?? 'Not specified'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Phone Number'),
                  subtitle: Text(customer['phoneNumber'] ?? 'Not specified'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Date of Birth'),
                  subtitle: Text(customer['profile']?['dateOfBirth'] ?? 'Not specified'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Gender'),
                  subtitle: Text(customer['profile']?['gender'] ?? 'Not specified'),
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('Address'),
                  children: [
                    ListTile(
                      title: Text('Division'),
                      subtitle: Text(customer['address']?['division'] ?? 'Not specified'),
                    ),
                    ListTile(
                      title: Text('District'),
                      subtitle: Text(customer['address']?['district'] ?? 'Not specified'),
                    ),
                    ListTile(
                      title: Text('Upazilla'),
                      subtitle: Text(customer['address']?['upazilla'] ?? 'Not specified'),
                    ),
                    ListTile(
                      title: Text('Area'),
                      subtitle: Text(customer['address']?['area'] ?? 'Not specified'),
                    ),
                  ],
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Loyalty Points'),
                  subtitle: Text(customer['profile']?['loyaltyPoints']?.toString() ?? 'Not specified'),
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('Order History'),
                  children: customer['profile']?['orderHistory'] != null
                      ? List.generate(
                    customer['profile']['orderHistory'].length,
                        (index) => ListTile(
                      title: Text('${index + 1}. ${customer['profile']['orderHistory'][index]}'),
                    ),
                  )
                      : [ListTile(title: Text('No order history'))],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('Social Media'),
                  children: [
                    ListTile(
                      title: Text('LinkedIn'),
                      subtitle: Text(customer['profile']?['socialMedia']?['linkedin'] ?? 'Not specified'),
                    ),
                    ListTile(
                      title: Text('Twitter'),
                      subtitle: Text(customer['profile']?['socialMedia']?['twitter'] ?? 'Not specified'),
                    ),
                    ListTile(
                      title: Text('Facebook'),
                      subtitle: Text(customer['profile']?['socialMedia']?['facebook'] ?? 'Not specified'),
                    ),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('Emergency Contact'),
                  children: [
                    ListTile(
                      title: Text('Name'),
                      subtitle: Text(customer['profile']?['emergencyContact']?['name'] ?? 'Not specified'),
                    ),
                    ListTile(
                      title: Text('Phone'),
                      subtitle: Text(customer['profile']?['emergencyContact']?['phone'] ?? 'Not specified'),
                    ),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('Additional Information'),
                  children: customer['profile']?['additionalInfo'] != null
                      ? List.generate(
                    customer['profile']['additionalInfo'].length,
                        (index) => ListTile(
                      title: Text(customer['profile']['additionalInfo'].keys.toList()[index]),
                      subtitle: Text(customer['profile']['additionalInfo'].values.toList()[index]),
                    ),
                  )
                      : [ListTile(title: Text('No additional information'))],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
