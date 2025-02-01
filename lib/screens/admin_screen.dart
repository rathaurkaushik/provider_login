import 'package:flutter/material.dart';
import 'package:provider_login/screens/login_screen.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
            icon: Icon(Icons.logout_outlined)),
        centerTitle: true,
        title: Text('Admin'),
      ),
      body: Center(
        child: Text('Admin Page'),
      ),
    );
  }
}
