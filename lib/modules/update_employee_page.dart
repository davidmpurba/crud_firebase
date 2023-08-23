import 'package:flutter/material.dart';
import 'package:crud_provider/providers/operation_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UpdateEmployeePage extends StatelessWidget {
  final String documentId;
  final String name;
  final String email;
  final String phone;

  const UpdateEmployeePage({
    super.key,
    required this.documentId,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final firestoreProvider =
        Provider.of<FirestoreDataProvider>(context, listen: false);

    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController phoneController = TextEditingController(text: phone);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: nameController),
            const SizedBox(height: 20),
            TextField(controller: emailController),
            const SizedBox(height: 20),
            TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                controller: phoneController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await firestoreProvider.updateUser(
                  documentId,
                  nameController.text,
                  emailController.text,
                  phoneController.text,
                );

                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
