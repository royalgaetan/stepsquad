import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:stepsquad/pages/login.dart';
import 'package:stepsquad/services/sharedpreferences.dart';
import '../pages/home.dart';
import '../utils/utils.dart';

// ############################################
// Login User and Redirect to HomePage
// ############################################

Future<void> loginUser({required BuildContext context, required String username, required String password}) async {
  // Show Loader and Add a delay
  showFullLoader(context);
  Future.delayed(const Duration(seconds: 1));

  try {
    // Create an instance of Dio
    Dio dio = Dio();

    // Make a POST request to the login endpoint
    Response response = await dio.post('$server/login', data: {
      'username': username.trim(),
      'password': password.trim(),
    });

    // Handle the response based on the status code
    // Remove Loader
    // ignore: use_build_context_synchronously
    hideFullLoader(context);

    if (response.statusCode == 200) {
      // Login successful and User Login Infos
      print('Login successful');
      saveUserLoginInfo(username: username, password: password);

      // Redirect to Home
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
  } on DioException catch (e) {
    // Handle DioException

    // Remove Loader
    // ignore: use_build_context_synchronously
    hideFullLoader(context);

    // Username doesn't exist
    if (e.response != null) {
      if (e.response!.statusCode == 401) {
        // ignore: use_build_context_synchronously
        return showSnackBar(context: context, content: 'Invalid credentials');
      }
    }

    // Handle other response errors
    return showSnackBar(context: context, content: 'Failed to login');
  }
}

// ############################################
// Register User in DB and Redirect to HomePage
// ############################################

saveUserInDatabase({required BuildContext context, required String username, required String password}) async {
  // Show Loader and Add a delay
  showFullLoader(context);
  Future.delayed(const Duration(seconds: 1));

  // Make API call to Node.js server using Dio
  Dio dio = Dio();
  try {
    Response response = await dio.post('$server/register', data: {
      'username': username.trim(),
      'password': password.trim(),
    });

    // Remove Loader
    // ignore: use_build_context_synchronously
    hideFullLoader(context);

    // Check the response status code
    if (response.statusCode == 200) {
      // Register successful and User Login Infos
      print('Register successful: ${response.data}');
      saveUserLoginInfo(username: username, password: password);

      // Redirect to Home
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
  } on DioException catch (e) {
    // Handle DioException

    // Remove Loader
    // ignore: use_build_context_synchronously
    hideFullLoader(context);

    // Username already exists
    if (e.response != null) {
      if (e.response!.statusCode == 409) {
        // ignore: use_build_context_synchronously
        return showSnackBar(context: context, content: 'Username already exists');
      }
    }

    // Handle other response errors
    return showSnackBar(context: context, content: 'Failed to register user');
  }
}

// ############################################
// Log Out
// ############################################

logoutUser({required BuildContext context}) async {
  // Show Loader and Add a delay
  showFullLoader(context);
  await Future.delayed(const Duration(seconds: 2));

  // Clear All User Login Infos
  clearUserLoginInfos();

  // Remove Loader
  // ignore: use_build_context_synchronously
  hideFullLoader(context);

  // Redirect to Login Page
  // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
}

// ############################################
// Get All Users
// ############################################
Future<List<dynamic>> getAllUsers() async {
  try {
    // Create an instance of Dio
    Dio dio = Dio();

    // Make a GET request to get all users
    Response response = await dio.get('$server/users');

    if (response.statusCode == 200) {
      return response.data as List<dynamic>;
    }

    // Return an empty list if the response status code is not 200
    return [];
  } on DioException catch (e) {
    // Handle DioException
    if (e.response != null) {
      // Handle response errors
      if (e.response!.statusCode == 500) {
        // Can't get Users
        // ignore: use_build_context_synchronously
        throw 'Failed to fetch users';
      }
    }
    throw 'An error occured. Try later !';
  }
}

// ############################################
// Verify if User is already logged in
// ############################################

Future<bool> isUserLogged() async {
  // Get username
  String username = await SharedPreferencesHelper.getUsername() ?? "";

  // Get password
  String password = await SharedPreferencesHelper.getPassword() ?? "";

  printUserLoginInfos();

  if (username.isNotEmpty && password.isNotEmpty) {
    // User is already logged in
    return true;
  }

  // User isn't logged in
  return false;
}

// ############################################
// Save User Login Info for future log
// ############################################

saveUserLoginInfo({required String username, required String password}) {
  // Set username
  SharedPreferencesHelper.setUsername(username);
// Set password
  SharedPreferencesHelper.setPassword(password);

  printUserLoginInfos();
}

// ############################################
// Clear All Login Info (= Clear SharedPreferences)
// ############################################

clearUserLoginInfos() {
  // Clear username
  SharedPreferencesHelper.setUsername('');
// Clear password
  SharedPreferencesHelper.setPassword('');

  printUserLoginInfos();
}

// ############################################
// Print User Login Info (Username, Password)
// ############################################

printUserLoginInfos() async {
  // Get Infos
  String username = await SharedPreferencesHelper.getUsername() ?? "";
  String password = await SharedPreferencesHelper.getPassword() ?? "";

  // Print Infos (In Console)
  print('Saved username: $username');
  print('Saved password: $password');
}
