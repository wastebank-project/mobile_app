import 'package:flutter/material.dart';

class WasteAppTextFieldsCustomer extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const WasteAppTextFieldsCustomer({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  State<WasteAppTextFieldsCustomer> createState() =>
      _WasteAppTextFieldsCustomerState();
}

class _WasteAppTextFieldsCustomerState
    extends State<WasteAppTextFieldsCustomer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffeeeeee),
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelStyle: const TextStyle(
            fontSize: 13,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
