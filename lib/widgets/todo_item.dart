import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:todo/todos.dart';

// ignore: must_be_immutable
class TodoItem extends StatefulWidget {
  TodoItem({
    super.key,
    required this.userId,
  });
  String userId;
  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  String? id;
  TextEditingController addTask = TextEditingController();
  var _editTask = TextEditingController();

  List<Todos> todolists = [
    Todos(id: '12', task: "Demo task", isChecked: false)
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void add(String todoStr, bool isCh) {
    CollectionReference todo = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('todos');

    final json = {
      'task': todoStr,
      // 'isChecked': isCh == true ? '1' : '0',
      'isChecked': isCh == true ? '1' : '0',
    };

    todo.add(json);

    setState(() {
      todolists.clear();
    });

    addTask.clear();
  }

  @override
  void initState() {
    setState(() {
      id = widget.userId;
    });
    super.initState();
    read();
  }

  // read list phle dekht h fir age delt or edit krte h...

  Future<void> read() async {
    // var  todo=FirebaseFirestore.instance.collection('todos').snapshots();
    var todo = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("todos")
        .snapshots();
    todo.forEach((element) {
      element.docs.forEach((data) {
        setState(() {
          todolists
              .add(Todos(task: data['task'], id: data.id, isChecked: true));
        });
      });
    });
  }

  void delete(String iid) {
    setState(() {
      _firestore
          .collection("users")
          .doc(id)
          .collection("todos")
          .doc(iid)
          .delete();

      todolists.clear();
    });
  }

  void edit(int i, String uid) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      shape: LinearBorder.bottom(),
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(23)),
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _editTask,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7),
                ),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    fillColor: const Color.fromARGB(255, 107, 17, 17),
                    hintText: 'Edit your Task',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 247, 58, 44)),
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 114, 20, 1)))),
              ),
            ),
            const Gap(20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 187, 211, 246),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      _firestore
                          .collection("users")
                          .doc(id)
                          .collection("todos")
                          .doc(uid)
                          .update({
                        "task": _editTask.text,
                      });

                      todolists[i].task = _editTask.text;
                      todolists.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 33),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(63), topRight: Radius.circular(63))),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 10),
                    child: TextField(
                      controller: addTask,
                      decoration: InputDecoration(
                          hintText: 'Add Task',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(26),
                          )),
                    ),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: const Color.fromARGB(255, 2, 100, 107)),
                    child: TextButton(
                        onPressed: () {
                          // String docId;
                          setState(() {
                            todolists.add(Todos(
                                id: 'id',
                                task: addTask.text,
                                isChecked: false));
                          });
                          add(addTask.text, false);
                          // add(addTask.text);
                        },
                        child: const Text('Save',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white))),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: todolists.length,
              itemBuilder: (context, index) => Container(
                color: const Color.fromARGB(255, 223, 221, 221),
                margin: const EdgeInsets.all(12),
                height: 50,
                child: Row(
                  children: [
                    Checkbox(
                        activeColor: const Color.fromARGB(255, 117, 241, 121),
                        value: todolists[index].isChecked,
                        onChanged: (val) {
                          setState(() {
                            todolists[index].isChecked =
                                !todolists[index].isChecked;
                            // checkValue.removeAt(index);
                            // checkValue.insert(index, temp);
                          });
                        }),
                    const Gap(12),
                    Text(todolists[index].task),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              delete(todolists[index].id);
                              setState(() {
                                todolists.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 252, 26, 10),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              edit(index, todolists[index].id);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 4, 236, 12),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
