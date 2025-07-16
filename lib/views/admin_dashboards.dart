import 'package:flutter/material.dart';
import 'package:megamart_admin/views/admin/raw_data/view_firestore_data.dart';
import 'package:megamart_admin/views/admin_application_view.dart';
import 'package:megamart_admin/views/admin/admin_add_category.dart';
import 'package:megamart_admin/views/admin/admin_view_category.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/banner/upload_banner_screen.dart';
import 'package:megamart_admin/views/admin/admin_vendor_approval_all_details.dart';
import 'package:megamart_admin/views/data_Viewer.dart';
import 'package:megamart_admin/views/admin/admin_category_mangement_view.dart';
import 'package:megamart_admin/views/customer_profile_management_view.dart';
import 'package:megamart_admin/views/vendor_order_management_view.dart';
import 'package:megamart_admin/views/vendor_profile_management_view.dart';

class AdminDashboardView extends StatelessWidget {
  static const String routeName = '\\AdminDashboardView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 800) {
              crossAxisCount = 3;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome, Admin!\n\n',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      _buildDashboardButton(
                        context,
                        'Add Category',
                        Icons.add,
                        CategoryAdd(),
                      ),
                      _buildDashboardButton(
                        context,
                        'View Categories',
                        Icons.view_list,
                        CategoryView(),
                      ),
                      _buildDashboardButton(
                        context,
                        'Approve Vendor Applications',
                        Icons.check_circle,
                        AdminVendorApprovalView(),
                      ),
                      _buildDashboardButton(
                        context,
                        'Upload Banner',
                        Icons.upload,
                        UploadBannerScreen(),
                      ),
                      _buildDashboardButton(
                        context,
                        'View Firestore Data',
                        Icons.data_usage,
                        ViewFirestoreData(),
                      ),
                      _buildDashboardButton(
                        context,
                        'Category Management',
                        Icons.category,
                        AdminCategoryManagementView(),
                      ),
                      // _buildDashboardButton(
                      //   context,
                      //   'Customer Profile Management',
                      //   Icons.person,
                      //   CustomerProfileManagementView(),
                      // ),
                      // _buildDashboardButton(
                      //   context,
                      //   'Vendor Profile Management',
                      //   Icons.receipt_long,
                      //   VendorProfileManagementView(),
                      // ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDashboardButton(BuildContext context, String title, IconData icon, Widget destination) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blueAccent, backgroundColor: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(16.0),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => destination,
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blueAccent),
          SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}