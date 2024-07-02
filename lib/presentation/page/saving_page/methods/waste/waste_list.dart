import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:waste_app/domain/waste.dart';
import 'package:waste_app/presentation/page/saving_page/methods/waste/add_waste.dart';
import 'package:waste_app/presentation/page/saving_page/methods/waste/edit_waste.dart';
import 'package:waste_app/presentation/widgets/floating_icon_button.dart';

class WasteList extends StatefulWidget {
  const WasteList({super.key});

  @override
  _WasteListState createState() => _WasteListState();
}

class _WasteListState extends State<WasteList> {
  List<dynamic> wastes = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAndSortWastes();
  }

  Future<void> _fetchAndSortWastes() async {
    try {
      List<dynamic> fetchedWastes = await Waste().getWaste();
      fetchedWastes = fetchedWastes.map((waste) {
        waste['pricePerGram'] = waste['pricePerGram'];
        return waste;
      }).toList();
      fetchedWastes.sort((a, b) => a['name'].compareTo(b['name']));
      setState(() {
        wastes = fetchedWastes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void _updateWasteList(Map<String, dynamic> updatedWaste) {
    setState(() {
      int index =
          wastes.indexWhere((waste) => waste['id'] == updatedWaste['id']);
      if (index != -1) {
        wastes[index] = updatedWaste;
        wastes.sort((a, b) => a['name'].compareTo(b['name']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 5, 0, 20),
            child: Text(
              'Daftar Jenis Sampah',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage != null
                    ? Center(child: Text('Error: $errorMessage'))
                    : wastes.isEmpty
                        ? Center(child: Text('No nasabah found'))
                        : ListView.builder(
                            itemCount: wastes.length,
                            itemBuilder: (context, index) {
                              final sampah = wastes[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Container(
                                      height: 85,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffF6F4BD),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 20, 0, 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  sampah['name'],
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                    'Rp${sampah['pricePerGram']}/ons')
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  onPressed: () async {
                                                    final updatedWaste =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditWaste(
                                                                sampah: sampah),
                                                      ),
                                                    );
                                                    if (updatedWaste != null) {
                                                      _updateWasteList(
                                                          updatedWaste);
                                                    }
                                                  },
                                                  icon: const Icon(Icons.edit,
                                                      color: Colors.green),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
          ),
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(40),
            child: SizedBox(
              width: 60,
              child: FloatingIconButton(
                iconData: Icons.add,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddWaste()));
                },
                color: Colors.green,
                iconSize: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
