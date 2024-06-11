import 'package:flutter/material.dart';
import 'package:waste_app/presentation/widgets/date_picker.dart';
import 'package:waste_app/presentation/widgets/text_fields_customers.dart';

class SavingWasteScreen extends StatefulWidget {
  const SavingWasteScreen({super.key});

  @override
  State<SavingWasteScreen> createState() => _SavingWasteScreenState();
}

class _SavingWasteScreenState extends State<SavingWasteScreen> {
  // final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController wasteTypeIdController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String? _errorMessage;

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
              'Tabung Sampah',
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
              hintText: 'Nama Nasabah',
              controller: nameController,
            ),
            const SizedBox(height: 30),
            const Text(
              'Tanggal',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            WasteAppDatePicker(
                hintText: 'DD/MM/YYYY', controller: dateController),
            const SizedBox(height: 10),
            const SizedBox(height: 30),
            const Text(
              'Jenis Sampah',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            WasteAppTextFieldsCustomer(
              hintText: '08XXXXXXXXXX',
              controller: amountController,
              textInputTypeNumber: true,
              lengthLimit: true,
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
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
