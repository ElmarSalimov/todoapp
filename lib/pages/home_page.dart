import 'package:app1/data/database.dart';
import 'package:app1/util/dialogue_box.dart';
import 'package:app1/util/to_do_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBox = Hive.box('myBox');
  final _textContoller = TextEditingController();
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void _onSaved() {
    setState(() {
      db.toDoList.add([_textContoller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogueBox(
            controller: _textContoller,
            onSaved: _onSaved,
            onCancelled: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
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
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return ToDoTile(
              taskName: db.toDoList[index][0],
              taskValue: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteTask: (value) => deleteTask(index));
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: createNewTask, child: const Icon(Icons.add)),
    );
  }
}
