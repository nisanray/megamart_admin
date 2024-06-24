import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SidebarNavigation extends StatefulWidget {
  @override
  _SidebarNavigationState createState() => _SidebarNavigationState();
}

class _SidebarNavigationState extends State<SidebarNavigation> {
  late Widget _selectedItem;
  late String _selectedRoute;
  late String _selectedScreenName;
  bool _isSidebarOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedItem = DashboardScreen();
    _selectedRoute = '/admin/dashboard';
    _selectedScreenName = 'Dashboard';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).size.width > 800) {
      _isSidebarOpen = true;
    } else {
      _isSidebarOpen = false;
    }
  }

  void screenSelector(String route, Widget screen, String screenName) {
    setState(() {
      _selectedRoute = route;
      _selectedItem = screen;
      _selectedScreenName = screenName;
    });
  }

  void toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isScreenWide = MediaQuery.of(context).size.width > 800;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFdddcdc)),
                  borderRadius: BorderRadius.circular(10),
                ),
                duration: Duration(milliseconds: 600),
                width: _isSidebarOpen ? 220 : 0,
                child: _isSidebarOpen
                    ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Image.asset(
                            'assets/logo/logo.png',
                            color: Color(0xff3860ff),
                          ),
                        ),
                      ),
                      _buildMainMenuItem(context, 'Admin', Icons.account_circle, [
                        _buildSubMenuItem(context, 'Dashboard', '/admin/dashboard', DashboardScreen(), 'Dashboard'),
                        _buildSubMenuItem(context, 'User Management', '/admin/user_management', UserManagementScreen(), 'User Management'),
                        _buildSubMenuItem(context, 'Vendor Approval', '/admin/vendor_approval', VendorApprovalScreen(), 'Vendor Approval'),
                        _buildSubMenuItem(context, 'Product Management', '/admin/product_management', ProductManagementScreen(), 'Product Management'),
                        _buildSubMenuItem(context, 'Order Management', '/admin/order_management', OrderManagementScreen(), 'Order Management'),
                        _buildSubMenuItem(context, 'Analytics', '/admin/analytics', AnalyticsScreen(), 'Analytics'),
                        _buildSubMenuItem(context, 'Support Tickets', '/admin/support_tickets', SupportTicketsScreen(), 'Support Tickets'),
                        _buildSubMenuItem(context, 'Notification Center', '/admin/notification_center', NotificationCenterScreen(), 'Notification Center'),
                        _buildSubMenuItem(context, 'Settings', '/admin/settings', SettingsScreen(), 'Settings'),
                        _buildSubMenuItem(context, 'Loyalty Programs', '/admin/loyalty_programs', LoyaltyProgramsScreen(), 'Loyalty Programs'),
                        _buildSubMenuItem(context, 'Payment & Shipping', '/admin/payment_shipping_management', PaymentShippingScreen(), 'Payment & Shipping'),
                      ]),
                      _buildMainMenuItem(context, 'Vendor', Icons.store, [
                        _buildSubMenuItem(context, 'Dashboard', '/vendor/dashboard', VendorDashboardScreen(), 'Dashboard'),
                        _buildSubMenuItem(context, 'Profile Management', '/vendor/profile_management', ProfileManagementScreen(), 'Profile Management'),
                        _buildSubMenuItem(context, 'Product Management', '/vendor/product_management', ProductManagementScreen(), 'Product Management'),
                        _buildSubMenuItem(context, 'Order Management', '/vendor/order_management', OrderManagementScreen(), 'Order Management'),
                        _buildSubMenuItem(context, 'Shipping Methods', '/vendor/shipping_methods', ShippingMethodsScreen(), 'Shipping Methods'),
                        _buildSubMenuItem(context, 'Notifications', '/vendor/notifications', NotificationsScreen(), 'Notifications'),
                        _buildSubMenuItem(context, 'Support Tickets', '/vendor/support_tickets', SupportTicketsScreen(), 'Support Tickets'),
                      ]),
                      _buildMainMenuItem(context, 'Customer', Icons.person, [
                        _buildSubMenuItem(context, 'Profile Management', '/customer/profile_management', ProfileManagementScreen(), 'Profile Management'),
                        _buildSubMenuItem(context, 'Product Browsing', '/customer/product_browsing', ProductBrowsingScreen(), 'Product Browsing'),
                        _buildSubMenuItem(context, 'Cart', '/customer/cart', CartScreen(), 'Cart'),
                        _buildSubMenuItem(context, 'Wishlist', '/customer/wishlist', WishlistScreen(), 'Wishlist'),
                        _buildSubMenuItem(context, 'Order Management', '/customer/order_management', OrderManagementScreen(), 'Order Management'),
                        _buildSubMenuItem(context, 'Reviews & Ratings', '/customer/reviews_ratings', ReviewsRatingsScreen(), 'Reviews & Ratings'),
                        _buildSubMenuItem(context, 'Notifications', '/customer/notifications', NotificationsScreen(), 'Notifications'),
                        _buildSubMenuItem(context, 'Loyalty Programs', '/customer/loyalty_programs', LoyaltyProgramsScreen(), 'Loyalty Programs'),
                        _buildSubMenuItem(context, 'Support Tickets', '/customer/support_tickets', SupportTicketsScreen(), 'Support Tickets'),
                      ]),
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
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFd0d3d6)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.menu, color: Colors.black),
                              onPressed: toggleSidebar,
                            ),
                          ),
                          if (!_isSidebarOpen || isScreenWide)
                            Expanded(
                              child: Center(
                                child: Text(
                                  _selectedScreenName,
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.notifications, color: Colors.black),
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

  Widget _buildMainMenuItem(BuildContext context, String title, IconData icon, List<Widget> subMenuItems) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      children: subMenuItems,
    );
  }

  Widget _buildSubMenuItem(BuildContext context, String title, String route, Widget screen, String screenName) {
    final bool isSelected = _selectedRoute == route;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(Icons.arrow_right, color: isSelected ? Colors.white : Colors.black),
          title: Text(
            title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
          onTap: () {
            Navigator.pop(context);
            screenSelector(route, screen, screenName);
          },
        ),
      ),
    );
  }
}

