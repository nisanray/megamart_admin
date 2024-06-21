import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:megamart_admin/utils/colors.dart';

class MobileView extends StatelessWidget {
  final List<Map<String, String>> data;
  final ScrollController _horizontalScrollController = ScrollController();

  MobileView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scrollable data rows
        Positioned.fill(
          top: 90, // Adjust the top padding to match the height of the header
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: data.map((row) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _horizontalScrollController,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width, // Match parent width
                    decoration: BoxDecoration(
                      color: AppColors.whiteSmoak,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildDataCell(row['logo']!, width: 100.0), // Adjust width as needed
                          _buildDataCell(row['businessName']!, width: 200.0), // Adjust width as needed
                          _buildDataCell(row['city']!, width: 150.0), // Adjust width as needed
                          _buildDataCell(row['division']!, width: 150.0), // Adjust width as needed
                          _buildDataCell(
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Implement action for edit
                              },
                            ),
                            width: 100.0, // Adjust width as needed
                          ),
                          _buildDataCell(
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                // Implement action for view more
                              },
                            ),
                            width: 120.0, // Adjust width as needed
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        // Fixed header row
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalScrollController,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.borderColor),
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  _buildHeaderCell('LOGO', width: 100.0), // Adjust width as needed
                  _buildHeaderCell('BUSINESS NAME', width: 200.0), // Adjust width as needed
                  _buildHeaderCell('CITY', width: 150.0), // Adjust width as needed
                  _buildHeaderCell('DIVISION', width: 150.0), // Adjust width as needed
                  _buildHeaderCell('ACTION', width: 100.0), // Adjust width as needed
                  _buildHeaderCell('VIEW MORE', width: 120.0), // Adjust width as needed
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String label, {required double width}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataCell(dynamic content, {required double width}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: content is String
          ? Text(
        content,
        textAlign: TextAlign.center,
      )
          : Center(
        child: content,
      ),
    );
  }
}
