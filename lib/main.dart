import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
// import 'package:megamart_admin/views/admin/admin_analytics_view.dart';
import 'package:megamart_admin/views/admin_dashboards.dart';
import 'package:megamart_admin/views/admin_loyalty_programs_view.dart';
import 'package:megamart_admin/views/admin_notification_center_view.dart';
import 'package:megamart_admin/views/admin_order_management_view.dart';
import 'package:megamart_admin/views/admin_payment_shipping_management_view.dart';
import 'package:megamart_admin/views/admin_product_management_view.dart';
import 'package:megamart_admin/views/admin_settings_view.dart';
import 'package:megamart_admin/views/admin_support_tickets_view.dart';
import 'package:megamart_admin/views/admin_user_management_view.dart';
import 'package:megamart_admin/views/admin/admin_vendor_approval_all_details.dart';
import 'package:megamart_admin/views/customer_cart_view.dart';
import 'package:megamart_admin/views/customer_loyalty_programs_view.dart';
import 'package:megamart_admin/views/customer_notifications_view.dart';
import 'package:megamart_admin/views/customer_order_management_view.dart';
import 'package:megamart_admin/views/customer_product_browsing_view.dart';
import 'package:megamart_admin/views/customer_profile_management_view.dart';
// import 'package:megamart_admin/views/customer_revies_ratings_view.dart';
import 'package:megamart_admin/views/customer_support_tickets_view.dart';
import 'package:megamart_admin/views/customer_wishlist_view.dart';
import 'package:megamart_admin/views/main_screen.dart';
// import 'package:megamart_admin/views/screens/sidebar_updated/sidebar_navigations.dart';
import 'package:megamart_admin/views/vendor_dashboard_view.dart';
import 'package:megamart_admin/views/vendor/vendor_notifications_view.dart';
import 'package:megamart_admin/views/vendor_order_management_view.dart';
import 'package:megamart_admin/views/vendor_product_management_view.dart';
import 'package:megamart_admin/views/vendor_profile_management_view.dart';
import 'package:megamart_admin/views/vendor_shipping_methods_view.dart';
import 'package:megamart_admin/views/vendor_support_tickets_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SideBarNavigation(),
      // initialRoute: '/admin/dashboard', // Initial route for admin dashboard
      // routes: {
      //   // Admin routes
      //   '/admin/dashboard': (context) => AdminDashboardView(),
      //   '/admin/user_management': (context) => AdminUserManagementView(),
      //   '/admin/vendor_approval': (context) => AdminVendorApprovalView(),
      //   '/admin/product_management': (context) => AdminProductManagementView(),
      //   '/admin/order_management': (context) => AdminOrderManagementView(),
      //   '/admin/analytics': (context) => AdminAnalyticsView(),
      //   '/admin/support_tickets': (context) => AdminSupportTicketsView(),
      //   '/admin/notification_center': (context) => AdminNotificationCenterView(),
      //   '/admin/settings': (context) => AdminSettingsView(),
      //   '/admin/loyalty_programs': (context) => AdminLoyaltyProgramsView(),
      //   '/admin/payment_shipping_management': (context) => AdminPaymentShippingManagementView(),
      //   // Vendor routes
      //   '/vendor/dashboard': (context) => VendorDashboardView(),
      //   '/vendor/profile_management': (context) => VendorProfileManagementView(),
      //   '/vendor/product_management': (context) => VendorProductManagementView(),
      //   '/vendor/order_management': (context) => VendorOrderManagementView(),
      //   '/vendor/shipping_methods': (context) => VendorShippingMethodsView(),
      //   '/vendor/notifications': (context) => VendorNotificationsView(),
      //   '/vendor/support_tickets': (context) => VendorSupportTicketsView(),
      //   // Customer routes
      //   '/customer/profile_management': (context) => CustomerProfileManagementView(),
      //   '/customer/product_browsing': (context) => CustomerProductBrowsingView(),
      //   '/customer/cart': (context) => CustomerCartView(),
      //   '/customer/wishlist': (context) => CustomerWishlistView(),
      //   '/customer/order_management': (context) => CustomerOrderManagementView(),
      //   '/customer/reviews_ratings': (context) => CustomerReviewsRatingsView(),
      //   '/customer/notifications': (context) => CustomerNotificationsView(),
      //   '/customer/loyalty_programs': (context) => CustomerLoyaltyProgramsView(),
      //   '/customer/support_tickets': (context) => CustomerSupportTicketsView(),
      // },
    );
  }
}
