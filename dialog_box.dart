import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onSave;
  final void Function()? onCancel;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('New task'),
      content: TextField(
        maxLines: null,
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Input task',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('Cancel')),
        ElevatedButton(onPressed: onSave, child: const Text('Save')),
      ],
    );
  }
}
