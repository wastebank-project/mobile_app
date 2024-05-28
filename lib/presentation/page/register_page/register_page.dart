import 'package:flutter/material.dart';
import 'package:waste_app/presentation/page/welcoming_page/welcoming_page.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const WelcomingPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 1000),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 50),
                const Text(
                  "Selamat Datang di WasteApp",
                  style: TextStyle(fontSize: 14),
                ),
                // const SizedBox(height: 5),
                const Text(
                  "Daftar Akun",
                  style: TextStyle(
                      color: Color(0xFF7FB77E),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30),
                const Text("Username"),
                const SizedBox(height: 3),
                WasteAppTextFields(
                  hintText: 'Ketik Username anda',
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                const Text("E-mail"),
                const SizedBox(height: 3),
                WasteAppTextFields(
                  hintText: 'Ketik e-mail anda',
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                const Text("Password"),
                const SizedBox(height: 3),
                WasteAppTextFields(
                  hintText: 'Ketik Password anda',
                  controller: passwordController,
                  obscureText: true,
                  suffixIcon: true,
                ),
                const SizedBox(height: 20),
                const Text("Konfirmasi Password"),
                const SizedBox(height: 3),
                WasteAppTextFields(
                  hintText: 'Ketik ulang Password anda',
                  controller: confPassword,
                  obscureText: true,
                  suffixIcon: true,
                ),
                const SizedBox(height: 60),
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
                    minimumSize: MaterialStateProperty.all(const Size(
                        350, 50)), // Set your custom width and height
                  ),
                  child: const Text("Daftar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
