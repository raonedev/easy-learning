import 'package:flutter/material.dart';

class HeadingMain extends StatelessWidget {
  const HeadingMain({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontFamily: "product"),
    );
  }
}
