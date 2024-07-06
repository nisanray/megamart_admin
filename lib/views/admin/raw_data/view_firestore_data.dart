import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/firestore_collection_manager.dart';
// import 'collection_manager.dart'; // Import the collection manager

class ViewFirestoreData extends StatefulWidget {
  @override
  _ViewFirestoreDataState createState() => _ViewFirestoreDataState();
}

class _ViewFirestoreDataState extends State<ViewFirestoreData> {
  final CollectionManager collectionManager = CollectionManager();
  FirebaseFirestore firestore = FirebaseFirestore.instance; // Initialize Firestore instance
  String? selectedCollection;
  String? selectedDocumentId;
  List<String> collections = [];
  List<String> documentIds = [];
  Map<String, dynamic>? documentData;
  DocumentSnapshot? lastDocument;
  bool isLoading = false;
  bool isFetchingDocumentIds = false;
  bool isFetchingCollections = false;
  bool hasMoreDocumentIds = true;
  bool hasMoreCollections = true;
  final int pageSize = 10;

  @override
  void initState() {
    super.initState();
    fetchCollections();
  }

  Future<void> fetchCollections({bool isInitialLoad = true}) async {
    if (isFetchingCollections || !hasMoreCollections) return;

    setState(() {
      isFetchingCollections = true;
    });

    try {
      List<String> newCollections = await collectionManager.fetchCollections();
      if (newCollections.isEmpty) {
        setState(() {
          hasMoreCollections = false;
        });
      } else {
        setState(() {
          collections.addAll(newCollections);
        });
      }
    } catch (e) {
      showMessage('Error fetching collections: $e');
    } finally {
      setState(() {
        isFetchingCollections = false;
      });
    }
  }

  Future<void> fetchDocumentIds({bool isInitialLoad = true}) async {
    if (isFetchingDocumentIds || !hasMoreDocumentIds || selectedCollection == null) return;

    setState(() {
      isFetchingDocumentIds = true;
    });

    try {
      Query query = firestore.collection(selectedCollection!).limit(pageSize);
      if (lastDocument != null && !isInitialLoad) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.isEmpty) {
        setState(() {
          hasMoreDocumentIds = false;
        });
      } else {
        lastDocument = querySnapshot.docs.last;
        List<String> newDocIds = querySnapshot.docs.map((doc) => doc.id).toList();
        setState(() {
          documentIds.addAll(newDocIds);
        });
      }
    } catch (e) {
      showMessage('Error fetching document IDs: $e');
    } finally {
      setState(() {
        isFetchingDocumentIds = false;
      });
    }
  }

  Future<void> viewDocument(String documentId) async {
    if (selectedCollection == null) return;

    setState(() {
      isLoading = true;
      documentData = null;
    });

    try {
      DocumentSnapshot documentSnapshot = await firestore.collection(selectedCollection!).doc(documentId).get();
      setState(() {
        documentData = documentSnapshot.data() as Map<String, dynamic>?;
        isLoading = false;
      });
    } catch (e) {
      showMessage('Error loading document: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> downloadCollectionData() async {
    if (selectedCollection == null) return;

    try {
      Map<String, dynamic> data = await collectionManager.fetchCollectionData(selectedCollection!);
      String jsonString = _formatJson(jsonEncode(data, toEncodable: customEncode));
      await saveJsonToFile(jsonString, '${selectedCollection!}_collection.json');
    } catch (e) {
      showMessage('Error downloading collection data: $e');
    }
  }

  Future<void> downloadDocumentData(String documentId) async {
    if (selectedCollection == null) return;

    try {
      Map<String, dynamic> data = await collectionManager.fetchDocumentData(selectedCollection!, documentId);
      String jsonString = _formatJson(jsonEncode(data, toEncodable: customEncode));
      await saveJsonToFile(jsonString, '${documentId}_document.json');
    } catch (e) {
      showMessage('Error downloading document data: $e');
    }
  }

  String _formatJson(String jsonString) {
    var encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(jsonDecode(jsonString));
  }

  dynamic customEncode(dynamic item) {
    if (item is Timestamp) {
      return item.toDate().toIso8601String();
    }
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  Future<void> saveJsonToFile(String jsonString, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsString(jsonString);
      showMessage('File saved: ${file.path}');
    } catch (e) {
      showMessage('Error saving file: $e');
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  String formatValue(dynamic value) {
    if (value is Timestamp) {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(value.toDate());
    } else if (value is DateTime) {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(value);
    } else {
      return value.toString();
    }
  }

  Widget buildList(Map<String, dynamic> data, {double indent = 0.0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries.map((entry) {
        if (entry.value is Map) {
          return Padding(
            padding: EdgeInsets.only(left: indent + 16.0),
            child: ExpansionTile(
              title: Text(entry.key, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
              children: [buildList((entry.value as Map).cast<String, dynamic>(), indent: indent + 16.0)],
            ),
          );
        } else if (entry.value is List) {
          return Padding(
            padding: EdgeInsets.only(left: indent + 16.0),
            child: ExpansionTile(
              title: Text(entry.key, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
              children: (entry.value as List).map((item) {
                if (item is Map) {
                  return ExpansionTile(
                    title: Text('Item', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                    children: [buildList((item as Map).cast<String, dynamic>(), indent: indent + 16.0)],
                  );
                } else {
                  return ListTile(
                    title: Text(formatValue(item), style: TextStyle(color: Colors.black54)),
                  );
                }
              }).toList(),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(left: indent + 16.0),
            child: ListTile(
              title: Text(entry.key, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
              subtitle: Text(formatValue(entry.value), style: TextStyle(color: Colors.black54)),
            ),
          );
        }
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Operations - Any Collection'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: selectedCollection != null ? downloadCollectionData : null,
            tooltip: 'Download Collection Data',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (collections.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            if (collections.isNotEmpty)
              DropdownButton<String>(
                hint: Text('Select Collection'),
                value: selectedCollection,
                onChanged: (newValue) {
                  setState(() {
                    selectedCollection = newValue;
                    selectedDocumentId = null;
                    documentData = null;
                    documentIds.clear();
                    lastDocument = null;
                    hasMoreDocumentIds = true;
                    fetchDocumentIds();
                  });
                },
                items: collections.map((collection) {
                  return DropdownMenuItem(
                    child: Text(collection),
                    value: collection,
                  );
                }).toList(),
              ),
            if (!isFetchingCollections && hasMoreCollections)
              ElevatedButton(
                onPressed: () => fetchCollections(isInitialLoad: false),
                child: Text('Load More Collections'),
              ),
            if (documentIds.isEmpty && selectedCollection != null && !isFetchingDocumentIds)
              Text('No document IDs found.'),
            if (documentIds.isNotEmpty)
              DropdownButton<String>(
                hint: Text('Select Document ID'),
                value: selectedDocumentId,
                onChanged: (newValue) {
                  setState(() {
                    selectedDocumentId = newValue;
                    viewDocument(newValue!);
                  });
                },
                items: documentIds.map((docId) {
                  return DropdownMenuItem(
                    child: Text(docId),
                    value: docId,
                  );
                }).toList(),
              ),
            if (isFetchingDocumentIds && documentIds.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            if (!isFetchingDocumentIds && hasMoreDocumentIds && selectedCollection != null)
              ElevatedButton(
                onPressed: () => fetchDocumentIds(isInitialLoad: false),
                child: Text('Load More Document IDs'),
              ),
            if (isLoading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Loading document data...'),
              ),
            if (documentData != null)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildList(documentData!),
                        ElevatedButton(
                          onPressed: () => downloadDocumentData(selectedDocumentId!),
                          child: Text('Download Document JSON'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
