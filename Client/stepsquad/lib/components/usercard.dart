import 'package:flutter/material.dart';
import 'package:stepsquad/utils/utils.dart';
import 'package:stepsquad/widgets/BuildCircleAvatar.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userId, required this.username, required this.joinedAt});

  final int userId;
  final String username;
  final DateTime joinedAt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: BuildCircleAvatar(radius: 22, photoIndex: userId),
      minLeadingWidth: 10,
      title: Text(
        username,
        style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Join us ${formatDateTime(joinedAt)}',
        style: TextStyle(color: kPrimaryColor, fontSize: 12, fontWeight: FontWeight.normal),
      ),
    );
  }
}
