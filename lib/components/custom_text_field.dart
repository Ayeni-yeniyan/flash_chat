import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.onTap,
      required this.hintTxt,
      this.obscureText = false,
      this.ispasswordKeyBoard = false});

  final Function(String) onTap;
  final String hintTxt;
  final bool obscureText;
  final bool ispasswordKeyBoard;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black, fontSize: 20),
      obscureText: obscureText,
      keyboardType:
          ispasswordKeyBoard ? TextInputType.text : TextInputType.emailAddress,
      onChanged: onTap,
      decoration: InputDecoration(
        labelText: hintTxt,
        labelStyle: const TextStyle(color: Colors.black38),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
