import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WasteAppDatePicker extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool textInputTypeNumber;
  final bool lengthLimit;

  const WasteAppDatePicker({
    Key? key,
    required this.hintText,
    required this.controller,
    this.textInputTypeNumber = false,
    this.lengthLimit = false,
  }) : super(key: key);

  @override
  State<WasteAppDatePicker> createState() => _WasteAppDatePickerState();
}

class _WasteAppDatePickerState extends State<WasteAppDatePicker> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffeeeeee),
      ),
      child: TextFormField(
        controller: widget.controller,
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
          ),
          suffixIcon: const Icon(Icons.calendar_month),
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
