// Crear widget para Mostrar Cada Tarea

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/widgets/elevation_button.dart';
import 'package:to_do/widgets/task_item.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF262626),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(12), // Espaciado interno
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilterButton(
                    label: 'All',
                    isSelected: taskProvider.filter == TaskFilter.all,
                    onPressed: () => taskProvider.setFilter(TaskFilter.all),
                    icon: SvgPicture.asset(
                      'lib/assets/icons/all.svg', // Ruta al archivo SVG
                      width: 24,
                      height: 24,
                      // ignore: deprecated_member_use
                      color: Colors.white, // Color del ícono
                    ),
                  ),
                  const SizedBox(width: 4), // Espacio entre botones
                  FilterButton(
                    label: 'Completed',
                    isSelected: taskProvider.filter == TaskFilter.completed,
                    onPressed: () =>
                        taskProvider.setFilter(TaskFilter.completed),
                    icon: SvgPicture.asset(
                      'lib/assets/icons/completed.svg', // Ruta al archivo SVG
                      width: 24,
                      height: 24,
                      // ignore: deprecated_member_use
                      color: Colors.white, // Color del ícono
                    ),
                  ),
                  const SizedBox(width: 4), // Espacio entre botones
                  FilterButton(
                    label: 'Pending',
                    isSelected: taskProvider.filter == TaskFilter.pending,
                    onPressed: () => taskProvider.setFilter(TaskFilter.pending),
                    icon: SvgPicture.asset(
                      'lib/assets/icons/pending.svg', // Ruta al archivo SVG
                      width: 24,
                      height: 24,
                      // ignore: deprecated_member_use
                      color: Colors.white, // Color del ícono
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return TaskItem(
                task: task,
              );
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add-task');
        },
        icon: SvgPicture.asset(
          'lib/assets/icons/add.svg',
          width: 24,
          height: 24,
          // ignore: deprecated_member_use
          color: const Color(0xFF1D617B),
        ),
        label: const Text(
          'Recordatorio',
          style: TextStyle(
            color: Color(0xFF1D617B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
