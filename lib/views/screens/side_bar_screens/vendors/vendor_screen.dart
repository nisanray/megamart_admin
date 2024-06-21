import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/responsive_helper/responsive_helper.dart';
import 'desktop_vendor.dart';
import 'mobile_vendor.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({Key? key}) : super(key: key);

  static const String routeName = '/vendorScreen';

  static Widget rowHeader(String text) {
    return Flexible(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          // borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Example data
  static List<Map<String, String>> vendorData = [
    {
      'logo': 'Logo1',
      'businessName': 'Business Name 1',
      'city': 'City 1',
      'division': 'Division 1',
    },
    {
      'logo': 'Logo2',
      'businessName': 'Business Name 2',
      'city': 'City 2',
      'division': 'Division 2',
    },
    {
      'logo': 'Logo3',
      'businessName': 'Business Name 3',
      'city': 'City 3',
      'division': 'Division 3',
    },{
      'logo': 'Logo1',
      'businessName': 'Business Name 1',
      'city': 'City 1',
      'division': 'Division 1',
    },
    {
      'logo': 'Logo2',
      'businessName': 'Business Name 2',
      'city': 'City 2',
      'division': 'Division 2',
    },
    {
      'logo': 'Logo3',
      'businessName': 'Business Name 3',
      'city': 'City 3',
      'division': 'Division 3',
    },{
      'logo': 'Logo1',
      'businessName': 'Business Name 1',
      'city': 'City 1',
      'division': 'Division 1',
    },
    {
      'logo': 'Logo2',
      'businessName': 'Business Name 2',
      'city': 'City 2',
      'division': 'Division 2',
    },
    {
      'logo': 'Logo3',
      'businessName': 'Business Name 3',
      'city': 'City 3',
      'division': 'Division 3',
    },{
      'logo': 'Logo1',
      'businessName': 'Business Name 1',
      'city': 'City 1',
      'division': 'Division 1',
    },
    {
      'logo': 'Logo2',
      'businessName': 'Business Name 2',
      'city': 'City 2',
      'division': 'Division 2',
    },
    {
      'logo': 'Logo3',
      'businessName': 'Business Name 3',
      'city': 'City 3',
      'division': 'Division 3',
    },{
      'logo': 'Logo1',
      'businessName': 'Business Name 1',
      'city': 'City 1',
      'division': 'Division 1',
    },
    {
      'logo': 'Logo2',
      'businessName': 'Business Name 2',
      'city': 'City 2',
      'division': 'Division 2',
    },
    {
      'logo': 'Logo3',
      'businessName': 'Business Name 3',
      'city': 'City 3',
      'division': 'Division 3',
    },{
      'logo': 'Logo1',
      'businessName': 'Business Name 1',
      'city': 'City 1',
      'division': 'Division 1',
    },
    {
      'logo': 'Logo2',
      'businessName': 'Business Name 2',
      'city': 'City 2',
      'division': 'Division 2',
    },
    {
      'logo': 'Logo3',
      'businessName': 'Business Name 3',
      'city': 'City 3',
      'division': 'Division 3',
    },{
      'logo': 'Logo1',
      'businessName': 'Business Name 1',
      'city': 'City 1',
      'division': 'Division 1',
    },
    {
      'logo': 'Logo2',
      'businessName': 'Business Name 2',
      'city': 'City 2',
      'division': 'Division 2',
    },
    {
      'logo': 'Logo3',
      'businessName': 'Business Name 3',
      'city': 'City 3',
      'division': 'Division 3',
    },{
      'logo': 'Logo1',
      'businessName': 'Business Name 1',
      'city': 'City 1',
      'division': 'Division 1',
    },
    {
      'logo': 'Logo2',
      'businessName': 'Business Name 2',
      'city': 'City 2',
      'division': 'Division 2',
    },
    {
      'logo': 'Logo3',
      'businessName': 'Business Name 3',
      'city': 'City 3',
      'division': 'Division 3',
    },{
      'logo': 'Logo1',
      'businessName': 'Business Name 1',
      'city': 'City 1',
      'division': 'Division 1',
    },
    {
      'logo': 'Logo2',
      'businessName': 'Business Name 2',
      'city': 'City 2',
      'division': 'Division 2',
    },
    {
      'logo': 'Logo3',
      'businessName': 'Business Name 3',
      'city': 'City 3',
      'division': 'Division 3',
    },
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      color: AppColors.backgroundGlitter,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ResponsiveHelper.isDesktop(context) ? DesktopView(data: vendorData) : MobileView(data :vendorData),
    );
  }
}
