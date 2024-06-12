import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WasteItemRow extends StatefulWidget {
  final int index;
  final List<String> wasteTypes;
  final Function(String) onWasteTypeChanged;
  final Function(String) onAmountChanged;
  final Function(int) onDelete;
  final Function(int, int) onTotalChanged;

  const WasteItemRow({
    super.key,
    required this.index,
    required this.wasteTypes,
    required this.onWasteTypeChanged,
    required this.onAmountChanged,
    required this.onDelete,
    required this.onTotalChanged,
  });

  @override
  State<WasteItemRow> createState() => _WasteItemRowState();
}

class _WasteItemRowState extends State<WasteItemRow> {
  TextEditingController wasteTypeController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  OverlayEntry? _overlayEntry;

  List<String> wasteTypes = [];
  Map<String, int> wasteTypePrices = {}; // Map to store waste type and prices
  String selectedWasteType = ''; // Variable to store the selected waste type

  @override
  void initState() {
    super.initState();
    fetchWasteTypes();
  }

  Future<void> fetchWasteTypes() async {
    final response = await http
        .get(Uri.parse('https://backend-banksampah-api.vercel.app/wastetypes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        wasteTypes = data.map((e) => e['name'] as String).toList();
        wasteTypes.sort();
        wasteTypePrices = Map.fromIterable(
          data,
          key: (e) => e['name'] as String,
          value: (e) => e['pricePerKg'] as int,
        );
      });
    } else {
      setState(() {});
    }
  }

  int calculateTotal() {
    if (!wasteTypePrices.containsKey(selectedWasteType)) return 0;

    int amount =
        int.tryParse(amountController.text) ?? 0; // Handle invalid input
    return wasteTypePrices[selectedWasteType]! * amount;
  }

  void _showDropDownWaste(BuildContext context, RenderBox renderBox) {
    final overlay = Overlay.of(context);
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: wasteTypes.map((String wasteType) {
                return ListTile(
                  title: Text(wasteType),
                  onTap: () {
                    setState(() {
                      selectedWasteType = wasteType;
                      wasteTypeController.text = wasteType;
                      widget.onWasteTypeChanged(wasteType);
                      widget.onTotalChanged(widget.index, calculateTotal());
                    });
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  _showDropDownWaste(context, renderBox);
                },
                child: AbsorbPointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffeeeeee),
                    ),
                    child: SizedBox(
                      width: 230,
                      child: TextField(
                        controller: wasteTypeController,
                        decoration: InputDecoration(
                          hintText: 'Pilih Sampah',
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
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffeeeeee),
            ),
            child: SizedBox(
              width: 70,
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Berat',
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
                onChanged: (value) {
                  widget.onAmountChanged(value);
                  widget.onTotalChanged(widget.index, calculateTotal());
                },
              ),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              '${calculateTotal()}',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
