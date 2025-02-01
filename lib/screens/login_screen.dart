import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider_login/helper/widgets/text_feild.dart';

import 'package:provider_login/screens/admin_screen.dart';
import 'package:provider_login/screens/user_screen.dart';
import 'register_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 40,
                          ),
                        ),
                        emailField(emailController, 'Email'),
                        passwordTextField(
                          passwordController: passwordController,
                          isObscure: _isObscure3,
                          toggleObscure: () {
                            setState(() {
                              _isObscure3 = !_isObscure3;
                            });
                          },
                          hintText: 'Password',
                          validator: _passwordValidator,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            setState(() {
                              visible = true;
                            });
                            login(emailController.text.toString(),
                                passwordController.text.toString());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                          color: Colors.blue[900],
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible,
                          child: Container(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void route() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var checkProvider = await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (checkProvider.exists) {
        if (checkProvider.get('provider') == 'User') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserScreen(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Admin(),
              ));
        }
      } else {
        print('Email ID not found');
      }
    }
  }

  login(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        route();
      } on FirebaseAuthException catch (e) {
        setState(() {
          visible = false; // Hide the progress indicator after failure
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login failed: ${e.message}")));
      }
    }
  }

  String? _passwordValidator(String? value) {
    RegExp regex = RegExp(r'^.{6,}$');
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (!regex.hasMatch(value)) {
      return "Please enter a valid password (min. 6 characters)";
    }
    return null; // No error
  }
}
