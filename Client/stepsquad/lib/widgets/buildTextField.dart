import 'package:flutter/material.dart';
import 'package:stepsquad/utils/utils.dart';

class BuildCustomTextField extends StatelessWidget {
  const BuildCustomTextField({
    super.key,
    required this.hintText,
    required this.textController,
    this.onChange,
    required this.isPassword,
  });

  final String hintText;
  final bool isPassword;
  final TextEditingController textController;
  final Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade300,
      ),
      child: TextField(
        obscureText: isPassword,
        onChanged: onChange,
        cursorColor: kPrimaryColor,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
