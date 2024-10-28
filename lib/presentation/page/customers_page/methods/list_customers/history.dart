import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          const SizedBox(height: 10),
          isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: widget.withdrawals.isNotEmpty
                      ? ListView.builder(
                          itemCount: widget.withdrawals.length,
                          itemBuilder: (context, index) {
                            final withdrawal = widget.withdrawals[index];
                            DateTime date = DateTime.parse(
                                widget.withdrawals[index]['date']);
                            String formattedDate =
                                DateFormat('EEEE, d MMMM yyyy HH:mm:ss')
                                    .format(date);
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 184, 204),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  title: Text(
                                    'Debit keluar: Rp${withdrawal['amount']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(formattedDate),
                                      Text('catatan ${withdrawal['note']}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
          const SizedBox(height: 10),
          isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: widget.history.isNotEmpty
                      ? ListView.builder(
                          itemCount: widget.history.length,
                          itemBuilder: (context, index) {
                            final historyItem = widget.history[index];
                            final deposits = historyItem['deposits'] ?? [];
                            DateTime date = DateFormat('dd/MM/yyyy')
                                .parse(widget.history[index]['date']);
                            String formattedDate =
                                DateFormat('EEEE, d MMMM yyyy HH:mm:ss')
                                    .format(date);
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffF6F4BD),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    'Kredit masuk: Rp${historyItem['totalBalance']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(formattedDate),
                                      ...deposits.map<Widget>((deposit) {
                                        final wasteTypeName = widget.wasteTypes[
                                                deposit['wasteTypeId']] ??
                                            '-';
                                        return Text(
                                            '${deposit['amount']} kg $wasteTypeName');
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
