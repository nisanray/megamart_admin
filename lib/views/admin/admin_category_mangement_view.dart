import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'admin_add_category.dart';
import 'category_details.dart';

class AdminCategoryManagementView extends StatefulWidget {
  const AdminCategoryManagementView({super.key});
  static const String routeName = '\AdminCategoryManagementView';
  @override
  State<AdminCategoryManagementView> createState() => _AdminCategoryManagementViewState();
}

class _AdminCategoryManagementViewState extends State<AdminCategoryManagementView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No categories found'));
          }

          final categories = snapshot.data!.docs;

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return ListTile(
                title: Text(category['name']),
                subtitle: Text(category['description']),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryDetail(category: category),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoryAdd(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );;
  }
}
