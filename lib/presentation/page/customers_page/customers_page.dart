import 'package:flutter/material.dart';
import 'package:waste_app/presentation/page/customers_page/new_customers.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nasabah\nBank Sampah',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
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
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  height: 55,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFF2994A))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewCustomer()));
                    },
                    child: const Text(
                      'Registrasi Nasabah Baru',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
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
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  height: 55,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFFF2994A))),
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
