import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/to_do_tile.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {

  final _myBox = Hive.box('myBox');
  final _controller = TextEditingController();
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if(_myBox.get("ToDoTasks") == null){
      db.createInitialData();
    } else{
      db.loadData();
    }
    super.initState();
  }

  void saveNewTask(){
    setState(() {
      db.todoTasks.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void saveEditedTask(index){
    setState(() {
      db.todoTasks[index][0] = _controller.text;
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.todoTasks[index][1] = !db.todoTasks[index][1];
    });
    db.updateData();
  }

  void createNewTask(){
    _controller.clear();
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    db.updateData();
  }

  void deleteTask(int index){
    setState(() {
      db.todoTasks.removeAt(index);
    });
    db.updateData();
  }

  void editTask(int index){
    _controller.text = db.todoTasks[index][0];
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: () => saveEditedTask(index),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 67, 62, 62),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Center(
          child: Text("TO DO", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),)),
      ),
      body: (db.todoTasks.isEmpty) ? 
        const Center(child: Text("You don`t any have tasks", style: TextStyle(color: Colors.white),)) : 
        ListView.builder(
          itemCount: db.todoTasks.length,
          itemBuilder: (context, index){
            return ToDoTile(
              taskName: db.todoTasks[index][0], 
              taskCompleted: db.todoTasks[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
              editFunction: (context) => editTask(index),
            );
          }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_task),
      ),
    );
  }
}