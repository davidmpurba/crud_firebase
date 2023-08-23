import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreDataProvider extends ChangeNotifier{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersStream() {
    return firestore.collection('employee').snapshots();
  }

  Future<void> createUser(String name, String email, String phone) async {

    try {
      if (!isValidEmail(email)) {
        print('Invalid email format');
        return;
      }

      if (!isValidPhoneNumber(phone)) {
        print('Invalid phone number format');
        return;
      }
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
    if (!isValidEmail(newEmail)) {
      print('Invalid email format');
      return;
    }

    if (!isValidPhoneNumber(newPhone)) {
      print('Invalid phone number format');
      return;
    }

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

  bool isValidEmail(String email) {
    return email.contains('@');
  }

  bool isValidPhoneNumber(String phone) {
    return isNumeric(phone);
  }

  bool isNumeric(String s) {
    if (s == '') {
      return false;
    }
    return double.tryParse(s) != null;
  }

}

