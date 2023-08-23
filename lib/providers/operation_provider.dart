import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreDataProvider extends ChangeNotifier{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersStream() {
    return firestore.collection('employee').snapshots();
  }

  Future<void> createUser(String name, String email, String phone) async {
    try {
      await firestore.collection('employee').add({
        'name': name,
        'email': email,
        'phone': phone,
      });
    } catch (error) {
      print('Error creating user: $error');
    }
  }
  Future<void> updateUser(String documentId, String newName, String newEmail, String newPhone) async {
    try {
      await firestore.collection('employee').doc(documentId).update({
        'name': newName,
        'email': newEmail,
        'phone': newPhone,
      });
    } catch (error) {
      print('Error updating user: $error');
    }
  }

  Future<void> deleteUser(String documentId) async {
    try {
      await firestore.collection('employee').doc(documentId).delete();
    } catch (error) {
      print('Error deleting user: $error');
    }
  }
}

