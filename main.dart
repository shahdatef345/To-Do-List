import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.white, // Background color of the scaffold
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // Background color of the AppBar
          foregroundColor:
              Colors.green[800], // Color of text and icons in the AppBar
          elevation: 0, // Remove shadow from AppBar
        ),
      ),
      home: TodoListScreen(),
    );
  }
}

class Todo {
  String title;
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];
  final TextEditingController _textController = TextEditingController();

  void _addTodo() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _todos.add(Todo(
          title: _textController.text,
        ));
        _textController.clear();
      });
    }
  }

  void _toggleTodoStatus(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, color: Colors.green[800]), // Book icon
            SizedBox(width: 8), // Space between icon and text
            Text(
              'To-Do List',
              style: TextStyle(
                color: Colors.green[800], // Dark green color for the title
                fontWeight: FontWeight.bold, // Bold text
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              cursorColor: Colors.green[800], // Green cursor color
              decoration: InputDecoration(
                labelText: 'Enter a new task',
                labelStyle: TextStyle(
                  color: Colors.green[800], // Green color for the label text
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.green[800]!, width: 2), // Dark green border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.green[800]!, width: 2), // Dark green border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.green[800]!, width: 2), // Dark green border
                ),
                hintText: 'Enter a new task',
                hintStyle: TextStyle(
                  color: Colors.green[800], // Green hint text color
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add,
                      color: Colors.green[800]), // Dark green + icon
                  onPressed: _addTodo,
                ),
              ),
            ),
            SizedBox(height: 10), // Space between input and button
            OutlinedButton(
              onPressed: _addTodo,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white, // Background color of the button
                side: BorderSide(
                    color: Colors.green[800]!, width: 2), // Dark green border
                padding: EdgeInsets.symmetric(
                    vertical: 12, horizontal: 20), // Padding
              ),
              child: Text(
                'Add Task',
                style: TextStyle(
                  color: Colors.green[800], // Text color
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            ),
            SizedBox(height: 10), // Space between button and list
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 4, // Shadow elevation
                    color: Colors.white, // Background color of the card
                    shadowColor: Colors.grey, // Shadow color
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          _toggleTodoStatus(index);
                        },
                        activeColor:
                            Colors.green, // Checkbox color when checked
                        checkColor: Colors
                            .white, // Checkbox color when checked (checkmark)
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.green),
                        onPressed: () {
                          _deleteTodo(index);
                        },
                      ),
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
