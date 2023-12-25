import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onTap,
    required this.name,
    this.buttoncolor = Colors.blueAccent,
  });
  final Function() onTap;
  final String name;
  final Color buttoncolor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: const Size(200, 42),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        elevation: 5,
        backgroundColor: buttoncolor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
      onPressed: onTap,
      child: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
