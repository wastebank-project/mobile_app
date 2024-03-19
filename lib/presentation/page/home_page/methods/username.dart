import 'package:flutter/material.dart';

Widget Username(BuildContext context) => Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: const Icon(Icons.person),
        ),
        SizedBox(width: 15),
        const Text(
          'Admin',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
