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
  List<dynamic> _withdrawals = [];
  Map<String, String> wasteTypes = {};
  int? _balance; // Store the customer's balance as int
  bool _isloading = true;

  // HAPUS CUSTOMER
  void _deleteCustomer(BuildContext context) async {
    bool? confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_amber,
            size: 50,
          ),
          iconColor: Colors.red,
          title: const Text(
            'PENGHAPUSAN NASABAH',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          content: const Text(
            'Setelah dihapus, anda tidak dapat memulihkan nasabah ini',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            SizedBox(
              width: 120,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0xffE66776),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  'Hapus Data',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 120,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: ButtonStyle(
                  side: WidgetStateProperty.all(
                      const BorderSide(color: Colors.black, width: 2.5)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: const Text(
                  'Batal',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
// FUNGSI PEMANGGILAN API TERHADAP KODE DIATAS

    if (confirmed == true) {
      setState(() {
        _isloading = true;
      });
      try {
        await Future.delayed(const Duration(seconds: 1));
        await Customer().deleteCustomer(widget.nasabah['id']);
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true);
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete customer: $e')),
        );
      } finally {
        setState(() {
          _isloading = false;
        });
      }
    }
  }

  // Fetch customer withdrawal history (liquidity)
  Future<void> fetchCustomerWithdrawals() async {
    setState(() {
      _isloading = true;
    });
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
    } finally {
      setState(() {
        _isloading = false;
      });
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
    setState(() {
      _isloading = true;
    });
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
    } finally {
      setState(() {
        _isloading = false;
      });
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
                      await fetchCustomerWithdrawals();
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionHistoryPage(
                              withdrawals: _withdrawals,
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
              'Tabungan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            _isloading
                ? const CircularProgressIndicator()
                : Text('Rp ${_balance ?? '0'}'),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
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
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff7ABA78)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      _deleteCustomer(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.red.shade400),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    child: _isloading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Hapus',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
