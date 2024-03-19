import 'package:flutter/material.dart';
import 'package:waste_app/presentation/page/home_page/methods/username.dart';
import 'package:waste_app/presentation/page/home_page/methods/logout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Username(context),
              LogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
