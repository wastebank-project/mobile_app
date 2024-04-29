import 'package:flutter/material.dart';
import 'package:waste_app/presentation/page/login_page/login_screen.dart';

Widget LogoutButton(BuildContext context) => IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
      icon: Icon(Icons.logout),
      iconSize: 30,
    );
