

//
// class ProductInvoice extends StatefulWidget {
//   const ProductInvoice({super.key});
//
//   @override
//   State<ProductInvoice> createState() => _ProductInvoiceState();
// }
//
// class _ProductInvoiceState extends State<ProductInvoice> {
//
//
//
//   double sommeByProduct = 0;
//   @override
//   void initState() {
//     super.initState();
//     calculateTotal();
//   }
//
//   void calculateTotal() {
//     sommeByProduct = 0;
//     CartState state = context.read<CartBloc>().state;
//     for (var cartItem in state.cartItems) {
//       sommeByProduct += cartItem.price * cartItem.quantity;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('dd/MM/yyyy').format(now);
//     String formattedTime = DateFormat('HH:mm:ss').format(now);
//
//
//     // Initialiser une liste pour stocker les objets JSON
//     List<Map<String, dynamic>> cartItemsJson = [];
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(
//             Icons.close,
//             color: appPrincipalColor,
//           ),
//           onPressed: () {
//             final cartBloc = context.read<CartBloc>();
//             cartBloc.state.cartItems.clear();
//             Navigator.of(context).pushNamed("/homeScreen");
//           },
//         ),
//         centerTitle: true,
//         title: Text(
//           'Reçu',
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.w700,
//             color: appPrincipalColor,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min, // Définissez la taille principale sur min pour que la colonne se rétrécisse pour s'adapter à ses enfants
//           children: [
//             const Text(
//               "COMMANDE_00039197",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20,),
//             const Text(
//               "Date",
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//             ),
//             Text(
//               '$formattedDate $formattedTime',
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 30,),
//             Expanded(
//               child:
//               BlocBuilder<CartBloc, CartState>(
//                 builder: (context, state) {
//                   return Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                               itemCount: state.cartItems.length,
//                               itemBuilder: (context, index) {
//                                 CartItemModel carts = state.cartItems[index];
//                                 // Convertir l'élément cartItem en JSON et l'ajouter à la liste cartItemsJson
//                                 cartItemsJson.add(carts.toJson());
//                                 return buildInvoiceDisplay(nameProduct: carts.name, quantityProduct: carts.quantity, unity: carts.unity.toString(), priceProduct: carts.price);
//                               },
//                             ),
//                       ),
//
//                       Container(
//                         height: 150,
//                         child: Column(
//                           children: [
//                             const SizedBox(height: 10), // Espace entre la ListView.builder et le total à payer
//                             Text(
//                               'Total à payer :  ${Validation.formatBalance(sommeByProduct)} XOF',
//                               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                    top: 5.0, bottom: 20.0),
//                               child: SubmitButtonCustom(
//                                 onPressed: () async {
//                                   // Créez une liste de produits pour la démonstration
//
//
//                                   // Créez le PDF
//                                  // Uint8List pdfData = await pdfInvoiceService.createInvoice(state.cartItems, sommeByProduct);
//
//                                   // Enregistrez et ouvrez le PDF
//                                   //await pdfInvoiceService.savePdfFile("invoice", pdfData);
//                                   Navigator.of(context).pushNamed("/testApp");
//                                 },
//                                 textSubmit: 'Imprimer le reçu',
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   );
//                 },
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget builds the display item with the proper formatting to display the user's info
//   Widget buildInvoiceDisplay({required String nameProduct, required num  quantityProduct, required String  unity, required int priceProduct}) =>
//       //Widget buildUserInfoDisplay({required IconData iconData, required String name,}) =>
//   Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         children: [
//            Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//                Text(nameProduct, style: const TextStyle(fontWeight: FontWeight.bold),),
//
//               Row(
//                 children: [
//                   Text(quantityProduct.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
//                   const SizedBox(width: 5,),
//                    unity.toString() != "null" ? Text(unity.toString(), style: const TextStyle(fontWeight: FontWeight.bold),): const SizedBox(),
//                   const SizedBox(width: 5,),
//                   const Text("X"),
//                   const SizedBox(width: 5,),
//                   Text('${Format.formatSomme(priceProduct)} XOF', style: const TextStyle(fontWeight: FontWeight.bold),),
//
//                 ],
//               )
//               ],
//           ),
//
//           Divider(
//             color: appPrincipalColor.withOpacity(0.2),
//             thickness: 1,
//           )
//         ],
//       ));
// }
//
//
//


