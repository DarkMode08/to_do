// Proveedor de estado para la gestión de tareas en la aplicación.
import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';

enum TaskFilter { all, completed, pending }

// Esta clase utiliza el patrón `ChangeNotifier` para permitir la actualización,
// de la UI cuando se realizan cambios en la lista de tareas.
class TaskProvider extends ChangeNotifier {
  // Lista privada de tareas.
  final List<Task> _tasks = [];

  // Obtiene la lista de tareas.
  // List<Task> get tasks => _tasks;

  TaskFilter _filter = TaskFilter.all;

  List<Task> get tasks {
    switch (_filter) {
      case TaskFilter.completed:
        return _tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return _tasks.where((task) => !task.isCompleted).toList();
      default:
        return _tasks;
    }
  }

  TaskFilter get filter => _filter;

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  // Agrega una nueva tarea a la lista.
  // Se genera un ID único basado en la fecha y se notifica a los oyentes.
  void addTask(
      String title, String category, String description, String dateTime) {
    final newTask = Task(
        id: DateTime.now().toString(),
        title: title,
        category: category,
        description: description,
        dateTime: dateTime);
    _tasks.add(newTask);
    notifyListeners();
  }

  // Alterna el estado de completado de una tarea.
  // Busca la tarea por su ID y cambia su estado entre completado y no completado.
  void toggleTaskStatus(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
    }
  }

  // Funcion para Editar las Tareas
  void editTask(String id, String newTitle, String newCategory,
      String newdescription, String newdateTime) {
    // Encuentra el índice de la tarea cuyo id coincide con el id proporcionado.
    final taskIndex = _tasks.indexWhere((task) => task.id == id);

    // Si se encuentra la tarea (el índice no es -1), se actualiza.
    if (taskIndex != -1) {
      // Reemplaza la tarea en la lista con una nueva instancia actualizada.
      _tasks[taskIndex] = Task(
          id: id, // Mantiene el mismo id.
          title: newTitle, // Actualiza el título con el nuevo valor.
          category: newCategory, // Actualiza la categoría con el nuevo valor.
          description: newdescription,
          dateTime: newdateTime,
          isCompleted: _tasks[taskIndex]
              .isCompleted // Conserva el estado de completado actual.
          );

      // Notifica a los oyentes que hubo un cambio en la lista de tareas.
      notifyListeners();
    }
  }

  void deletedTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
