import 'package:flutter/material.dart';
import 'package:waste_app/domain/customers.dart';

class DetailCustomer extends StatefulWidget {
  final Map<String, dynamic> nasabah;

  const DetailCustomer({Key? key, required this.nasabah}) : super(key: key);

  @override
  _DetailCustomerState createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  List<dynamic> _history = [];
  bool _isLoading = false;

  // Fetch customer history from /tabung API
  Future<void> _fetchCustomerHistory() async {
    setState(() {
      _isLoading = true;
    });

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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
            const Text(
              'Detail Nasabah',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
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
            // Add a button to fetch the history
            Center(
              child: ElevatedButton(
                onPressed: _fetchCustomerHistory,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Lihat History'),
              ),
            ),
            const SizedBox(height: 20),
            // Display history if fetched
            if (_history.isNotEmpty)
              const Text('Riwayat Transaksi:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Expanded(
              child: _history.isNotEmpty
                  ? ListView.builder(
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        final historyItem = _history[index];
                        return ListTile(
                          title: Text('Date: ${historyItem['date']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Total Balance: ${historyItem['totalBalance']}'),
                              ...historyItem['deposits'].map<Widget>((deposit) {
                                return Text(
                                    'Deposit Amount: ${deposit['amount']}');
                              }).toList(),
                            ],
                          ),
                        );
                      },
                    )
                  : const Text('No history available.'),
            ),
          ],
        ),
      ),
    );
  }
}
