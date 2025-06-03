import 'package:flutter/material.dart';
import 'package:to_do_list/days.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:to_do_list/setting_screen.dart';

class TaskScreen extends StatefulWidget {
  final String username;
  const TaskScreen({super.key, required this.username});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int selectedDay = 0;
  Map<int, List<Map<String, dynamic>>> taskByDay = {};

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTasks = prefs.getString('tasks');

    if (storedTasks != null) {
      Map<String, dynamic> decoded = json.decode(storedTasks);
      Map<int, List<Map<String, dynamic>>> loadedTasks = {};
      decoded.forEach((key, value) {
        List<Map<String, dynamic>> tasksList = List<Map<String, dynamic>>.from(
            (value as List).map((e) => Map<String, dynamic>.from(e)));
        loadedTasks[int.parse(key)] = tasksList;
      });

      setState(() {
        taskByDay = loadedTasks;
      });
    }
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> stringKeyMap =
        taskByDay.map((key, value) => MapEntry(key.toString(), value));

    String encoded = json.encode(stringKeyMap);
    await prefs.setString('tasks', encoded);
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _showAddDialog() {
    String newTask = '';

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add Task '),
              content: TextField(
                onChanged: (val) {
                  newTask = val;
                },
                decoration: InputDecoration(hintText: 'Enter task description'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (newTask.trim().isNotEmpty) {
                      setState(() {
                        taskByDay.putIfAbsent(selectedDay, () => []);
                        taskByDay[selectedDay]!
                            .add({'title': newTask, 'done': false});
                      });
                      _saveTasks();
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    List<Map<String, dynamic>> todayTasks = taskByDay[selectedDay] ?? [];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Welcome ${widget.username}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    fontFamily: 'Pacifico',
                    color: Colors.white),
              ),
              SizedBox(
                width: 10.0,
              ),
              Image.asset(
                'images/logoo.png',
                scale: 5.0,
              ),
            ],
          )),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            DaysDate(
                selectedIndex: selectedDay,
                onDaySelected: (index) {
                  setState(() {
                    selectedDay = index;
                  });
                }),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Tasks for the day:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
                child: todayTasks.isEmpty
                    ? Center(child: Text('No Tasks.'))
                    : ListView.builder(
                        itemCount: todayTasks.length,
                        itemBuilder: (context, index) {
                          final task = todayTasks[index];
                          return ListTile(
                            leading: IconButton(
                              icon: Icon(
                                task['done']
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color:
                                    task['done'] ? Colors.green : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  task['done'] = !task['done'];
                                });
                                _saveTasks();
                              },
                            ),
                            title: Text(
                              task['title'],
                              style: TextStyle(
                                decoration: task['done']
                                    ? TextDecoration.lineThrough
                                    : null,
                                color:
                                    task['done'] ? Colors.grey : Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  todayTasks.removeAt(index);
                                });
                                _saveTasks();
                              },
                            ),
                          );
                        }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TaskScreen(username: widget.username)));
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SettingScreen(username: widget.username)));
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ' '),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ' ')
        ],
      ),
    );
  }
}
