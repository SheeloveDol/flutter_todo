import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/pages/add.dart';
import 'package:todo_app/providers/todo_provider.dart';

// This is the homepage of the app. To consume the state, we need to use the ConsumerWidget and import the flutter_riverpod package
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  // The build method is where the UI is built and the state is consumed using the ref parameter
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(
        todoProvider); // Read the state of the todoProvider and gets the type from the models/todo.dart file

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Slidable(
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(onPressed: (context) => 
                      ref.watch(todoProvider.notifier).deleteTodo(index),
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    )
                    ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(onPressed: (context) => 
                      ref.watch(todoProvider.notifier).completeTodo(index),
                    icon: Icons.check,
                    backgroundColor: Colors.green,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    )
                    ],
                ),
                child: ListTile(
                  title: Text(todos[index].content),
                ));
          }),
      floatingActionButton: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the AddTodo page
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const AddTodo()));
          },
          child: const Text("Add a Todo"),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
