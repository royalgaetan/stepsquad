import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepsquad/pages/home.dart';
import 'package:stepsquad/pages/login.dart';
import 'package:stepsquad/services/auth.methods.dart';
import 'package:stepsquad/utils/utils.dart';

import '../widgets/buildBackgroundImage.dart';
import '../widgets/buildButton.dart';
import '../widgets/buildTextField.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    // Dispose All Controllers
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  register() async {
    // Check username
    if (_usernameController.text.isEmpty || _usernameController.text.length < 4) {
      return showSnackBar(context: context, content: 'Username must be at least 3 characters long');
    }
    // Check password
    else if (_passwordController.text.isEmpty || _passwordController.text.length < 6) {
      return showSnackBar(context: context, content: 'Password must be at least 6 characters long');
    }

    // Check passwords confirmation
    else if (_passwordController.text != _confirmPasswordController.text) {
      return showSnackBar(context: context, content: 'Passwords do not match. Please re-enter your password.');
    }

    // Can Save User
    await saveUserInDatabase(context: context, username: _usernameController.text, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          const BuildBackgroundImage(),

          // Content
          ListView(
            shrinkWrap: true,
            reverse: true,
            padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
            children: [
              // Header - H1
              const Center(
                child: Text(
                  'Join Step Squad Now!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),

              const SizedBox(
                height: 13,
              ),

              // Header - H2
              Center(
                child: Text(
                  'And Discover the Beat Within You',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),

              // Username TextField
              BuildCustomTextField(
                isPassword: false,
                hintText: 'Username',
                textController: _usernameController,
              ),

              // Password TextField
              BuildCustomTextField(
                isPassword: true,
                hintText: 'Password',
                textController: _passwordController,
                onChange: ((val) {}),
              ),

              // Confirm Password Textfield
              BuildCustomTextField(
                isPassword: true,
                hintText: 'Confirm Password',
                textController: _confirmPasswordController,
              ),

              //  Login Button
              BuildCustomButton(
                onTap: register,
                text: 'Register',
              ),

              const SizedBox(
                height: 50,
              ),

              // Register Button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text('Already have an account? Login Here.'),
              ),
            ].reversed.toList(),
          ),
        ],
      ),
    );
  }
}
