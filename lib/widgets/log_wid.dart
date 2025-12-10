import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/sign.dart';
import 'package:todo/screens/todo.dart';

class LogWid extends StatefulWidget {
  const LogWid({super.key});

  @override
  State<LogWid> createState() => _LogWidState();
}

class _LogWidState extends State<LogWid> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Future<void> check() async {
    try {
      final users = FirebaseFirestore.instance.collection('users').snapshots();

      users.forEach((element) {
        element.docs
            .map((data) => {

                  if (data['email'] == _emailController.text)
                    {
                      if (data["password"] == _passController.text)
                        {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Todo(userId: data.id),
                              )),
                        }
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Wrong details"))),
                          // return;
                        }
                    }
                })
            .toList();
      });
    } catch (e) {

    }

    if (_emailController.text.isEmpty == true ||
        _passController.text.isEmpty == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid details")));
    }

    // _emailController.clear();
    // _passController.clear();
  }

  var _obs = true;
  void _toglle() {
    setState(() {
      _obs = !_obs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 23),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(53), topRight: Radius.circular(53))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 80),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.message, color: Colors.red),
                      iconColor: Color.fromARGB(255, 247, 85, 73),
                      hintText: 'Email',
                      border: UnderlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: _passController,
                  obscureText: _obs,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _toglle();
                        },
                        icon: Icon(
                            _obs ? Icons.visibility_off : Icons.visibility),
                        color: const Color.fromARGB(255, 247, 85, 73),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.red),
                      iconColor: const Color.fromARGB(255, 247, 85, 73),
                      hintText: 'password',
                      border: const UnderlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  check();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 55, 41)),
                child: Text('Login',
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(color: Colors.white))),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Do not have an acount ? '),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ));
                      },
                      child: Text('Sign up',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 233, 54, 54)))))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
