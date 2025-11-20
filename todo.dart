import 'package:flutter/material.dart';

// 1. Main entry point: Runs the ToDoApp widget
void main() {
  runApp(const ToDoApp());
}

// 2. Root Widget: Provides Material Design styling for the entire app
class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To-Do List',
      theme: ThemeData(primarySwatch: Colors.blueGrey, useMaterial3: true),
      // Set the main screen to our stateful task manager
      home: const TaskManagerScreen(),
    );
  }
}

// 3. Stateful Widget: Manages the list of tasks (the 'state')
class TaskManagerScreen extends StatefulWidget {
  const TaskManagerScreen({super.key});

  @override
  State<TaskManagerScreen> createState() => _TaskManagerScreenState();
}

// 4. State Class: Contains the mutable data and the build logic
class _TaskManagerScreenState extends State<TaskManagerScreen> {
  // The mutable list of tasks (the 'state' we manage)
  final List<String> _tasks = [];

  // Controller for the text input field
  final TextEditingController _taskController = TextEditingController();

  // Function to add a new task to the list
  void _addTask() {
    // Check if the input field is not empty
    if (_taskController.text.isNotEmpty) {
      // setState tells Flutter to rebuild the widget
      setState(() {
        _tasks.add(_taskController.text);
      });
      // Clear the text field after adding the task
      _taskController.clear();
    }
  }

  // Function to delete a task at a specific index
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter To-Do List'),
        backgroundColor: Colors.blueGrey,
        elevation: 4,
      ),
      body: Column(
        children: <Widget>[
          // Input section (always visible at the top)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                // Flexible Text Field
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'New Task',
                      hintText: 'e.g., Buy groceries',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onSubmitted: (_) =>
                        _addTask(), // Add task on pressing Enter/Done
                  ),
                ),
                // Add Button
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _addTask,
                  // Use the 'Add' icon
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),

          // Task List (scrollable)
          Expanded(
            // ListView.builder is efficient for long lists
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                // Return a ListTile for each task item
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 16,
                  ),
                  child: ListTile(
                    // Display the task text
                    title: Text(
                      _tasks[index],
                      style: const TextStyle(fontSize: 18),
                    ),
                    // Action button to delete the task
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _deleteTask(index),
                    ),
                    // Optional: Add an icon to signify it's a list item
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.blueGrey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
