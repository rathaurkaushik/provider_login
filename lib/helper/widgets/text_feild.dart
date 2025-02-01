import 'package:flutter/material.dart';
bool _isObscure3 = true;

Widget emailField(TextEditingController controller, String hintText) {
  return Card(
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        enabled: true,
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email cannot be empty";
        }
        if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+").hasMatch(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
      onChanged: (value) {},
      keyboardType: TextInputType.emailAddress,
    ),
  );
}


Widget passwordTextField({
  required TextEditingController passwordController,
  required bool isObscure,
  required Function() toggleObscure,
  required String hintText,
  required String? Function(String?) validator,
}) {
  return Card(
    child: TextFormField(
      controller: passwordController,
      obscureText: isObscure,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleObscure,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        enabled: true,
        contentPadding: const EdgeInsets.only(
            left: 14.0, bottom: 8.0, top: 15.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      onSaved: (value) {
        passwordController.text = value!;
      },
      keyboardType: TextInputType.text,
    ),
  );
}
