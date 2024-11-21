import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:waste_app/domain/customers.dart';
import 'package:waste_app/presentation/page/customers_page/methods/list_customers/detail_customers.dart';
import 'package:waste_app/presentation/page/saving_page/methods/balance/tarik_saldo.dart';

class ListCustomers extends StatefulWidget {
  const ListCustomers({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListCustomersState createState() => _ListCustomersState();
}

class _ListCustomersState extends State<ListCustomers> {
  late Future<List<dynamic>> futureNasabah;
  List<dynamic> _allNasabah = [];
  List<dynamic> _filteredNasabah = [];

  @override
  void initState() {
    super.initState();
    futureNasabah = _fetchAndSortCustomers();
  }

// MENGAMBIL DAN MENGURUTKAN DATA NASABAH
  Future<List<dynamic>> _fetchAndSortCustomers() async {
    List<dynamic> customers = await Customer().getCustomer();
    // MENGURUTKAN BY NAME A-Z
    customers.sort((a, b) => a['name'].compareTo(b['name']));
    _allNasabah = customers;
    _filteredNasabah = customers;
    return customers;
  }

  Future<void> _refreshCustomerList() async {
    setState(() {
      futureNasabah = _fetchAndSortCustomers();
    });
  }

  void _filterCustomers(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNasabah = _allNasabah;
      } else {
        _filteredNasabah = _allNasabah.where((customer) {
          return customer['name'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 20, 20),
              child: Text(
                'Daftar Nasabah',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Cari Nama Nasabah',
                      suffixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 15,
                      ),
                    ),
                    onChanged: _filterCustomers,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: futureNasabah,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError && !snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Lottie.network(
                              'https://lottie.host/495775b6-a6cb-4731-8323-6d53680088c4/6q4qGAIhJV.json',
                              width: 250,
                              height: 250,
                            ),
                          ),
                          Text(
                            '${snapshot.error}',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: _refreshCustomerList,
                      child: ListView.builder(
                        itemCount: _filteredNasabah.length,
                        itemBuilder: (context, index) {
                          final nasabah = _filteredNasabah[index];
                          return ListTile(
                            title: Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xffF6F4BD),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 12, 0, 0),
                                child: Text(nasabah['name']),
                              ),
                            ),
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailCustomer(nasabah: nasabah),
                                ),
                              );
                              if (result == true) {
                                _refreshCustomerList();
                              }
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LiquidityCustomers(),
            ),
          );
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Image.asset('assets/png/wd.png'),
      ),
    );
  }
}
