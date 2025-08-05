import 'package:flutter/material.dart';
import 'package:autopage/home.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final DateTime createdAt;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.createdAt,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            DateFormat('dd.MM.yyyy').format(createdAt),
            style: TextStyle(
              fontSize: 13,
              color: const Color.fromARGB(255, 129, 8, 8),
            ),
          ),
          const SizedBox(height: 5),
          Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: deleteFunction,
                  icon: Icons.delete,
                  backgroundColor: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: taskCompleted,
                      onChanged: onChanged,
                      activeColor: Colors.blueAccent,
                    ),
                    Text(
                      taskName,
                      style: TextStyle(
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: taskCompleted
                    ? const Color.fromARGB(115, 151, 45, 45)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
