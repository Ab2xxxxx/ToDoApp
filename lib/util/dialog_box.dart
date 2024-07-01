import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox({super.key, required this.controller, required this.onSave, required this.onCancel});

  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 104, 95, 95),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              cursorColor: const Color.fromARGB(255, 105, 146, 179),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
                hintStyle: TextStyle(color: Colors.white10),
              ),
              style: const TextStyle(color: Colors.white, decorationThickness: 0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "Save", onPressed: onSave),
                const SizedBox(width: 6,),
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}