// collection_manager.dart
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionManager {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> collections = ['vendors', 'products', 'users']; // Manually maintained list of collections

  Future<List<String>> fetchCollections() async {
    try {
      // Return the manually maintained list of collections
      return collections;
    } catch (e) {
      throw Exception('Error fetching collections: $e');
    }
  }

  Future<Map<String, dynamic>> fetchCollectionData(String collectionName) async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection(collectionName).get();
      Map<String, dynamic> collectionData = {};
      for (var doc in querySnapshot.docs) {
        collectionData[doc.id] = doc.data();
      }
      return collectionData;
    } catch (e) {
      throw Exception('Error fetching collection data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchDocumentData(String collectionName, String documentId) async {
    try {
      DocumentSnapshot documentSnapshot = await firestore.collection(collectionName).doc(documentId).get();
      return documentSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Error fetching document data: $e');
    }
  }
}
