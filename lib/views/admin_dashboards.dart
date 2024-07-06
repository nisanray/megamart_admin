import 'package:flutter/material.dart';
import 'package:megamart_admin/views/admin/raw_data/view_firestore_data.dart';
import 'package:megamart_admin/views/admin_application_view.dart';
// import 'package:megamart_admin/views/admin/admin_vendor_approval_list.dart';
import 'package:megamart_admin/views/admin/admin_add_category.dart';
import 'package:megamart_admin/views/admin/admin_view_category.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/banner/upload_banner_screen.dart';
// import 'package:megamart_admin/views/screens/category_view.dart';

class AdminDashboardView extends StatelessWidget {
  static const String routeName = '\AdminDashboardView';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: Text("Add category"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryAdd(),
                ));
          },
        ),
        InkWell(
          child: Text("View category"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryView(),
                ));
          },
        ),
        Text('AdminDashboardView'),
        InkWell(
          child: Text("Approve Vendor"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApplicationListScreen(),
                ));
          },
        ),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadBannerScreen(),));
        }, child: Text('Upload Banner')),


        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFirestoreData(),));

        }, child: Text('View Firestore Data')),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
