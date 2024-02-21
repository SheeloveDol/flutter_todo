import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/pages/add.dart';
import 'package:todo_app/pages/completed.dart';
import 'package:todo_app/providers/todo_provider.dart';

// This is the homepage of the app. To consume the state, we need to use the ConsumerWidget and import the flutter_riverpod package
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  // The build method is where the UI is built and the state is consumed using the ref parameter
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(
        todoProvider); // Read the state of the todoProvider and gets the type from the models/todo.dart file

    // Filter out the completed todos
    List<Todo> activeTodos = todos.where((todo) => !todo.completed).toList();

    List<Todo> completedTodos = todos.where((todo) => todo.completed).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: activeTodos.length + 1,
          itemBuilder: (context, index) {
            if (activeTodos.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 350.0),
                child: Center(
                  child: Text("No todos yet! Add a todo to get started!"),
                ),
              );
            }
            // If the index is equal to the length of the activeTodos list, return a button to navigate to the CompletedTodo page
            if (index == activeTodos.length) {
              if (completedTodos.isEmpty)
                return Container();
              else {
                return Center(
                  child: TextButton(
                    child: const Text("Completed Todos"),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const CompletedTodo()),
                    ),
                  ),
                );
              }
            } else {
              return Container(
                margin: const EdgeInsets.all(8.0),
                child: Slidable(
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => ref
                              .watch(todoProvider.notifier)
                              .deleteTodo(activeTodos[index].todoId),
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18)),
                        )
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => ref
                              .watch(todoProvider.notifier)
                              .completeTodo(activeTodos[index].todoId),
                          icon: Icons.check,
                          backgroundColor: Colors.green,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18)),
                        )
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(18)),
                      child: ListTile(
                        title: Center(child: Text(activeTodos[index].content)),
                      ),
                    )),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddTodo page
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddTodo()));
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
