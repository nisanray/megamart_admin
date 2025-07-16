import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ViewAndDownloadFirestoreData extends StatefulWidget {
  @override
  _ViewAndDownloadFirestoreDataState createState() => _ViewAndDownloadFirestoreDataState();
}

class _ViewAndDownloadFirestoreDataState extends State<ViewAndDownloadFirestoreData> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _collections = [];
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchCollections();
  }

  Future<void> _fetchCollections() async {
    DocumentSnapshot snapshot = await _firestore.collection('metadata').doc('collections').get();
    setState(() {
      _collections = List<String>.from((snapshot.data() as Map<String, dynamic>?)?['names'] ?? []);
    });
  }

  Future<void> _fetchData(String collectionName) async {
    QuerySnapshot querySnapshot = await _firestore.collection(collectionName).get();
    setState(() {
      _data = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  Future<void> _downloadData() async {
    if (await Permission.storage.request().isGranted) {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/firestore_data.txt';
      File file = File(filePath);
      String dataString = _data.map((e) => e.toString()).join('\n');
      await file.writeAsString(dataString);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data downloaded to $filePath')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Storage permission denied')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View and Download Firestore Data'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadData,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _collections.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_collections[index]),
                  onTap: () => _fetchData(_collections[index]),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_data[index].toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}