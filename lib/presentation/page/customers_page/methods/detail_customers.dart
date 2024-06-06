import 'package:flutter/material.dart';

class DetailCustomer extends StatelessWidget {
  final Map<String, dynamic> nasabah;

  const DetailCustomer({Key? key, required this.nasabah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nasabah['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${nasabah['name']}'),
            SizedBox(height: 8),
            Text('Phone Number: ${nasabah['phoneNumber']}'),
            SizedBox(height: 8),
            Text('Address: ${nasabah['address']}'),
          ],
        ),
      ),
    );
  }
}
