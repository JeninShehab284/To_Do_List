import 'package:flutter/material.dart';
import 'package:to_do_list/log_in_screen.dart';
import 'package:to_do_list/sign_up_screen.dart';
import 'loading.dart';

void main() {
  runApp(Welcome());
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.purple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logoo.png'),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInScreen()));
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.purple),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(35.0),
                      ),
                    );
                  }),
                  Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        'SIGNUP',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.purple),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(35.0),
                      ),
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
