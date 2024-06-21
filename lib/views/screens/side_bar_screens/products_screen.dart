import 'package:flutter/material.dart';


class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  static const String routeName = '\ProductScreen';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Text('Products',style: TextStyle(
            fontWeight: FontWeight.w700,fontSize: 36
        ),),
      ),
    );
  }
}
