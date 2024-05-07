import 'package:app1/util/dialogue_box.dart';
import 'package:app1/util/to_do_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textContoller = TextEditingController();
  
  List ToDoList = [
    ["Task1", false],
    ["Task2", true],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      ToDoList[index][1] = !ToDoList[index][1];
    });
  }

  void _onSaved() {
    setState(() {
      ToDoList.add([_textContoller.text, false]);
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(context: context, builder: (context) {
      return DialogueBox(
        controller: _textContoller,
        onSaved: _onSaved,
        onCancelled: () => Navigator.of(context).pop(),
      );
    });
  }

  void deleteTask(int index) {
    setState(() {
      ToDoList.removeAt(index);
    });
  }

  void duplicateTask(int index) {
    setState(() {
      ToDoList.add(ToDoList[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          "TO DO APP",
          style: GoogleFonts.oldStandardTt(
              textStyle:
                  const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: ToDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return ToDoTile(
              taskName: ToDoList[index][0],
              taskValue: ToDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteTask: (value) => deleteTask(index),
              duplicateTask: (value) => duplicateTask(index),);
        },
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: createNewTask, child: const Icon(Icons.add)),
    );
  }
}
