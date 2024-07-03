import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:megamart_admin/utils/colors.dart';
import 'package:megamart_admin/utils/constants.dart';
// import 'package:megamart_admin/utils/custom_text_form_field.dart';
import 'package:megamart_admin/views/admin_analytics_view.dart';
import 'package:megamart_admin/views/admin_dashboards.dart';
import 'package:megamart_admin/views/admin_loyalty_programs_view.dart';
import 'package:megamart_admin/views/admin_notification_center_view.dart';
import 'package:megamart_admin/views/admin_order_management_view.dart';
import 'package:megamart_admin/views/admin_payment_shipping_management_view.dart';
import 'package:megamart_admin/views/admin_product_management_view.dart';
import 'package:megamart_admin/views/admin_settings_view.dart';
import 'package:megamart_admin/views/admin_support_tickets_view.dart';
import 'package:megamart_admin/views/admin_user_management_view.dart';
import 'package:megamart_admin/views/admin_vendor_approval_view.dart';
import 'package:megamart_admin/views/customer_cart_view.dart';
import 'package:megamart_admin/views/customer_loyalty_programs_view.dart';
import 'package:megamart_admin/views/customer_notifications_view.dart';
import 'package:megamart_admin/views/customer_order_management_view.dart';
import 'package:megamart_admin/views/customer_product_browsing_view.dart';
import 'package:megamart_admin/views/customer_profile_management_view.dart';
import 'package:megamart_admin/views/customer_reviews_ratings_view.dart';
import 'package:megamart_admin/views/customer_support_tickets_view.dart';
import 'package:megamart_admin/views/customer_wishlist_view.dart';
import 'package:megamart_admin/views/admin/admin_category_mangement_view.dart';
import 'package:megamart_admin/views/screens/sidebar_updated/sidebar_navigations.dart';
import 'package:megamart_admin/views/vendor/vendor_notifications_view.dart';
import 'package:megamart_admin/views/vendor_order_management_view.dart';
import 'package:megamart_admin/views/vendor_product_management_view.dart';
import 'package:megamart_admin/views/vendor_profile_management_view.dart';
import 'package:megamart_admin/views/vendor_shipping_methods_view.dart';
import 'package:megamart_admin/views/vendor_support_tickets_view.dart';

import '../../utils/responsive_helper/responsive_helper.dart';

class SideBarNavigation extends StatefulWidget {
  const SideBarNavigation({Key? key}) : super(key: key);

  @override
  State<SideBarNavigation> createState() => _SideBarNavigation();
}

