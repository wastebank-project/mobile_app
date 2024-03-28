import 'package:flutter/material.dart';
import 'package:waste_app/presentation/widgets/address_widget_textfield.dart';
import 'package:waste_app/presentation/widgets/text_fields_customers.dart';

// ignore: must_be_immutable
class NewCustomer extends StatelessWidget {
  NewCustomer({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Registrasi Nasabah',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Text(
              'Nama',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            WasteAppTextFieldsCustomer(
              hintText: 'Tulis nama nasabah baru disini',
              controller: nameController,
            ),
            const SizedBox(height: 30),
            const Text(
              'Alamat',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            AddressWidgetTextField(
                hintText: 'Alamat Nasabah Baru', controller: addressController),
            const SizedBox(height: 30),
            const Text(
              'Nomor Telepon',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            WasteAppTextFieldsCustomer(
              hintText: '08XXXXXXXXXX',
              controller: phoneNumberController,
              textInputTypeNumber: true,
              lengthLimit: true,
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                width: 350,
                height: 55,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFF2994A))),
                  onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
