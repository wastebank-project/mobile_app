import 'package:flutter/material.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nasabah\nBank Sampah',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Nasabah Baru',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const Text(
                'Diperuntukkan untuk nasabah baru yang ingin menabung di Bank Sampah',
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SizedBox(
                  width: 280,
                  height: 55,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF7FB77E))),
                      onPressed: () {},
                      child: const Text(
                        'Registrasi Nasabah Baru',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              const Text(
                'Nasabah Baru',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const Text(
                'Diperuntukkan untuk nasabah baru yang ingin menabung di Bank Sampah',
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SizedBox(
                  width: 280,
                  height: 55,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF7FB77E))),
                      onPressed: () {},
                      child: const Text(
                        'Tabung Sampah',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
