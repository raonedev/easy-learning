import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackuniv/main.dart';
import '../../common/authTextField.dart';
import '../../common/color.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            color: AppColor.white,
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
                    "Login",
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
                    background: AppColor.backgroundColor,
                    hint: "username@email.com",
                    obsecure: false,
                  ),
                  const SizedBox(height: 25),
                  //password
                  AuthTextField(
                    control: password,
                    background: AppColor.backgroundColor,
                    hint: "* * * * * * *",
                    obsecure: true,
                  ),
                  //button
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      if (username.text.isEmpty || password.text.isEmpty) {
                        showToast("Field can't be Empty!");
                      } else if (!username.text.contains('@') ||
                          !username.text.contains('.')) {
                        showToast("Username has valid email id");
                      } else {
                        signIN();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30),
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "product",
                            fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // new member??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "new member ? ",
                        style: TextStyle(
                            color: AppColor.black,
                            fontFamily: "product",
                            fontSize: 15),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen())),
                        child: const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text(
                            " Register",
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
        gravity: ToastGravity.TOP);
  }

  Future signIN() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username.text.trim(),
        password: password.text.trim(),
      );
      // print("hi this is aman how are you");
    } on FirebaseAuthException catch (e) {
      showToast(e.toString());
      debugPrint(e.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
  }
}
