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
      appBar: AppBar(
        title: const Text(
          'Registrasi Nasabah Baru',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Text(
              'Nama',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
            ),
            // const SizedBox(height: 80),
            // AddressWidgetTextField(
            //   hintText: 'Alamat',
            //   controller: addressController,
            // )
          ],
        ),
      ),
    );
  }
}
