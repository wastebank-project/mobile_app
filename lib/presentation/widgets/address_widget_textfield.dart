import 'package:flutter/material.dart';

class AddressWidgetTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const AddressWidgetTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<AddressWidgetTextField> createState() => _AddressWidgetTextFieldState();
}

class _AddressWidgetTextFieldState extends State<AddressWidgetTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffeeeeee),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 200,
        child: TextField(
          controller: widget.controller,
          maxLines: null,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
