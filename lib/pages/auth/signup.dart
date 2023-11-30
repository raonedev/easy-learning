import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/authTextField.dart';
import '../../common/color.dart';
import '../../main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    cpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 12, right: 12),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Center(
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  const Text(
                    "Sign up",
                    style: TextStyle(
                      color: AppColor.black,
                      fontFamily: "product",
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 50),
                  //username
                  AuthTextField(
                    control: username,
                    background: Colors.white,
                    hint: "username@email.com",
                    obsecure: false,
                  ),
                  const SizedBox(height: 25),
                  //password
                  AuthTextField(
                    control: password,
                    background: Colors.white,
                    hint: "* * * * * * *",
                    obsecure: true,
                  ),
                  const SizedBox(height: 25),
                  //Confirm password
                  AuthTextField(
                    control: cpassword,
                    background: Colors.white,
                    hint: " * * * * * * * * ",
                    obsecure: true,
                  ),
                  //button
                  const SizedBox(height: 40),
                  InkWell(
                    onTap: () =>
                        (username.text.isEmpty || password.text.isEmpty)
                            ? showToast("Field can't be Empty!")
                            : (!username.text.contains('@'))
                                ? showToast("Username has valid email id")
                                : (password.text != cpassword.text)
                                    ? showToast("password should be matched")
                                    : signUP(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 30),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "product",
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "already a member ? ",
                        style: TextStyle(
                            color: AppColor.black,
                            fontFamily: "product",
                            fontSize: 15),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text(
                            " sign in",
                            style: TextStyle(
                                color: Colors.blue,
                                fontFamily: "product",
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showToast(String? text) {
    FToast ftoast = FToast();
    ftoast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: AppColor.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(5)),
      child:
          Text(text.toString(), style: const TextStyle(color: AppColor.white)),
    );
    ftoast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 2),
        gravity: ToastGravity.BOTTOM);
  }

  Future signUP() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username.text.trim(),
        password: password.text.trim(),
      );
      showToast("now you can sign in");
    } on FirebaseAuthException catch (e) {
      showToast(e.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
