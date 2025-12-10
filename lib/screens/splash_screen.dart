import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 187, 9, 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                'assets/images/logo.png',
              ),
              width: 220,
              height: 220,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Task Manager",
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(fontSize: 23, color: Colors.white),
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("The smart choice for busy individuals!",
                style: GoogleFonts.lato(
                    textStyle:
                        const TextStyle(fontSize: 18, color: Colors.white),
                    decoration: TextDecoration.none)),
          ],
        ));
  }
}
