import 'package:crud_provider/modules/add_employee_page.dart';
import 'package:crud_provider/modules/home_page.dart';
import 'package:crud_provider/modules/login_page.dart';
import 'package:crud_provider/modules/register_page.dart';
import 'package:crud_provider/modules/update_employee_page.dart';
import 'package:crud_provider/modules/wrapper.dart';
import 'package:crud_provider/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/operation_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider<FirestoreDataProvider>(
          create: (_) => FirestoreDataProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Provider with Firebase',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme()
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => HomePage(),
          '/add-employee': (context) => const AddEmployeePage(),
          '/update-employee': (context) => const UpdateEmployeePage(documentId: '', name: '', email: '', phone: '',),
        },
      ),
    );
  }
}
