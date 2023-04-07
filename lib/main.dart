import 'package:crud_functionality/screens/add_edit_user.dart';
import 'package:crud_functionality/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Functionality',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      routes: {
        "home": (context) => const Home(),
        "addEditUser": (context) => const AddEditUser()
      },
    );
  }
}
