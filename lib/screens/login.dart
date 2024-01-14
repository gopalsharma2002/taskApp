import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:todo/widgets/log_wid.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        // resizeToAvoidBottomPadding: true,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(247, 3, 7, 0.612),
            Color.fromRGBO(240, 40, 43, 1),
            Color.fromRGBO(250, 53, 57, 0.986),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text('Login',
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 30, color: Colors.white))),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Welcome Back !',
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 25, color: Colors.white)))),
              const LogWid(),
            ],
          ),
        ),
      ),
    );
  }
}
