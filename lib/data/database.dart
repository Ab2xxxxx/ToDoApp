import 'package:hive/hive.dart';

class ToDoDataBase{
  final _myBox = Hive.box('myBox');
  List todoTasks = [];

  void createInitialData(){
    todoTasks = [
      ["Add your tasks", false]
    ];
  }

  void loadData(){
    todoTasks = _myBox.get("ToDoTasks");
  }

  void updateData(){
    _myBox.put("ToDoTasks", todoTasks);
  }

}