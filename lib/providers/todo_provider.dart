// Installed flutter_riverpod package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';

// Setting up state notifier provider
final todoProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  // Add a new todo to the list by updating the state
  void addTodo(String content) {
    state = [
      ...state,
      Todo(
          todoId: state.isEmpty ? 0 : state[state.length - 1].todoId + 1,
          content: content,
          completed: false),
    ];
  }

  // Mark a todo as completed by updating the todo with the given id
  void completeTodo(int id) {
    state = [
      for (final todo in state)
        if (todo.todoId == id)
          Todo(
            todoId: todo.todoId,
            content: todo.content,
            completed: true,
          )
        else
          todo,
    ];
  }

  // Delete a todo by filtering out the todo with the given id
  void deleteTodo(int id) {
    state = state.where((todo) => todo.todoId != id).toList();
  }
}
