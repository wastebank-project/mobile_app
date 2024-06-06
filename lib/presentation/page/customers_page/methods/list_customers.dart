import 'package:flutter/material.dart';
import 'package:waste_app/domain/customers.dart';
import 'package:waste_app/presentation/page/customers_page/methods/detail_customers.dart';

class ListCustomers extends StatefulWidget {
  @override
  _ListCustomersState createState() => _ListCustomersState();
}

class _ListCustomersState extends State<ListCustomers> {
  late Future<List<dynamic>> futureNasabah;

  @override
  void initState() {
    super.initState();
    futureNasabah = Customer().getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nasabah List')),
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final nasabah = snapshot.data![index];
                return ListTile(
                  title: Text(nasabah['name']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCustomer(nasabah: nasabah),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
