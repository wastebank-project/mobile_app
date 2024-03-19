import 'package:flutter/material.dart';

Widget Username(BuildContext context) => Row(
      children: [
        CircleAvatar(
          maxRadius: 23,
          backgroundColor: Colors.grey.shade300,
          child: const Icon(
            Icons.person,
            size: 30,
          ),
        ),
        SizedBox(width: 20),
        const Text(
          'Admin',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
