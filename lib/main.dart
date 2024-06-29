import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quickshare/homepage.dart';
import 'package:quickshare/homepage_phone.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        name: 'QuickShare App',
        options: const FirebaseOptions(
          apiKey: "AIzaSyDvHxywGBJ6S5koZOZqjuqCWoaAfQIQ07Q",
          messagingSenderId: "701304483150",
          appId: "1:701304483150:web:cac67d7058a79bb359021f",
          projectId: "quickshare-6919a",
        ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickShare',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: (screenWidth > 450) ? const homepage() : const HomePagePhone(),
    );
  }
}
