import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:todo/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD8l_65uGMU9sPsg_GVlgyCGurQMi1H928",
            authDomain: "todo-list-8f116.firebaseapp.com",
            projectId: "todo-list-8f116",
            storageBucket: "todo-list-8f116.appspot.com",
            messagingSenderId: "458406532673",
            appId: "1:458406532673:web:9d04bc2e223e8e854b98c0"));
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA77pDOUFPq4FBxpP6NJLWenYKxPMw0Xfs",
            appId: "1:458406532673:android:5aba91da0295b9f04b98c0",
            messagingSenderId: "458406532673",
            projectId: "todo-list-8f116"));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: const SplashScreen(),
    );
  }
}
