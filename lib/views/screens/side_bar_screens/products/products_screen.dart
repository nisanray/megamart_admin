import 'package:flutter/material.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/products/product_desktop_view.dart';
import 'package:megamart_admin/views/screens/side_bar_screens/products/product_mobile_view.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/responsive_helper/responsive_helper.dart';
import '../orders/order_desktop_view.dart';
import '../orders/order_mobile_view.dart';


class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  static const String routeName = '\ProductScreen';
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      color: AppColors.backgroundGlitter,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ResponsiveHelper.isDesktop(context) ? ProductDesktopView(data: [],) : ProductMobileView(data: [],),
    );
  }
}
