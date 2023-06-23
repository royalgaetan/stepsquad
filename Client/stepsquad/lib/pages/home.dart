import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stepsquad/components/usercard.dart';
import 'package:stepsquad/pages/login.dart';
import 'package:stepsquad/widgets/BuildCircleAvatar.dart';
import '../services/auth.methods.dart';
import '../services/sharedpreferences.dart';
import '../utils/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = '';

  @override
  void initState() {
    super.initState();

    // Check if user is already logged in
    checkIfUserLogged();
  }

  checkIfUserLogged() async {
    bool isLoggedIn = await isUserLogged();

    // Not logged in : Redirect to LoginPage
    if (!isLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }

    // Is Logged : Update username
    String currentUsername = await SharedPreferencesHelper.getUsername() ?? '';
    setState(() {
      username = currentUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Step Squad',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          // Log Out Button
          Tooltip(
            message: 'Log out',
            child: IconButton(
              onPressed: () async {
                // Log Out
                bool? confirmed = await showLogoutConfirmationDialog(context);

                if (confirmed == true) {
                  // Perform logout action
                  // ignore: use_build_context_synchronously
                  logoutUser(context: context);
                } else {
                  // User cancelled logout
                  return;
                }
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,

      // BODY
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header - Card
              Padding(
                padding: const EdgeInsets.all(12),
                child: Card(
                  child: ListTile(
                    leading: const BuildCircleAvatar(radius: 22),
                    minLeadingWidth: 10,
                    title: RichText(
                      text: TextSpan(
                        text: 'Hi ',
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(text: username, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const TextSpan(text: '👋'),
                        ],
                      ),
                    ),
                    subtitle: const Text('What news?'),
                  ),
                ),
              ),

              // List Header
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Suggestions',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Display All Users - List
              FutureBuilder<List<dynamic>>(
                future: getAllUsers(),
                builder: (context, snapshot) {
                  // LOADING
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for data
                    return Column(
                      children: List.generate(
                        3,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade200,
                              highlightColor: Colors.grey.shade400,
                              child: const CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 22,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  // HAS ERROR
                  else if (snapshot.hasError) {
                    // Display an error message if an error occurs
                    return Center(child: Text('${snapshot.error}'));
                  }

                  // HAS DATA
                  else if (snapshot.hasData) {
                    // Display the data if available
                    final List<dynamic> data = snapshot.data!;

                    // Remove Current User From the list
                    final List<String> updatedList = removeAndExtractUsernames(data: data, currentUsername: username);

                    // List is not empty: display all users
                    if (updatedList.isNotEmpty) {
                      return Column(
                        children: updatedList
                            .map(
                              (el) => UserCard(
                                userId: updatedList.indexOf(el) + 1,
                                username: el,
                                joinedAt: generateRandomPastDate(),
                              ),
                            )
                            .toList(),
                      );
                    }

                    // List is empty
                    else {
                      // Display a message: because no data is available
                      return const Padding(
                        padding: EdgeInsets.all(30),
                        child: Center(
                            child: Text(
                          'No users found',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      );
                    }
                  } else {
                    // Display a message if no data is available
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
