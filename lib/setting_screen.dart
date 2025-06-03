import 'package:flutter/material.dart';
import 'package:to_do_list/log_in_screen.dart';
import 'task_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key, required this.username});
  final String username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Welcome $username',
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskScreen(username: username)));
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingScreen(username: username)));
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ' '),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ' ')
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.purple, width: 2.0),
              backgroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LogInScreen(
                            clearFields: true,
                          )),
                  (Route<dynamic> route) => false);
            },
            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.purple),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'LOGOUT',
                    style:
                        const TextStyle(color: Colors.purple, fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
