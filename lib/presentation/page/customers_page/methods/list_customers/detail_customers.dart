import 'package:flutter/material.dart';
import 'package:waste_app/domain/customers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:waste_app/presentation/page/customers_page/methods/list_customers/history.dart';

class DetailCustomer extends StatefulWidget {
  final Map<String, dynamic> nasabah;

  const DetailCustomer({Key? key, required this.nasabah}) : super(key: key);

  @override
  _DetailCustomerState createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  List<dynamic> _history = [];
  Map<String, String> wasteTypes = {};

// MENGAMBIL DATA TIPE SAMPAH
  Future<void> fetchWasteTypes() async {
    final response = await http
        .get(Uri.parse('${dotenv.env['BASE_URL_BACKEND']}/wastetypes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        wasteTypes = {
          for (var e in data) e['id'] as String: e['name'] as String,
        };
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch history:')),
        );
      });
    }
  }

  // Fetch customer history from /tabung API
  Future<void> _fetchCustomerHistory() async {
    try {
      List<dynamic> history =
          await Customer().getCustomerHistory(widget.nasabah['name']);
      setState(() {
        _history = history;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch history: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWasteTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Detail Nasabah',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await _fetchCustomerHistory();
                      if (_history.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionHistoryPage(
                              history: _history,
                              wasteTypes: wasteTypes,
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.history))
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Nama',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(widget.nasabah['name']),
            const SizedBox(height: 20),
            const Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(widget.nasabah['email']),
            const SizedBox(height: 20),
            const Text(
              'Alamat',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 5),
            Text(widget.nasabah['address']),
            const SizedBox(height: 20),
            const Text(
              'Nomor Telepon',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 5),
            Text(widget.nasabah['phoneNumber']),
            const SizedBox(height: 75),
          ],
        ),
      ),
    );
  }
}
