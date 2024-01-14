import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/login.dart';

class SignWid extends StatefulWidget {
  const SignWid({super.key});

  @override
  State<SignWid> createState() => _SignWidState();
}

class _SignWidState extends State<SignWid> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> saveData() async {
    var mail = _emailController.text.isEmpty;
    var password = _passController.text.isEmpty;
    var name = _nameController.text.isEmpty;

    if (mail == true || password == true || name == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("please fill or details")));
    } else {
      try {
        CollectionReference user =
            FirebaseFirestore.instance.collection('users');

        final json = {
          "email": _emailController.text,
          "name": _nameController.text,
          "password": _passController.text,
        };

        user.add(json);

        setState(() {
          _nameController.clear();
          _passController.clear();

          _emailController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Your acount is created")));
      } catch (e) {
        String str = e.toString();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error -> $str")));
      }
    }
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
                padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.red),
                      hintText: 'full Name',
                      border: UnderlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.message, color: Colors.red),
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
                  obscureText: true,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _toglle();
                        },
                        icon: Icon(
                            _obs ? Icons.visibility_off : Icons.visibility),
                        color: const Color.fromARGB(255, 247, 85, 73),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.red,
                      ),
                      hintText: 'password',
                      border: UnderlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  saveData();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 55, 41)),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an Account ? '),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ));
                      },
                      child: Text('Log in',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 243, 59, 59)))))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
