import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:megamart_admin/firebase_options.dart';
// import 'package:megamart_admin/screens/home.dart';
import 'package:megamart_admin/views/screens/main_screen.dart';
import 'package:megamart_admin/views/screens/something.dart';

Future<void> main() async {


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primarySwatch: Colors.blue),debugShowCheckedModeBanner: false,
      // home: MainScreen(),
      home: AdminDashboard(),
      builder: EasyLoading.init(),
      // home: HomeScreen(),
    );
  }
}
