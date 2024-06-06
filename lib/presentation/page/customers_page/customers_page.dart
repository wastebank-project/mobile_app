import 'package:flutter/material.dart';
import 'package:waste_app/presentation/page/customers_page/methods/list_customers.dart';
import 'package:waste_app/presentation/page/customers_page/methods/new_customers.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 90, 25, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nasabah\nBank Sampah',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 130,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0Xff7ABA78),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff7ABA78)),
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                      color: Color(0xff7ABA78),
                                      width: 10,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NewCustomerScreen(),
                                      ));
                                },
                                icon: const Icon(Icons.person_add_alt_1_rounded,
                                    color: Colors.white),
                                label: const Text(
                                  'Daftar Nasabah Baru                   >',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Diperuntukkan untuk nasabah baru yang ingin menabung di bank sampah',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 130,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0Xff7ABA78),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff7ABA78)),
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                      color: Color(0xff7ABA78),
                                      width: 10,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListCustomers(),
                                      ));
                                },
                                icon: const Icon(Icons.people_sharp,
                                    color: Colors.white),
                                label: const Text(
                                  'Nasabah                                            >',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Berisi detail data nasabah bank sampah yang sudah terdaftar ',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 130,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0Xff7ABA78),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff7ABA78)),
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                      color: Color(0xff7ABA78),
                                      width: 10,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NewCustomerScreen(),
                                      ));
                                },
                                icon: const Icon(Icons.person_add_alt_1_rounded,
                                    color: Colors.white),
                                label: const Text(
                                  'Daftar Nasabah Baru                   >',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Diperuntukkan untuk nasabah baru yang ingin menabung di bank sampah',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// Center(
//                 child: SizedBox(
//                   width: 350,
//                   height: 55,
//                   child: TextButton(
//                     style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(const Color(0xFF7FB77E))),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => NewCustomer()));
//                     },
//                     child: const Text(
//                       'Registrasi Nasabah Baru',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               const Text(
//                 'Nasabah Baru',
//                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//               ),
//               const Text(
//                 'Diperuntukkan untuk nasabah baru yang ingin menabung di Bank Sampah',
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: SizedBox(
//                   width: 350,
//                   height: 55,
//                   child: TextButton(
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(
//                               const Color(0xFF7FB77E))),
//                       onPressed: () {},
//                       child: const Text(
//                         'Tabung Sampah',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold),
//                       )),
//                 ),
//               ),