import 'package:flutter/material.dart';

class WasteAppTextFieldsCustomer extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool textInputTypeNumber;
  const WasteAppTextFieldsCustomer({
    Key? key,
    required this.hintText,
    required this.controller,
    this.textInputTypeNumber = false,
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
        color: const Color(0xffeeeeee),
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.textInputTypeNumber
            ? TextInputType.number
            : TextInputType.text,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
