import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:megamart_admin/utils/height_width_mediaquery.dart';

import '../../../utils/button_styles/button_styles.dart';
import '../../../utils/colors.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '\DashboardScreen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.backgroundColor,
        width: HeightWidth.fullWidth(context),
        height: HeightWidth.fullHeight(context),
        child: Center(
          child: Column(
            children: [

              ElevatedButton(
                style: ButtonColors.dangerButtonStyle,
                onPressed: () {},
                child: Text('Primary Button'),
              ),
              SizedBox(height: 38,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFd0d3d6))
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xFFd0d3d6))
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ),
        // decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //     colors: AppColors.l,
    //     begin: Alignment.topLeft,
    //     end: Alignment.bottomRight,
    // ),
    ),
    );
  }
}
