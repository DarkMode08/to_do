// Widget Para mostrar Las Cartas de Las Tareas.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/screens/task_form_screen.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final theme = Theme.of(context); // Obtén el tema actual

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskFormScreen(task: task),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Distribuye los elementos
            children: [
              // Primer Column: Checkbox
              Column(
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      taskProvider.toggleTaskStatus(task.id);
                    },
                    shape: const CircleBorder(),
                  ),
                ],
              ),

              // Segundo Column: Título, descripción, categoría y fecha
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          task.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.amberAccent.withOpacity(0.4),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 2), // Espaciado interno
                          child: Text(
                            task.category,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.description,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.dateTime,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.grey,
                    onPressed: () {
                      taskProvider.deletedTask(task.id);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
