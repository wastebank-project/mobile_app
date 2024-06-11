import 'package:flutter/material.dart';
import 'package:waste_app/domain/customers.dart';
import 'package:waste_app/presentation/page/customers_page/methods/detail_customers.dart';

class ListCustomers extends StatefulWidget {
  const ListCustomers({super.key});

  @override
  _ListCustomersState createState() => _ListCustomersState();
}

class _ListCustomersState extends State<ListCustomers> {
  late Future<List<dynamic>> futureNasabah;

  @override
  void initState() {
    super.initState();
    futureNasabah = _fetchAndSortCustomers();
  }

  Future<List<dynamic>> _fetchAndSortCustomers() async {
    List<dynamic> customers = await Customer().getCustomer();
    customers.sort((a, b) => a['name'].compareTo(b['name']));
    return customers;
  }

  Future<void> _refreshCustomerList() async {
    setState(() {
      futureNasabah = _fetchAndSortCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Nasabah')),
      body: FutureBuilder<List<dynamic>>(
        future: futureNasabah,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No nasabah found'));
          } else {
            return RefreshIndicator(
              onRefresh: _refreshCustomerList,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final nasabah = snapshot.data![index];
                  return ListTile(
                    title: Text(nasabah['name']),
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
    );
  }
}
