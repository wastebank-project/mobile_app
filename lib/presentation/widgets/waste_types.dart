import 'package:flutter/material.dart';

class WasteType extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool textInputTypeNumber;
  final bool lengthLimit;

  const WasteType({
    Key? key,
    required this.hintText,
    required this.controller,
    this.textInputTypeNumber = false,
    this.lengthLimit = false,
  }) : super(key: key);

  @override
  State<WasteType> createState() => _WasteTypeState();
}

class _WasteTypeState extends State<WasteType> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: const Color(0xffeeeeee),
            ),
            child: TextField(
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
          ),
        ),
        const SizedBox(width: 50),
        Flexible(
          child: TextField(
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
        ),
      ],
    );
  }
}
