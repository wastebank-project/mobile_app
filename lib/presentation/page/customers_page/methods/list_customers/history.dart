import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  final List<dynamic> history;
  final Map<String, String> wasteTypes;

  const TransactionHistoryPage(
      {super.key, required this.history, required this.wasteTypes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final historyItem = history[index];
          return ListTile(
            title: Text('Tanggal: ${historyItem['date']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kredit: Rp${historyItem['totalBalance']}'),
                ...historyItem['deposits'].map<Widget>((deposit) {
                  final wasteTypeName =
                      wasteTypes[deposit['wasteTypeId']] ?? 'Unknown Type';
                  return Text('${deposit['amount']} kg $wasteTypeName');
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
