import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/screens/task_form_screen.dart';
import 'package:to_do/screens/task_list_screen.dart';
import 'package:to_do/theme/app_theme.dart';

/// Utiliza `MultiProvider` para inyectar proveedores de estado en la aplicación,
/// permitiendo la gestión centralizada del estado.
void main() => runApp(MultiProvider(
      providers: [
        /// Proveedor para la gestión de tareas.
        ///
        /// `TaskProvider` permite agregar y modificar tareas, notificando a los widgets
        /// que dependen de su estado.
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        )
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routes: {
        '/': (context) => const TaskListScreen(),
        '/add-task': (context) => const TaskFormScreen(),
      },
    );
  }
}
