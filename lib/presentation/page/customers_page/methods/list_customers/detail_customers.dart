import 'package:flutter/material.dart';
import 'package:waste_app/domain/customers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:waste_app/presentation/page/customers_page/methods/list_customers/edit_customers.dart';
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
  List<dynamic> _withdrawals = []; // Store withdrawal history
  Map<String, String> wasteTypes = {};
  int? _balance; // Store the customer's balance as int

  // Fetch customer withdrawal history (liquidity)
  Future<void> fetchCustomerWithdrawals() async {
    try {
      List<dynamic> withdrawals = await Customer().getLiquidity();
      // Filter withdrawal history by customer's name
      final customerWithdrawals = withdrawals
          .where((withdrawal) => withdrawal['name'] == widget.nasabah['name'])
          .toList();

      setState(() {
        _withdrawals = customerWithdrawals;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch withdrawals: $e')),
      );
    }
  }

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
          const SnackBar(content: Text('Failed to fetch waste types')),
        );
      });
    }
  }

  // Fetch customer balance
  Future<void> fetchCustomerBalance() async {
    try {
      List<dynamic> balances = await Customer().getBalance();
      // Find the balance for the current customer
      final customerBalance = balances.firstWhere(
        (balance) => balance['name'] == widget.nasabah['name'],
        orElse: () => null,
      );

      if (customerBalance != null) {
        setState(() {
          _balance = customerBalance['totalBalance']; // Store as int
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch balance: $e')),
      );
    }
  }

  // Fetch customer history
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
    fetchWasteTypes(); // Fetch waste types when the page is loaded
    fetchCustomerBalance(); // Fetch the balance when the page is loaded
    fetchCustomerWithdrawals(); // Fetch withdrawal history when the page is loaded
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
            const SizedBox(height: 20),
            const Text(
              'Saldo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            if (_balance != null) Text('Rp$_balance') else const Text('-'),
            const SizedBox(height: 20),
            const Text(
              'Riwayat Penarikan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            _withdrawals.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _withdrawals.length,
                      itemBuilder: (context, index) {
                        final withdrawal = _withdrawals[index];
                        return ListTile(
                          title: Text('Penarikan: ${withdrawal['amount']}'),
                          subtitle: Text('Tanggal: ${withdrawal['date']}'),
                        );
                      },
                    ),
                  )
                : const Text('Tidak ada riwayat penarikan.'),
            const SizedBox(height: 5),
            Center(
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the EditCustomerScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditCustomerScreen(nasabah: widget.nasabah),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xff7ABA78)),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Update Data',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
