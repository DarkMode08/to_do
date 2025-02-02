// Clase
// Esta clase representa una tarea en una lista de tares pendientes.
class Task {
  final String id;
  final String title;
  final String category;
  final String description;
  final String dateTime;
  bool isCompleted;

  // Constructor
  // Este Constructor de la clase [Task]. Los campos de este son Requeridos.
  Task({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,
  });
}
