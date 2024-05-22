import 'package:flutter/material.dart';
import 'package:waste_app/presentation/page/login_page/login_screen.dart';

Widget LogoutButton(BuildContext context) => IconButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
      icon: Icon(Icons.logout),
      iconSize: 30,
    );
