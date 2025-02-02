// Pantalla para agregar una tarea

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;
  const TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late TextEditingController _titleController;
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateTimeController;
  final _formkey = GlobalKey<FormState>();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _titleController = TextEditingController(text: widget.task!.title);
      _categoryController = TextEditingController(text: widget.task!.category);
      _descriptionController =
          TextEditingController(text: widget.task!.description);
      _dateTimeController = TextEditingController(text: widget.task!.dateTime);
      _isEditing = true;
    } else {
      _titleController = TextEditingController();
      _categoryController = TextEditingController();
      _descriptionController = TextEditingController();
      _dateTimeController = TextEditingController();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // Formatea la fecha como "yyyy-MM-dd"
        _dateTimeController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white),
                        )),
                    keyboardType: TextInputType.text,
                    maxLength: 24,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please add title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Description (TextArea)
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        // Alinea la etiqueta con la parte superior
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white),
                        )),
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please add description'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  // TODO Category COmo Select
                  // Category
                  Row(
                    children: [
                      // Category Field
                      Expanded(
                        child: TextFormField(
                          controller: _categoryController,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add category';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                          width: 16), // Espaciado horizontal entre los campos
                      // DateTime Field
                      Expanded(
                        child: InkWell(
                          onTap: () => _selectDate(
                              context), // Abre el selector de fechas
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Date',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _dateTimeController.text.isEmpty
                                      ? 'Select a date'
                                      : _dateTimeController.text,
                                  style: TextStyle(
                                    color: _dateTimeController.text.isEmpty
                                        ? Colors.grey
                                        : Colors.white,
                                  ),
                                ),
                                const Icon(Icons.calendar_today,
                                    color:
                                        Colors.white70), // Ícono de calendario
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 144),
                ],
              ),
              // Botón de guardar/editar
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    if (_isEditing) {
                      taskProvider.editTask(
                        widget.task!.id,
                        _titleController.text,
                        _categoryController.text,
                        _descriptionController.text,
                        _dateTimeController.text,
                      );
                    } else {
                      taskProvider.addTask(
                        _titleController.text,
                        _categoryController.text,
                        _descriptionController.text,
                        _dateTimeController.text,
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(600, 50)),
                child: Text(_isEditing ? 'Save Change' : 'Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