class _SideBarNavigation extends State<SideBarNavigation> {
  late Widget _selectedItem;
  late String _selectedRoute;
  late String _selectedScreenName;
  bool _isSidebarOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedItem = AdminDashboardView();
    _selectedRoute = AdminDashboardView.routeName;
    _selectedScreenName = 'Admin Dashboard';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ResponsiveHelper.isDesktop(context)) {
      _isSidebarOpen = true;
    } else {
      _isSidebarOpen = false;
    }
  }

  void screenSelector(String route) {
    setState(() {
      _selectedRoute = route;
      switch (route) {
        case AdminDashboardView.routeName:
          _selectedItem = AdminDashboardView();
          _selectedScreenName = 'Dashboard';
          break;
        case AdminAnalyticsView.routeName:
          _selectedItem = AdminAnalyticsView();
          _selectedScreenName = 'Admin Analytics';
          break;
        case AdminLoyaltyProgramsView.routeName:
          _selectedItem = AdminLoyaltyProgramsView();
          _selectedScreenName = 'Admin Loyalty Programs View';
          break;

        case AdminNotificationCenterView.routeName:
          _selectedItem = AdminNotificationCenterView();
          _selectedScreenName = 'Admin Notification Center';
          break;
        case AdminCategoryManagementView.routeName:
          _selectedItem = AdminCategoryManagementView();
          _selectedScreenName = 'Admin Category Management';
          break;

        case AdminOrderManagementView.routeName:
          _selectedItem = AdminOrderManagementView();
          _selectedScreenName = 'Admin Order Management';
          break;
        case AdminPaymentShippingManagementView.routeName:
          _selectedItem = AdminPaymentShippingManagementView();
          _selectedScreenName = 'Admin Payment Shipping';
          break;
        case AdminProductManagementView.routeName:
          _selectedItem = AdminProductManagementView();
          _selectedScreenName = 'Admin Product Management';
          break;
        case AdminSettingsView.routeName:
          _selectedItem = AdminSettingsView();
          _selectedScreenName = 'Admin Settings';
          break;
        case AdminSupportTicketsView.routeName:
          _selectedItem = AdminSupportTicketsView();
          _selectedScreenName = 'Admin SupportTickets';
          break;
        case AdminUserManagementView.routeName:
          _selectedItem = AdminUserManagementView();
          _selectedScreenName = 'Admin User Mangement view';
          break;
        case AdminVendorApprovalView.routeName:
          _selectedItem = AdminVendorApprovalView();
          _selectedScreenName = 'Admin Vendor Approval';
          break;
        case CustomerCartView.routeName:
          _selectedItem = CustomerCartView();
          _selectedScreenName = 'Customer Cart';
          break;
        case CustomerLoyaltyProgramsView.routeName:
          _selectedItem = CustomerLoyaltyProgramsView();
          _selectedScreenName = '';
          break;
        case CustomerNotificationsView.routeName:
          _selectedItem = CustomerNotificationsView();
          _selectedScreenName = 'Customer Notification';
          break;
        case CustomerOrderManagementView.routeName:
          _selectedItem = CustomerOrderManagementView();
          _selectedScreenName = 'Customer Order Management';
          break;
        case CustomerProductBrowsingView.routeName:
          _selectedItem = CustomerProductBrowsingView();
          _selectedScreenName = 'Customer Product Browsing';
          break;
        case CustomerProfileManagementView.routeName:
          _selectedItem = CustomerProfileManagementView();
          _selectedScreenName = 'Customer Profile Management';
          break;
        case CustomerReviewsRatingsView.routeName:
          _selectedItem = CustomerReviewsRatingsView();
          _selectedScreenName = 'Customer Review And Ratings';
          break;
        case CustomerSupportTicketsView.routeName:
          _selectedItem = CustomerSupportTicketsView();
          _selectedScreenName = 'Customer Support Ticket';
          break;
        case CustomerWishlistView.routeName:
          _selectedItem = CustomerWishlistView();
          _selectedScreenName = 'CustomerWishList';
          break;
        case VendorDashboardScreen.routeName:
          _selectedItem = VendorDashboardScreen();
          _selectedScreenName = 'Vendor Dashboard';
          break;
        case VendorNotificationsView.routeName:
          _selectedItem = VendorNotificationsView();
          _selectedScreenName = 'Vendor Notification';
          break;
        case VendorOrderManagementView.routeName:
          _selectedItem = VendorOrderManagementView();
          _selectedScreenName = 'Vendor Order Management';
          break;
        case VendorProductManagementView.routeName:
          _selectedItem = VendorProductManagementView();
          _selectedScreenName = 'Vendor Product Management';
          break;
        case VendorProfileManagementView.routeName:
          _selectedItem = VendorProfileManagementView();
          _selectedScreenName = '';
          break;
        case VendorShippingMethodsView.routeName:
          _selectedItem = VendorShippingMethodsView();
          _selectedScreenName = 'Vendor Shipping Methods';
          break;
        case VendorSupportTicketsView.routeName:
          _selectedItem = VendorSupportTicketsView();
          _selectedScreenName = 'Vendor Support Ticket';
          break;

        default:
          _selectedItem = AdminDashboardView();
          _selectedScreenName = 'Admin Dashboard';
      }
    });
  }

  void toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  bool _isDarkMode = false;
  void _toggleThemeMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isScreenWide = ResponsiveHelper.isDesktop(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            _isDarkMode ? ConstanTs.mainBGColor : AppColors.backgroundColor,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    // color: AppColors.sideBarColor,
                    gradient:
                        LinearGradient(colors: ConstanTs.customGradientSidebar),
                    border: Border(
                      right: BorderSide(color: Color(0xFFdddcdc), width: 2),
                      top: BorderSide(color: Color(0xFFdddcdc), width: 2),
                      left: BorderSide(color: Color(0xFFdddcdc), width: 2),
                      bottom: BorderSide(color: Color(0xFFdddcdc), width: 2),
                    ),
                    borderRadius: BorderRadius.circular(10)),
                duration: Duration(milliseconds: 600),
                width: _isSidebarOpen ? ConstanTs.SideBarWidth : 0,
                child: _isSidebarOpen
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: Image.asset(
                                      'assets/logo/logo.png',
                                      color: Color(0xff3860ff),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    child: IconButton(
                                        onPressed: _toggleThemeMode,
                                        icon: Icon(_isDarkMode
                                            ? Icons.sunny
                                            : Icons.dark_mode_outlined)))
                              ],
                            ),
                            customSidebarItem(
                                'Admin Dashboard',
                                Icons.dashboard_outlined,
                                AdminDashboardView.routeName),
                            SizedBox(
                              height: 20,
                            ),
                            ExpansionTile(
                              title: Text('Admin Management'),
                              leading:
                                  Icon(Icons.admin_panel_settings_outlined),
                              children: [
                                customSidebarItem(
                                    'Admin Category Management',
                                    Icons.category_outlined,
                                    AdminCategoryManagementView.routeName),
                                customSidebarItem(
                                    'Admin Analytics',
                                    Icons.analytics_outlined,
                                    AdminAnalyticsView.routeName),
                                customSidebarItem(
                                    'Admin Loyalty Programs',
                                    Icons.loyalty_outlined,
                                    AdminLoyaltyProgramsView.routeName),
                                customSidebarItem(
                                    'Admin Notification Center',
                                    Icons.notifications_outlined,
                                    AdminNotificationCenterView.routeName),
                                customSidebarItem(
                                    'Admin Order Management',
                                    Icons.receipt_long_outlined,
                                    AdminOrderManagementView.routeName),
                                customSidebarItem(
                                    'Admin Payment Shipping',
                                    Icons.local_shipping_outlined,
                                    AdminPaymentShippingManagementView
                                        .routeName),
                                customSidebarItem(
                                    'Admin Product Management',
                                    Icons.production_quantity_limits_outlined,
                                    AdminProductManagementView.routeName),
                                customSidebarItem(
                                    'Admin Settings',
                                    Icons.settings_outlined,
                                    AdminSettingsView.routeName),
                                customSidebarItem(
                                    'Admin Support Tickets',
                                    Icons.support_agent_outlined,
                                    AdminSupportTicketsView.routeName),
                                customSidebarItem(
                                    'Admin User Management',
                                    Icons.supervised_user_circle_outlined,
                                    AdminUserManagementView.routeName),

                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ExpansionTile(
                              title: Text('Customer Management'),
                              leading: Icon(Icons.people_outline),
                              children: [
                                customSidebarItem(
                                    'Customer Profile Management',
                                    Icons.person_outline,
                                    CustomerProfileManagementView.routeName),
                                customSidebarItem(
                                    'Customer Product Browsing',
                                    Icons.shop_outlined,
                                    CustomerProductBrowsingView.routeName),
                                customSidebarItem(
                                    'Customer Cart',
                                    Icons.shopping_cart_outlined,
                                    CustomerCartView.routeName),
                                customSidebarItem(
                                    'Customer Wishlist',
                                    Icons.favorite_outline,
                                    CustomerWishlistView.routeName),
                                customSidebarItem(
                                    'Customer Order Management',
                                    Icons.receipt_long_outlined,
                                    CustomerOrderManagementView.routeName),
                                customSidebarItem(
                                    'Customer Notifications',
                                    Icons.notifications_outlined,
                                    CustomerNotificationsView.routeName),
                                customSidebarItem(
                                    'Customer Reviews Ratings',
                                    Icons.star_outline,
                                    CustomerReviewsRatingsView.routeName),
                                customSidebarItem(
                                    'Customer Support Tickets',
                                    Icons.support_agent_outlined,
                                    CustomerSupportTicketsView.routeName),

                                customSidebarItem(
                                    'Customer Loyalty Programs',
                                    Icons.card_giftcard_outlined,
                                    CustomerLoyaltyProgramsView.routeName),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ExpansionTile(
                              title: Text('Vendor Management'),
                              leading: Icon(Icons.storefront_outlined),
                              children: [
                                customSidebarItem(
                                    'Vendor Approval',
                                    Icons.verified_outlined,
                                    AdminVendorApprovalView.routeName),
                                customSidebarItem(
                                    'Vendor Profile Management',
                                    Icons.person_outline,
                                    VendorProfileManagementView.routeName),
                                customSidebarItem(
                                    'Vendor Dashboard',
                                    Icons.dashboard_outlined,
                                    VendorDashboardScreen.routeName),
                                customSidebarItem(
                                    'Vendor Product Management',
                                    Icons.production_quantity_limits_outlined,
                                    VendorProductManagementView.routeName),
                                customSidebarItem(
                                    'Vendor Order Management',
                                    Icons.receipt_long_outlined,
                                    VendorOrderManagementView.routeName),
                                customSidebarItem(
                                    'Vendor Shipping Methods',
                                    Icons.local_shipping_outlined,
                                    VendorShippingMethodsView.routeName),
                                customSidebarItem(
                                    'Vendor Notifications',
                                    Icons.notifications_outlined,
                                    VendorNotificationsView.routeName),

                                customSidebarItem(
                                    'Vendor Support Tickets',
                                    Icons.support_agent_outlined,
                                    VendorSupportTicketsView.routeName),
                              ],
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppColors.sideBarColor,
                          border: Border.all(
                            color: Color(0xFFd0d3d6),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(Icons.menu, color: AppColors.onyx),
                                onPressed: toggleSidebar,
                              ),
                            ),
                            if (!_isSidebarOpen || isScreenWide)
                              Expanded(
                                child: Center(
                                  child: Text(
                                    _selectedScreenName,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.notifications,
                                      color: AppColors.onyx),
                                  onPressed: () {
                                    // Handle notification icon tap
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CircleAvatar(
                                      // backgroundImage: AssetImage('assets/profile_pic.png'), // Replace with user's profile picture
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _selectedItem,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customSidebarItem(String title, IconData icon, String route) {
    final bool isSelected = _selectedRoute == route;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blueColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: isSelected ? Colors.white : Colors.black),
          title: Text(
            title,
            style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : AppColors.sidebarUnselectFontColor),
          ),
          onTap: () {
            screenSelector(route);
          },
        ),
      ),
    );
  }
}
