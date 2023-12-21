import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
bool _obscureText = true;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 200),
            Text(
                "Welcome to WasteApp",
            style: TextStyle(
              fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              "Login",
              style: TextStyle(
                color: Color(0xFF7FB77E),
                fontSize: 42,
                fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 70),
            Container(
              decoration:
              BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffE0E0E0),
              ),
              child:
              TextField(
                decoration: InputDecoration(
                  hintText: "E-Mail",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0XFF7F7F7F)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration:
              BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffE0E0E0),
              ),
              child:
              TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0XFF7F7F7F)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                ),
              ),
            ),
            SizedBox(height: 80),
            TextButton(
              onPressed: (){
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF7FB77E)),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                ),
              ),
              child: const Text(
                  "Login Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
