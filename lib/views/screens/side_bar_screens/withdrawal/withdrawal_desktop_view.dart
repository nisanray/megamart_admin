import 'package:flutter/material.dart';
import 'package:megamart_admin/utils/colors.dart';

class WithdrawalDesktopView extends StatelessWidget {
  final List<Map<String, String>> data;

  WithdrawalDesktopView({required this.data});

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
                _buildHeaderCell('NAME'),
                _buildHeaderCell('AMOUNT'),
                _buildHeaderCell('BANK NAME'),
                _buildHeaderCell('BANK ACCOUNT'),
                _buildHeaderCell('EMAIL'),
                _buildHeaderCell('PHONE'),
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