// Example dummy screens, replace these with actual screens.
class DashboardScreen extends StatelessWidget {
  static const String routeName = '/admin/dashboard';
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Dashboard Screen'));
  }
}

class UserManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('User Management Screen'));
  }
}

class VendorApprovalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Vendor Approval Screen'));
  }
}

class ProductManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Product Management Screen'));
  }
}

class OrderManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Order Management Screen'));
  }
}

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Analytics Screen'));
  }
}

class SupportTicketsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Support Tickets Screen'));
  }
}

class NotificationCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Notification Center Screen'));
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Settings Screen'));
  }
}

class LoyaltyProgramsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Loyalty Programs Screen'));
  }
}

class PaymentShippingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Payment & Shipping Screen'));
  }
}

class VendorDashboardScreen extends StatelessWidget {
  static const String routeName = '/vendor/dashboard';
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Vendor Dashboard Screen'));
  }
}

class ProfileManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Management Screen'));
  }
}

class ShippingMethodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Shipping Methods Screen'));
  }
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Notifications Screen'));
  }
}

class ProductBrowsingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Product Browsing Screen'));
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Cart Screen'));
  }
}

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Wishlist Screen'));
  }
}

class ReviewsRatingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Reviews & Ratings Screen'));
  }
}

class ViewCategory extends StatelessWidget {
  static const String routeName = '/admin/view_category';
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('View Category Screen'));
  }
}

class ViewBanner extends StatelessWidget {
  static const String routeName = '/admin/view_banner';
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('View Banner Screen'));
  }
}
