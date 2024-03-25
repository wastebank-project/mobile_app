import 'package:flutter/material.dart';
import 'package:waste_app/presentation/widgets/text_fields_customers.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Text('Nama'),
            WasteAppTextFieldsCustomer(
                hintText: 'Tulis nama nasabah baru disini',
                controller: nameController)
          ],
        ),
      ),
    );
  }
}
