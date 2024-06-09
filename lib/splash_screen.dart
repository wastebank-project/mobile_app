import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waste_app/presentation/page/main_page/main_page.dart';
import 'package:waste_app/presentation/page/onboarding_page/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');

    // Check if authToken is available
    if (authToken != null) {
      String? username = prefs
          .getString('username'); // Retrieve username from shared preferences
      String? email = prefs.getString('email');
      // Navigate to home screen if user is already logged in
      Future.delayed(
        const Duration(seconds: 3),
        () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (_) => MainPage(
                      username: username ?? 'username',
                      email: email ?? 'email', // Pass the username to MainPage
                    )),
          );
        },
      );
    } else {
      // Navigate to onboarding screen if user is not logged in
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Onboarding_Screen()),
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/png/WasteApp.png',
          width: 250,
          height: 250,
        ),
      ),
    );
  }
}
