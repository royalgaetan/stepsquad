import 'package:flutter/material.dart';
import 'package:stepsquad/pages/register.dart';
import 'package:stepsquad/services/auth.methods.dart';
import 'package:stepsquad/utils/utils.dart';
import 'package:stepsquad/widgets/buildBackgroundImage.dart';
import 'package:stepsquad/widgets/buildTextField.dart';

import '../widgets/buildButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    // Dispose All Controllers
    _usernameController.dispose();
    _passwordController.dispose();
  }

  performLoginUser() {
    // Check username
    if (_usernameController.text.isEmpty) {
      return showSnackBar(context: context, content: 'Username field cannot be empty. Please enter a username');
    }

    // log the user
    loginUser(context: context, password: _passwordController.text, username: _usernameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          const BuildBackgroundImage(),

          // Content
          Center(
            child: ListView(
              shrinkWrap: true,
              reverse: true,
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
              children: [
                // Header - H1
                const Center(
                  child: Text(
                    'Welcome to Step Squad',
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
                    'Explore, Connect, and Dance Like Never Before!',
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
                  hintText: 'Username',
                  textController: _usernameController,
                  isPassword: false,
                ),

                // Password TextField
                BuildCustomTextField(
                  hintText: 'Password',
                  textController: _passwordController,
                  isPassword: true,
                ),

                //  Login Button
                BuildCustomButton(
                  onTap: performLoginUser,
                  text: 'Login',
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
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text('Don\'t have an account? Register here.'),
                ),
              ].reversed.toList(),
            ),
          ),
        ],
      ),
    );
  }
}
