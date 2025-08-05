import 'package:autopage/database.dart';
import 'package:autopage/theme.dart';
import 'package:flutter/material.dart';
import 'package:autopage/todo_tile.dart';
import 'package:autopage/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:intl/intl.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    super.initState();

    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
      sortTasks();
    }
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateDataBase();
    });
  }

  bool? get value => null;

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index]['done'] = !db.toDoList[index]['done'];
      db.updateDataBase();
      sortTasks();
    });
    createdAt:
    DateTime.now();
  }

  void openTaskDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: controller,
        onCancel: () {
          Navigator.of(context).pop();
        },
        onSave: () {
          final text = controller.text.trim();
          if (text.isNotEmpty) {
            setState(() {
              db.toDoList.add({
                'name': text,
                'done': false,
                'createdAt': DateTime.now(),
              });
            });
            Navigator.of(context).pop();
            db.updateDataBase();
          }
        },
      ),
    );
  }

  void sortTasks() {
    db.toDoList.sort((a, b) {
      final aDone = a['done'] as bool;
      final bDone = b['done'] as bool;
      if (aDone == bDone) return 0;
      return aDone ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 63, 217, 255),
      appBar: AppBar(
        title: Text('To do list'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(115, 63, 217, 255),
        titleTextStyle: TextStyle(fontSize: 25, color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openTaskDialog,
        child: const Icon(Icons.add),
      ),
      body: ImplicitlyAnimatedList<Map<String, dynamic>>(
        items: db.toDoList,
        areItemsTheSame: (a, b) => a['createdAt'] == b['createdAt'],,
        itemBuilder: (context, animation, item, index) {
          return SizeFadeTransition(
            animation: animation,
            child: ToDoTile(
              taskName: item['name'],
              taskCompleted: item['done'],
              onChanged: (value) => checkBoxChanged(value, index),
              createdAt: item['createdAt'],
              deleteFunction: (context) => deleteTask(index),
            ),
          );
        },
        removeItemBuilder: (context, animation, oldItem) {
          return FadeTransition(
            opacity: animation,
            child: ToDoTile(
              taskName: oldItem['name'],
              taskCompleted: oldItem['done'],
              onChanged: (_) {},
              createdAt: oldItem['createdAt'],
              deleteFunction: (_) {},
            ),
          );
        },
      ),
    );
  }
}
