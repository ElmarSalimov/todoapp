import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {

  List toDoList = [];
  
  final myBox = Hive.box('myBox');


  // First time ever opening the app
  void createInitialData() {
    toDoList = [
      ["Morning run", false],
      ["Exercise", false]
    ];
  }

  // Load the data
  void loadData() {
    toDoList = myBox.get("TODOLIST");
  }

  // Update the data
  void updateData() {
    myBox.put("TODOLIST", toDoList);
  }
}