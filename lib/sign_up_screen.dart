import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_do_list/loading.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  void _confirmSignup() async {
    if (_formKey.currentState!.validate()) {
      await secureStorage.write(key: 'username', value: userName.text);
      await secureStorage.write(key: 'password', value: password.text);
      await secureStorage.write(
          key: 'confirmpass', value: confirmPassword.text);
      await secureStorage.write(key: 'date', value: birthDate.text);
      Navigator.pop(context);
    }
  }

  String lang = 'E';
  @override
  Widget build(BuildContext context) {
    TextDirection direction =
        lang == 'A' ? TextDirection.rtl : TextDirection.ltr;
    return Directionality(
      textDirection: direction,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            'SIGNUP',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                height: 50.0,
                width: 50.0,
                child: ElevatedButton(
                  child: Text(
                    lang,
                    style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => LoadingScreen());
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                    setState(() {
                      if (lang == 'E') {
                        lang = 'A';
                      } else if (lang == 'A') {
                        lang = 'E';
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.0))),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: userName,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.purple,
                        ),
                        hintText: 'User Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter user name please!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      obscureText: true,
                      controller: password,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.purple,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password please!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: confirmPassword,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.purple.shade200,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      validator: (value) {
                        if (value != password.text) {
                          return 'Password do not match';
                        } else if (value == null || value.isEmpty) {
                          return 'Confirm your password please!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: birthDate,
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.purple,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        label: Text(
                          'Birth Date',
                          style: TextStyle(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onTap: () async {
                        DateTime? PickedDate = await showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.now().subtract(Duration(days: 365 * 18)),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (PickedDate != null) {
                          _selectedDate = PickedDate;
                          birthDate.text =
                              "${PickedDate.year}-${PickedDate.month.toString().padLeft(2, '0')}-${PickedDate.day.toString().padLeft(2, '0')}";
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your birth date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 50.0,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _confirmSignup();
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
