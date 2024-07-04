import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WasteAppTextFields extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final bool suffixIcon;
  final bool lengthLimit;

  final String hintText;

  const WasteAppTextFields({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon = false,
    this.lengthLimit = false,
  }) : super(key: key);

  @override
  State<WasteAppTextFields> createState() => _WasteAppTextFieldsState();
}

class _WasteAppTextFieldsState extends State<WasteAppTextFields> {
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffeeeeee),
      ),
      child: TextFormField(
        controller: widget.controller,
        inputFormatters: [
          widget.lengthLimit
              ? LengthLimitingTextInputFormatter(20)
              : LengthLimitingTextInputFormatter(null)
        ],
        obscureText: widget.obscureText && !_obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          suffixIcon: widget.suffixIcon
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
