import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/custom_progress_indicator.dart';

class ViewBanner extends StatefulWidget {
  const ViewBanner({super.key});
  static const String routeName = '/viewBanner';

  @override
  State<ViewBanner> createState() => _ViewBannerState();
}

class _ViewBannerState extends State<ViewBanner> {
  final Stream<QuerySnapshot> _bannerStream =
  FirebaseFirestore.instance.collection('banners').snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundGlitter,
      child: StreamBuilder<QuerySnapshot>(
        stream: _bannerStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CustomCircularProgressIndicator(value: 0));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No banners found'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 10, // Space between columns
              mainAxisSpacing: 10, // Space between rows
              childAspectRatio: 1, // Aspect ratio of each item
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final bannerData = snapshot.data!.docs[index];
              final imageUrl = bannerData['image'];
              final BannerName = bannerData['fileName'];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullImageScreen(
                        imageUrl: imageUrl,
                        BannerName: BannerName,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.sidebarAntiFlashWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: imageUrl != null && imageUrl.isNotEmpty
                              ? AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )
                              : Icon(Icons.image_not_supported, size: 40),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        BannerName ?? 'No Name',
                        style: TextStyle(
                          color: AppColors.onyx,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
  final String? BannerName;

  const FullImageScreen({
    Key? key,
    required this.imageUrl,
    required this.BannerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(BannerName ?? 'Full Image'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: imageUrl != null && imageUrl!.isNotEmpty
              ? Image.network(
            imageUrl!,
            fit: BoxFit.contain,
          )
              : Text('Image not available'),
        ),
      ),
    );
  }
}
