import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_do_list/task_screen.dart';
import 'loading.dart';
import 'sign_up_screen.dart';

class LogInScreen extends StatefulWidget {
  final bool clearFields;
  const LogInScreen({super.key, this.clearFields = false});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final FlutterSecureStorage secureStorage = FlutterSecureStorage();
final _formKey = GlobalKey<FormState>();
String lang = 'E';

class _LogInScreenState extends State<LogInScreen> {
  Future<void> _login(BuildContext context) async {
    String? savedusername = await secureStorage.read(key: 'username');
    String? savedpassword = await secureStorage.read(key: 'password');

    if (savedusername == null && savedpassword == null) {
      savedusername = usernameController.text;
      savedpassword = passwordController.text;
    }

    if (usernameController.text == savedusername &&
        passwordController.text == savedpassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Log in successfully')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TaskScreen(username: usernameController.text)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.clearFields) {
      usernameController.clear();
      passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextDirection direction =
        lang == 'A' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: direction,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('LOGIN'),
          backgroundColor: Colors.purple,
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: ElevatedButton(
                  child: Text(
                    lang,
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => LoadingScreen(),
                    );
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                    setState(() {
                      lang = (lang == 'E') ? 'A' : 'E';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Image.asset('images/logoo.png'),
                              SizedBox(height: 40.0),
                              TextFormField(
                                controller: usernameController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon:
                                      Icon(Icons.person, color: Colors.purple),
                                  hintText: 'User Name',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the userName';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.purple),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _login(context);
                                    }
                                  },
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text(
                            'Create New Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                              fontSize: 17.0,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.purple, width: 2.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
