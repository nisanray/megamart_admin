import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class VendorProductManagementView extends StatelessWidget {
  static const String routeName = '\VendorProductManagementView';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VendorAddProduct(),));
            },
            child: Column(
              children: [
                Icon(Icons.add_circle_outlined,color: Colors.blueAccent.shade700,),
                Text("Add Product")
              ],
            ),
          )
        ],
      ),
    );
  }
}




class VendorAddProduct extends StatefulWidget {
  @override
  _VendorAddProductState createState() => _VendorAddProductState();
}

class _VendorAddProductState extends State<VendorAddProduct> {
  String? selectedCategoryId;
  Map<String, TextEditingController> _controllers = {};
  Map<String, List<String>> _dropdownOptions = {};
  List<Map<String, dynamic>> fields = [];
  List<Map<String, dynamic>> fixedFields = [];
  bool isLoading = false;

  void _loadFields(String categoryId) async {
    setState(() {
      isLoading = true;
    });

    DocumentSnapshot categorySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryId)
        .get();
    Map<String, dynamic> categoryData =
    categorySnapshot.data() as Map<String, dynamic>;

    setState(() {
      fixedFields = List<Map<String, dynamic>>.from(categoryData['fixedFields']);
      fields = List<Map<String, dynamic>>.from(categoryData['fields']);
      _controllers.clear();
      _dropdownOptions.clear();

      for (var field in fixedFields + fields) {
        _controllers[field['fieldName']] = TextEditingController();
        if (field['fieldType'] == 'dropdown') {
          _dropdownOptions[field['fieldName']] = [];
        }
      }
      isLoading = false;
    });
  }

  void _saveProduct() async {
    Map<String, dynamic> productData = {};
    _controllers.forEach((key, controller) {
      productData[key] = controller.text;
    });
    _dropdownOptions.forEach((key, options) {
      productData[key] = options;
    });

    await FirebaseFirestore.instance.collection('products').add(productData);
    Navigator.of(context).pop();
  }

  Widget _buildFieldItem(Map<String, dynamic> field) {
    String fieldName = field['fieldName'];
    String fieldType = field['fieldType'];

    if (fieldType == 'dropdown') {
      return Column(
        children: [
          TextFormField(
            controller: _controllers[fieldName],
            decoration: InputDecoration(labelText: fieldName),
          ),
          ..._dropdownOptions[fieldName]!.map((option) {
            return ListTile(
              title: Text(option),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _dropdownOptions[fieldName]!.remove(option);
                  });
                },
              ),
            );
          }).toList(),
          TextFormField(
            decoration: InputDecoration(labelText: 'Add Option'),
            onFieldSubmitted: (value) {
              setState(() {
                _dropdownOptions[fieldName]!.add(value);
              });
            },
          ),
        ],
      );
    } else {
      return TextFormField(
        controller: _controllers[fieldName],
        decoration: InputDecoration(labelText: fieldName),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var categories = snapshot.data!.docs;
                return DropdownButtonFormField<String>(
                  hint: Text('Select Category'),
                  value: selectedCategoryId,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategoryId = newValue;
                      if (newValue != null) {
                        _loadFields(newValue);
                      }
                    });
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(category['name']),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 20),
            Text('Fixed Fields', style: TextStyle(fontWeight: FontWeight.bold)),
            ...fixedFields.map((field) => _buildFieldItem(field)).toList(),
            SizedBox(height: 20),
            Text('Additional Fields', style: TextStyle(fontWeight: FontWeight.bold)),
            ...fields.map((field) => _buildFieldItem(field)).toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduct,
              child: Text('Save Product'),
            ),
          ],
        ),
      ),
    );
  }
}
