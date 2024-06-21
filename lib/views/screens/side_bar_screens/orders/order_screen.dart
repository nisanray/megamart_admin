
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:megamart_admin/utils/colors.dart';
import 'order_desktop_view.dart';
import 'order_mobile_view.dart';
import '../../../../utils/responsive_helper/responsive_helper.dart';
class OrderScreen extends StatelessWidget {
  static const String routeName = '\OrderScreen';
  final List<Map<String, String>> data;
  final ScrollController _horizontalScrollController = ScrollController();

  OrderScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      color: AppColors.backgroundColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ResponsiveHelper.isDesktop(context) ? OrderDesktopView(data: [],) : OrderMobileView(data: [],),
    );
  }

}


