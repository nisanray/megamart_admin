import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:megamart_admin/utils/colors.dart';
import 'package:megamart_admin/utils/custom_text_form_field.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/banner/upload_banner_screen.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/banner/view_banner.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/category/categories_screen.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/category/view_category.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/orders/order_screen.dart';

import 'package:megamart_admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/products/products_screen.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/vendors/vendor_screen.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/withdrawal/withdrawal_screen.dart';
import '../../../utils/responsive_helper/responsive_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Widget _selectedItem;
  late String _selectedRoute;
  late String _selectedScreenName;
  bool _isSidebarOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedItem = DashboardScreen();
    _selectedRoute = DashboardScreen.routeName;
    _selectedScreenName = 'Dashboard';
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
        case DashboardScreen.routeName:
          _selectedItem = DashboardScreen();
          _selectedScreenName = 'Dashboard';
          break;
        case CategoriesScreen.routeName:
          _selectedItem = CategoriesScreen();
          _selectedScreenName = 'Categories';
          break;
        case OrderScreen.routeName:
          _selectedItem = OrderScreen(data: [],);
          _selectedScreenName = 'Orders';
          break;
        case ProductScreen.routeName:
          _selectedItem = ProductScreen();
          _selectedScreenName = 'Products';
          break;
        case UploadBannerScreen.routeName:
          _selectedItem = UploadBannerScreen();
          _selectedScreenName = 'Upload Banners';
          break;
        case VendorScreen.routeName:
          _selectedItem = VendorScreen();
          _selectedScreenName = 'Vendors';
          break;
        case WithdrawalScreen.routeName:
          _selectedItem = WithdrawalScreen(data: [],);
          _selectedScreenName = 'Withdrawal';
          break;
        case ViewCategory.routeName:
          _selectedItem = ViewCategory();
          _selectedScreenName = 'View Category';
          break;
          case ViewBanner.routeName:
          _selectedItem = ViewBanner();
          _selectedScreenName = 'View Banner';
          break;
        default:
          _selectedItem = DashboardScreen();
          _selectedScreenName = 'Dashboard';
      }
    });
  }

  void toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isScreenWide = ResponsiveHelper.isDesktop(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(

                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: AppColors.sideBarColor,
                  border: Border(
                    right: BorderSide(color: Color(0xFFdddcdc)),
                    top: BorderSide(color: Color(0xFFdddcdc)),
                    left: BorderSide(color: Color(0xFFdddcdc)),
                    bottom: BorderSide(color: Color(0xFFdddcdc)),

                  ),
                  borderRadius: BorderRadius.circular(10)
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
                      customSidebarItem('Dashboard', Icons.dashboard_outlined, DashboardScreen.routeName),
                      customSidebarItem('Vendors', CupertinoIcons.person_3, VendorScreen.routeName),
                      customSidebarItem('Withdrawal', Icons.money, WithdrawalScreen.routeName),
                      customSidebarItem('Orders', Icons.shopping_cart_outlined, OrderScreen.routeName),
                      customSidebarItem('Categories', Icons.category_outlined, CategoriesScreen.routeName),
                      customSidebarItem('Products', CupertinoIcons.shopping_cart, ProductScreen.routeName),
                      customSidebarItem('Upload Banners', Icons.add_a_photo_outlined, UploadBannerScreen.routeName),
                      customSidebarItem('View Category', Icons.remove_red_eye, ViewCategory.routeName),
                      customSidebarItem('View Banners', Icons.remove_red_eye, ViewBanner.routeName),
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
                        border: Border.all(color: Color(0xFFd0d3d6),),
                        borderRadius: BorderRadius.circular(10)
                      ),
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
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.notifications, color: AppColors.onyx),
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
            style: TextStyle(color: isSelected ? Colors.white : AppColors.sidebarUnselectFontColor),
          ),
          onTap: () {
            screenSelector(route);
          },
        ),
      ),
    );
  }
}
