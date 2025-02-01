import 'package:flutter/material.dart';
import 'package:provider_login/screens/login_screen.dart';


class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
            icon: Icon(Icons.logout_outlined)),
        title: Text('User'),
      ),
      body: Center(
        child: Text('User page'),
      ),
    );
  }
}
