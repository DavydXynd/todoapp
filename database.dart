import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List<Map<String, dynamic>> toDoList = [];

  final _myBox = Hive.box('myBox');

  void createInitialData() {
    toDoList = [
      {
        "name": "Need buy 500g rice",
        "done": false,
        "createdAt": DateTime.now(),
      },
      {
        "name": "Make video in YouTube",
        "done": false,
        "createdAt": DateTime.now(),
      },
    ];
  }

  void loadData() {
    final data = _myBox.get('TODOLIST');

    if (data is List) {
      toDoList = data.map<Map<String, dynamic>>((item) {
        return {
          "name": item["name"].toString(),
          "done": item["done"] ?? false,
          "createdAt": item["createdAt"] is DateTime
              ? item['createdAt']
              : DateTime.parse(item['createdAt'].toString()),
        };
      }).toList();
    } else {
      toDoList = [];
    }
  }

  void updateDataBase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
