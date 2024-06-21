import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:megamart_admin/utils/colors.dart';
import 'package:megamart_admin/utils/custom_progress_indicator.dart';

class ViewCategory extends StatefulWidget {
  const ViewCategory({Key? key}) : super(key: key);
  static const String routeName = '/viewCategory';

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  final Stream<QuerySnapshot> _categoryStream =
  FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: StreamBuilder<QuerySnapshot>(
        stream: _categoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CustomCircularProgressIndicator(value: 0));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No categories found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final categoryData = snapshot.data!.docs[index];
              final imageUrl = categoryData['image'];
              final categoryName = categoryData['categoryName'];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullImageScreen(
                          imageUrl: imageUrl,
                          categoryName: categoryName,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.sidebarAntiFlashWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ListTile(
                        leading: imageUrl != null && imageUrl.isNotEmpty
                            ? SizedBox(
                          width: 40,
                          child: Image.network(
                            imageUrl,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Icon(Icons.image_not_supported, size: 40),
                        title: Text(categoryName),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


class FullImageScreen extends StatelessWidget {
  final String? imageUrl;
  final String? categoryName;

  const FullImageScreen({
    Key? key,
    required this.imageUrl,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName ?? 'Full Image'),
        centerTitle: true,
      ),
      body: Center(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
          imageUrl!,
          fit: BoxFit.contain,
        )
            : Text('Image not available'),
      ),
    );
  }
}
