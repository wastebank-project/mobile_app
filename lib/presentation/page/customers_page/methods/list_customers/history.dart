import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TransactionHistoryPage extends StatefulWidget {
  final List<dynamic> history;
  final List<dynamic> withdrawals;
  final Map<String, String> wasteTypes;

  const TransactionHistoryPage({
    super.key,
    required this.history,
    required this.wasteTypes,
    required this.withdrawals,
  });

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate data fetching delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false; // Data loading complete
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Riwayat Penarikan Saldo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: widget.withdrawals.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ListView.builder(
                            itemCount: widget.withdrawals.length,
                            itemBuilder: (context, index) {
                              final withdrawal = widget.withdrawals[index];
                              return ListTile(
                                title: Text('Debit: Rp${withdrawal['amount']}'),
                                subtitle:
                                    Text('Tanggal: ${withdrawal['date']}'),
                              );
                            },
                          ),
                        )
                      : Lottie.network(
                          'https://lottie.host/495775b6-a6cb-4731-8323-6d53680088c4/6q4qGAIhJV.json',
                          width: 150,
                        ),
                ),
          const SizedBox(height: 10),
          const Text(
            'Riwayat Menabung',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: widget.history.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ListView.builder(
                            itemCount: widget.history.length,
                            itemBuilder: (context, index) {
                              final historyItem = widget.history[index];
                              final deposits = historyItem['deposits'] ?? [];
                              return ListTile(
                                title: Text(
                                    'Kredit: Rp${historyItem['totalBalance']}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tanggal: ${historyItem['date']}'),
                                    ...deposits.map<Widget>((deposit) {
                                      final wasteTypeName = widget.wasteTypes[
                                              deposit['wasteTypeId']] ??
                                          'Unknown Type';
                                      return Text(
                                          '${deposit['amount']} kg $wasteTypeName');
                                    }).toList(),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : Lottie.network(
                          'https://lottie.host/495775b6-a6cb-4731-8323-6d53680088c4/6q4qGAIhJV.json',
                          width: 150,
                        ),
                ),
        ],
      ),
    );
  }
}
