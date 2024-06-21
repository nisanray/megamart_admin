import 'package:flutter/material.dart';
import 'package:megamart_admin/utils/colors.dart';

class ProductDesktopView extends StatelessWidget {
  final List<Map<String, String>> data;

  ProductDesktopView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Row
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderColor),
            ),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                _buildHeaderCell('LOGO'),
                _buildHeaderCell('NAME'),
                _buildHeaderCell('PRICE'),
                _buildHeaderCell('QUANTITY'),
                _buildHeaderCell('ACTION'),
                _buildHeaderCell('VIEW MORE'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String label) {
    return Expanded(
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataCell(dynamic content) {
    if (content is String) {
      return Expanded(
        child: Text(
          content,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Expanded(
        child: Center(child: content),
      );
    }
  }
}
