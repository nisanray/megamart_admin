import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryAdd extends StatefulWidget {
  @override
  _CategoryAddState createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  List<Map<String, dynamic>> fields = [];

  void _addField() {
    setState(() {
      fields.add({
        'fieldName': '',
        'fieldType': 'text',
        'options': [],
      });
    });
  }

  void _saveCategory() async {
    // Adding category with fixed fields and additional fields
    await FirebaseFirestore.instance.collection('categories').add({
      'name': _nameController.text,
      'description': _descriptionController.text,
      'imageUrl': _imageUrlController.text,
      'fields': fields,
      'fixedFields': [
        {'fieldName': 'Product Name', 'fieldType': 'text'},
        {'fieldName': 'Description', 'fieldType': 'text'},
        {'fieldName': 'Offer Price', 'fieldType': 'number'},
        {'fieldName': 'Regular Price', 'fieldType': 'number'},
        {'fieldName': 'Stock', 'fieldType': 'number'},
      ],
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Category Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Category Description'),
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            Text('Fields', style: TextStyle(fontWeight: FontWeight.bold)),
            ...fields.map((field) {
              int index = fields.indexOf(field);
              return Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      fields[index]['fieldName'] = value;
                    },
                    decoration: InputDecoration(labelText: 'Field Name'),
                  ),
                  DropdownButton<String>(
                    value: field['fieldType'],
                    onChanged: (String? newValue) {
                      setState(() {
                        fields[index]['fieldType'] = newValue!;
                        if (newValue != 'dropdown') {
                          fields[index]['options'] = [];
                        }
                      });
                    },
                    items: <String>['text', 'number', 'dropdown', 'date']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  if (field['fieldType'] == 'dropdown')
                    Column(
                      children: [
                        ...field['options'].map<Widget>((option) {
                          int optionIndex = field['options'].indexOf(option);
                          return ListTile(
                            title: Text(option),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  fields[index]['options'].removeAt(optionIndex);
                                });
                              },
                            ),
                          );
                        }).toList(),
                        TextFormField(
                          onFieldSubmitted: (value) {
                            setState(() {
                              fields[index]['options'].add(value);
                            });
                          },
                          decoration: InputDecoration(labelText: 'Add Option'),
                        ),
                      ],
                    ),
                  Divider(),
                ],
              );
            }).toList(),
            ElevatedButton(
              onPressed: _addField,
              child: Text('Add Field'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveCategory,
              child: Text('Save Category'),
            ),
          ],
        ),
      ),
    );
  }
}
