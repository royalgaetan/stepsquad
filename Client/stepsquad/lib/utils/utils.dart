import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

// CONSTANTS
String baseURL = 'http://192.168.8.23';
String pexelAPIKey = "bfO2zV2du4kfuqsraW9gI3j8lwm9SXtQAJ3yTAHOHz6vIRckTC6Y0C6k";

// Colors
Color kPrimaryColor = Colors.purple.shade600;

// Create Dio instance
Dio createDioInstance() {
  return Dio(BaseOptions(
    baseUrl: '$baseURL:3000',
  ));
}

// Snackbar
showSnackBar({required context, required content, Color? backgroundColor}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 13,
      ),
    ),
    backgroundColor: backgroundColor ?? Colors.black,
  ));
}

// Show Loader
void showFullLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
        ),
      );
    },
  );
}

// Hide Loader
void hideFullLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

// Get Only Usernames from list and remove the current user
List<String> removeAndExtractUsernames({required List<dynamic> data, required String currentUsername}) {
  // Remove the Current User from the list of all user
  data.removeWhere((element) {
    return (element["username"] as String).toLowerCase().trim() == currentUsername.toLowerCase().trim();
  });

  // Return only usernames from the list
  List<String> usernames = data.map((element) => element["username"].toString()).toList();

  return usernames;
}

// Get Random Date
DateTime generateRandomPastDate() {
  Random random = Random();
  DateTime now = DateTime.now();
  DateTime january2023 = DateTime(2023, 1, 1);
  Duration randomDuration = Duration(days: random.nextInt(now.difference(january2023).inDays.abs()));
  DateTime randomDate = now.subtract(randomDuration);
  return randomDate;
}

// Format Date
String formatDateTime(DateTime dateTime) {
  Duration timeAgo = DateTime.now().difference(dateTime);
  return timeago.format(DateTime.now().subtract(timeAgo));
}

// Show Confirmation Dialog
Future<bool?> showLogoutConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Dialog Title
              const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),

              // Dialog Content
              const Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20.0),

              // Action Buttons : Cancel and Logout
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Cancel Logout Button
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey.shade800),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false); // Return false if cancel is pressed
                    },
                  ),

                  // Logout Button
                  TextButton(
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 16.0, color: kPrimaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true); // Return true if logout is pressed
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
