import 'package:flutter/material.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nasabah\nBank Sampah',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Text(
                'Nasabah Baru',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              Text(
                  'Diperuntukkan untuk nasabah baru yang ingin menabung di Bank Sampah'),
              SizedBox(
                height: 50,
              ),
              Text(
                'Nasabah Baru',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              Text(
                  'Diperuntukkan untuk nasabah baru yang ingin menabung di Bank Sampah'),
            ],
          ),
        ),
      ),
    );
  }
}
