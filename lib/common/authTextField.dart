import 'package:flutter/material.dart';
import 'color.dart';

class AuthTextField extends StatelessWidget {
  final control;
  final String hint;
  final bool obsecure;
  final Color background;

  const AuthTextField({
    super.key,
    required this.hint,
    required this.obsecure,
    this.control,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        style: const TextStyle(
            fontFamily: "product", fontSize: 16, letterSpacing: 1.5),
        controller: control,
        obscureText: obsecure,
        maxLines: 1,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Error Message';
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: background,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500], fontFamily: "product"),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.white,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.red,
          )),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

//snack bar



                    // final snackBar = SnackBar(
                    //   content: const Text("please sign in"),
                    //   action: SnackBarAction(
                    //       label: 'ok',
                    //       onPressed: () => Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   const LoginScreen()))),
                    // );
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
