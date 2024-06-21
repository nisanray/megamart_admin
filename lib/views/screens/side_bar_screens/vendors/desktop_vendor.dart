import 'package:flutter/material.dart';
import 'package:megamart_admin/utils/colors.dart';

class DesktopView extends StatelessWidget {
  final List<Map<String, String>> data;

  DesktopView({required this.data});

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
                _buildHeaderCell('BUSINESS NAME'),
                _buildHeaderCell('CITY'),
                _buildHeaderCell('DIVISION'),
                _buildHeaderCell('ACTION'),
                _buildHeaderCell('VIEW MORE'),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: data.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.sidebarAntiFlashWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        _buildDataCell(item['logo']!),
                        _buildDataCell(item['businessName']!),
                        _buildDataCell(item['city']!),
                        _buildDataCell(item['division']!),
                        _buildDataCell(
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Implement action for edit
                            },
                          ),
                        ),
                        _buildDataCell(
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              // Implement action for view more
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
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
