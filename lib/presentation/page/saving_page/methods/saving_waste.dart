import 'package:flutter/material.dart';
import 'package:waste_app/presentation/widgets/date_picker.dart';
import 'package:waste_app/presentation/widgets/text_fields_customers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:waste_app/presentation/widgets/waste_types.dart';

class SavingWasteScreen extends StatefulWidget {
  const SavingWasteScreen({super.key});

  @override
  State<SavingWasteScreen> createState() => _SavingWasteScreenState();
}

class _SavingWasteScreenState extends State<SavingWasteScreen> {
  // final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController wasteTypeController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String? _errorMessage;
  OverlayEntry? _overlayEntry;

  List<String> names = [];
  List<String> wasteTypes = [];
  List<Map<String, dynamic>> wasteItems = []; // List to store waste items

  void addWasteItem() {
    setState(() {
      wasteItems.add({'wasteType': '', 'amount': ''});
    });
  }

  @override
  void initState() {
    super.initState();
    fetchName();
    fetchWasteTypes();
    wasteItems.add({'wasteType': '', 'amount': ''}); // Start with one row
  }

// MENDAPATKAN NAMA BASED ON GET /NASABAH
  Future<void> fetchName() async {
    final response = await http
        .get(Uri.parse('https://backend-banksampah-api.vercel.app/nasabah'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        names = data.map((e) => e['name'] as String).toList();
        names.sort();
      });
    } else {
      setState(() {
        _errorMessage = 'Failed to load data';
      });
    }
  }

// MENDAPATKAN WASTE TYPE
  Future<void> fetchWasteTypes() async {
    final response = await http
        .get(Uri.parse('https://backend-banksampah-api.vercel.app/wastetypes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        wasteTypes = data.map((e) => e['name'] as String).toList();
        wasteTypes.sort();
      });
    } else {
      setState(() {
        _errorMessage = 'Failed to load data';
      });
    }
  }

// DROPDOWN NAME
  void _showDropdownName(BuildContext context, RenderBox renderBox) {
    final overlay = Overlay.of(context);
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: names.map((String name) {
                return ListTile(
                  title: Text(name),
                  onTap: () {
                    setState(() {
                      nameController.text = name;
                    });
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
  }

// FUNGSI UNTUK OVERLAY DROPDOWN WHEN PREVIOUS PAGE
  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    _showDropdownName(context, renderBox);
                  },
                  child: AbsorbPointer(
                    child: WasteAppTextFieldsCustomer(
                      hintText: 'Nama Nasabah',
                      controller: nameController,
                    ),
                  ),
                );
              },
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
            for (int i = 0; i < wasteItems.length; i++)
              WasteItemRow(
                index: i,
                wasteTypes: wasteTypes,
                onWasteTypeChanged: (value) {
                  setState(() {
                    wasteItems[i]['wasteType'] = value;
                  });
                },
                onAmountChanged: (value) {
                  setState(() {
                    wasteItems[i]['amount'] = value;
                  });
                },
              ),
            TextButton(
              onPressed: addWasteItem,
              child: const Text(
                '+ Tambah Sampah',
                style: TextStyle(color: Colors.green),
              ),
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
                    'Tabung',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
