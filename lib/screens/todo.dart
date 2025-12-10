import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:todo/widgets/todo_item.dart';

class Todo extends StatelessWidget {
  final String userId;
  const Todo({
    required this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(247, 3, 7, 0.612),
            Color.fromRGBO(240, 40, 43, 1),
            Color.fromRGBO(250, 53, 57, 0.986),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('My  TodoS',
                  style: GoogleFonts.aboreto(
                      fontSize: 44, fontWeight: FontWeight.bold)),
              TodoItem(userId: userId),
            ],
          ),
        ),
      ),
    );
  }
}
