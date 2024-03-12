import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:waste_app/presentation/page/login_page/login_screen.dart';
import 'package:waste_app/presentation/widgets/text_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 120),
                const Text(
                  "Welcome to WasteApp",
                  style: TextStyle(fontSize: 16),
                ),
                // const SizedBox(height: 5),
                const Text(
                  "Register",
                  style: TextStyle(
                      color: Color(0xFF7FB77E),
                      fontSize: 42,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 70),
                WasteAppTextFields(
                  labelText: 'Name',
                  controller: nameController,
                ),
                const SizedBox(height: 15),
                WasteAppTextFields(
                  labelText: 'E-Mail',
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                WasteAppTextFields(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                  suffixIcon: true,
                ),
                const SizedBox(height: 15),
                WasteAppTextFields(
                  labelText: 'Confirm Password',
                  controller: confPassword,
                  obscureText: true,
                  suffixIcon: true,
                ),
                const SizedBox(height: 15),
              ],
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: "Sudah punya akun?",
                        style:
                            TextStyle(color: Color(0xFF7FB77E), fontSize: 11),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          LoginScreen(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        var offsetAnimation =
                                            animation.drive(tween);

                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                      transitionDuration:
                                          const Duration(milliseconds: 1000),
                                    ),
                                  );
                                },
                              text: ' Login Sekarang',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]),
                  ),
                  SizedBox(height: 80),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF7FB77E)),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                          Size(350, 50)), // Set your custom width and height
                    ),
                    child: const Text("Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
