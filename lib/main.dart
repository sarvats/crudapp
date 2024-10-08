import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];  //list of task
  final TextEditingController _taskController = TextEditingController();

  // Method to add a task
  void _addTask() {
    String taskName = _taskController.text;
    if (taskName.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: taskName));  //adding the task to listview
      });
      _taskController.clear();  //clear input
    }
  }

  //state for task completion
  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;  // Toggle task completion
    });
  }

  //to delete task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);  //remove task
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //input task and add button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter task name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Task list
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: _tasks[index].isCompleted,
                      onChanged: (_) => _toggleTaskCompletion(index),  //if completed
                    ),
                    title: Text(
                      _tasks[index].name,
                      style: TextStyle(
                        decoration: _tasks[index].isCompleted
                            ? TextDecoration.lineThrough  // show completed with linethrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteTask(index),  //deletes the task
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//holds task
class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