import 'dart:async';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/cart/add_to_cart_bloc.dart';
import '../bloc/cart/add_to_cart_state.dart';





class PrintParam extends StatefulWidget {
  const PrintParam({super.key});

  @override
  State<PrintParam> createState() => _PrintParamState();
}

class _PrintParamState extends State<PrintParam> {





  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connexion réussie';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'deconnexion success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedDeviceAddress = prefs.getString('savedDeviceAddress');

      if (savedDeviceAddress != null) {
        // List<BluetoothDevice> devices = await bluetoothPrint.scanResults.first;
        // BluetoothDevice? savedDevice = devices.firstWhere(
        //       (device) => device.address == savedDeviceAddress,
        //   orElse: () => null,
        // );
        List<BluetoothDevice> devices = await bluetoothPrint.scanResults.first;
        BluetoothDevice? savedDevice;
        try {
          savedDevice = devices.firstWhere((device) => device.address == savedDeviceAddress);
        } catch (e) {
          savedDevice = null;
        }

        if (savedDevice != null) {
          bool success = await bluetoothPrint.connect(savedDevice);
          if (success) {
            setState(() {
              _device = savedDevice;
              _connected = true;
              tips = 'connexion réussie';
            });
          } else {
            setState(() {
              tips = 'Connexion échec';
            });
          }
        }
      }
    }
  }

  Future<void> saveDeviceAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedDeviceAddress', address);
  }

  Future<void> clearDeviceAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('savedDeviceAddress');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parametre imprimente'),
      ),
      body: RefreshIndicator(
        onRefresh: () => bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              const Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                stream: bluetoothPrint.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!.map((d) => ListTile(
                    title: Text(d.name ?? ''),
                    subtitle: Text(d.address ?? ''),
                    onTap: () async {
                      setState(() {
                        _device = d;
                      });
                      bool success = await bluetoothPrint.connect(d);
                      if (success) {
                        await saveDeviceAddress(d.address!);
                        setState(() {
                          _connected = true;
                          tips = 'connexion réussie';
                        });
                      } else {
                        setState(() {
                          tips = 'Connexion échec';
                        });
                      }
                    },
                    trailing: _device != null && _device!.address == d.address
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                  )).toList(),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: _connected ? null : () async {
                            if (_device != null && _device!.address != null) {
                              setState(() {
                                tips = 'connexion...';
                              });
                              bool success = await bluetoothPrint.connect(_device!);
                              setState(() {
                                tips = success ? 'connexion réussie' : 'Connexion échec';
                              });
                              if (success) {
                                await saveDeviceAddress(_device!.address!);
                              }
                            } else {
                              setState(() {
                                tips = 'veuillez sélectionner un appareil';
                              });
                            }
                          },
                          child: const Text('connecter'),
                        ),
                        const SizedBox(width: 10.0),
                        OutlinedButton(
                          onPressed: _connected ? () async {
                            setState(() {
                              tips = 'deconnection...';
                            });
                            await bluetoothPrint.disconnect();
                            await clearDeviceAddress();
                          } : null,
                          child: const Text('deconnecter'),
                        ),
                      ],
                    ),
                    const Divider(),
                    Column(
                      children: [
                        OutlinedButton(
                          onPressed: _connected ? () async {
                            Map<String, dynamic> config = {};
                            config['width'] = 100; // Largeur de l'étiquette, en mm
                            config['gap'] = 2; // Espace entre les étiquettes, en mm

                            // Largeur totale de l'étiquette en dpi (80 mm * 8 dpi)


                            // Position x, y en dpi, 1mm=8dpi
                            List<LineText> lines = [];
                            lines.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 70, content: 'Test'));
                            lines.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 70, content: '       '));
                            lines.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 70, content: '        '));
                            bool result = await bluetoothPrint.printLabel(config, lines);

                            setState(() {
                              tips = result ? 'Impression réussie' : 'Échec de l\'impression';
                            });
                          } : null,
                          child: Text('print test'),
                        ),

                      ],
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: bluetoothPrint.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data == true) {
            return FloatingActionButton(
              onPressed: () => bluetoothPrint.stopScan(),
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: () => bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
            );
          }
        },
      ),
    );
  }
}

