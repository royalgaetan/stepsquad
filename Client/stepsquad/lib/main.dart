import 'package:flutter/material.dart';
import 'package:stepsquad/pages/home.dart';
import 'package:stepsquad/pages/login.dart';
import 'package:stepsquad/services/auth.methods.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:stepsquad/widgets/buildBackgroundImage.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    //
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Squad',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: isUserLogged(),
        builder: (context, snapshot) {
          // HAS ERROR
          if (snapshot.hasError) {
            return const Stack(
              children: [
                // Background
                BuildBackgroundImage(),

                Center(
                  child: Text(
                    'An error occured. Try Later!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            );
          }

          // HAS DATA : Displat the corresponding Screen
          if (snapshot.hasData) {
            print(snapshot.data == true ? 'User is logged in' : 'User isn\'t logged');
            if (snapshot.data == true) {
              return const Home();
            } else {
              return const LoginPage();
            }
          }

          // LOADER
          return const Stack(
            children: [
              // Background
              BuildBackgroundImage(),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Wait please...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
