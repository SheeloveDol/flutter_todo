import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/todo_provider.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Todo"),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Enter your todo",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
                // Add a new todo to the list by updating the state on button press
                onPressed: () {
                  ref.read(todoProvider.notifier).addTodo(controller.text);
                  // Navigate back to the home page
                  Navigator.pop(context);
                },
                child: const Text("Add Todo")),
          ],
        )));
  }
}
