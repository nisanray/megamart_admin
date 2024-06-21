import 'package:flutter/material.dart';
import 'package:megamart_admin/utils/colors.dart';
import '/views/screens/side_bar_screens/withdrawal/withdrawal_desktop_view.dart';
import '/views/screens/side_bar_screens/withdrawal/withdrawal_mobile_view.dart';

import '../../../../utils/responsive_helper/responsive_helper.dart';
import '../orders/order_desktop_view.dart';
import '../orders/order_mobile_view.dart';

class WithdrawalScreen extends StatelessWidget {
  final List<Map<String, String>> data;
  static const String routeName = '\WithdrwalScreen';

  WithdrawalScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      color: AppColors.backgroundColor,
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: ResponsiveHelper.isDesktop(context)
          ? WithdrawalDesktopView(data: [],)
          : WithdrawalMobileView(data: [],),
    );
  }

}