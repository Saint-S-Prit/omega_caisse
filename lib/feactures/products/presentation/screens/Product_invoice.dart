import 'dart:async';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/utils/styles/color.dart';
import '../../../../core/utils/validation.dart';
import '../../data/cart_item_model.dart';
import '../bloc/cart/add_to_cart_bloc.dart';
import '../bloc/cart/add_to_cart_state.dart';

class ProductInvoice extends StatefulWidget {
  const ProductInvoice({super.key});

  @override
  State<ProductInvoice> createState() => _ProductInvoiceState();
}

class _ProductInvoiceState extends State<ProductInvoice> {
  String? address;
  String? fullName;
  String? phone;

  double sommeByProduct = 0;

  void calculateTotal() {
    sommeByProduct = 0;
    CartState state = context.read<CartBloc>().state;
    for (var cartItem in state.cartItems) {
      sommeByProduct += cartItem.price * cartItem.quantity;
    }
  }

  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
    calculateTotal();
    fullName = SharedPreferencesService.getFullName();
    phone = SharedPreferencesService.getPhoneNumber();
    address = SharedPreferencesService.getAddress();
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
          savedDevice = devices
              .firstWhere((device) => device.address == savedDeviceAddress);
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
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedTime = DateFormat('HH:mm:ss').format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: appPrincipalColor,
          ),
          onPressed: () {
            final cartBloc = context.read<CartBloc>();
            cartBloc.state.cartItems.clear();
            Navigator.of(context).pushNamed("/homeScreen");
          },
        ),
        centerTitle: true,
        title: Text(
          'Reçu',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: appPrincipalColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize
                .min, // Définissez la taille principale sur min pour que la colonne se rétrécisse pour s'adapter à ses enfants
            children: [
              SizedBox(
                height: 80,
                width: double.infinity,
                //color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "COMMANDE_00039197",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Date: ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '$formattedDate $formattedTime',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.cartItems.length,
                            itemBuilder: (context, index) {
                              CartItemModel carts = state.cartItems[index];
                              return buildInvoiceDisplay(
                                nameProduct: carts.name,
                                quantityProduct: carts.quantity,
                                unity: carts.unity.toString(),
                                priceProduct: carts.price,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 10),
                                child: Column(
                                  children: [
                                    BlocBuilder<CartBloc, CartState>(
                                      builder: (context, state) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              height: 60.0,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      appPrincipalColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0), // Ajustez le rayon de bordure ici
                                                  ),
                                                ),
                                                onPressed: _connected
                                                    ? () async {
                                                        Map<String, dynamic>
                                                            config = {};
                                                        config['width'] =
                                                            100; // Largeur de l'étiquette, en mm
                                                        config['gap'] =
                                                            2; // Espace entre les étiquettes, en mm

                                                        // Largeur totale de l'étiquette en dpi (100 mm * 8 dpi)
                                                        int labelWidthDpi =
                                                            100 * 8;

                                                        String header =
                                                            "RECU DE CAISSE";
                                                        int textWidth = header
                                                                .length *
                                                            8; // Approximativement 8 dpi par caractère

                                                        int xPosition =
                                                            (labelWidthDpi -
                                                                    textWidth) ~/
                                                                7;

                                                        // Position x, y en dpi, 1mm=8dpi
                                                        List<LineText> lines =
                                                            [];
                                                        lines.add(
                                                          LineText(
                                                            type: LineText
                                                                .TYPE_TEXT,
                                                            y: 10,
                                                            content: header,
                                                            x: xPosition,
                                                            size: 35,
                                                            weight: 5,
                                                          ),
                                                        );
                                                        lines.add(LineText(
                                                            type: LineText
                                                                .TYPE_TEXT,
                                                            x: 10,
                                                            y: 70,
                                                            content:
                                                                '                           '));
                                                        lines.add(LineText(
                                                            type: LineText
                                                                .TYPE_TEXT,
                                                            x: 10,
                                                            y: 30,
                                                            content:
                                                                '$fullName'));
                                                        lines.add(LineText(
                                                            type: LineText
                                                                .TYPE_TEXT,
                                                            x: 10,
                                                            y: 30,
                                                            content:
                                                                'Adresse: $address'));
                                                        lines.add(LineText(
                                                            type: LineText
                                                                .TYPE_TEXT,
                                                            x: 10,
                                                            y: 50,
                                                            content:
                                                                'Tel: $phone'));
                                                        lines.add(LineText(
                                                            type: LineText
                                                                .TYPE_TEXT,
                                                            x: 10,
                                                            y: 70,
                                                            content:
                                                                '-----------------------------'));
                                                        lines.add(LineText(
                                                            type: LineText
                                                                .TYPE_TEXT,
                                                            x: 10,
                                                            y: 90,
                                                            content:
                                                                'Date: $formattedDate $formattedTime'));
                                                        lines.add(LineText(
                                                            type: LineText
                                                                .TYPE_TEXT,
                                                            x: 10,
                                                              y: 130,
                                                              content:
                                                                  '----------------------------'));

                                                          int yPosition =
                                                              170; // Initial y position for items
                                                          for (var cartItem
                                                              in state
                                                                  .cartItems) {
                                                            lines.add(LineText(
                                                              type: LineText
                                                                  .TYPE_TEXT,
                                                              x: 10,
                                                              y: yPosition,
                                                              content:
                                                                  '${cartItem.quantity}${cartItem.unity ?? null}x${cartItem.name}',
                                                            ));

                                                            int pricePositionX =
                                                                labelWidthDpi -
                                                                    140; // Ajustez 140 selon les besoins

                                                            lines.add(LineText(
                                                              type: LineText
                                                                  .TYPE_TEXT,
                                                              x: pricePositionX,
                                                              y: yPosition,
                                                              content:
                                                                  '${Validation.formatBalance(cartItem.price * cartItem.quantity)} XOF',
                                                            ));

                                                            yPosition +=
                                                                20; // Increment y position for next item
                                                          }

                                                          lines.add(LineText(
                                                              type: LineText
                                                                  .TYPE_TEXT,
                                                              x: 10,
                                                              y: yPosition,
                                                              content:
                                                                  '---------------------------'));

                                                          yPosition +=
                                                              20; // Increment y position for total
                                                          num total = state
                                                              .cartItems
                                                              .fold(
                                                                  0,
                                                                  (sum, item) =>
                                                                      sum +
                                                                      (item.price *
                                                                          item.quantity),);

                                                          lines.add(
                                                                                                      LineText(
                                                              type: LineText
                                                                      .TYPE_TEXT,
                                                            x: 10,
                                                            y: yPosition,
                                                            weight: 5,
                                                            content: 'Total:'));

                                                        int totalPositionX =
                                                            labelWidthDpi -
                                                                170; // Ajustez 140 selon les besoins

                                                        lines.add(LineText(
                                                            type: LineText
                                                                .TYPE_TEXT,
                                                            x: totalPositionX,
                                                            y: yPosition,
                                                            weight: 5,
                                                            content:
                                                                '${Validation.formatBalance(total)} XOF'));
                                                        lines.add(
                                                          LineText(
                                                              type: LineText
                                                                  .TYPE_TEXT,
                                                              x: 10,
                                                              y: yPosition + 20,
                                                              content:
                                                                  '                           '),
                                                        );
                                                        lines.add(
                                                          LineText(
                                                              type: LineText
                                                                  .TYPE_TEXT,
                                                              x: 10,
                                                              y: yPosition + 40,
                                                              content:
                                                                  '                           '),
                                                        );

                                                        bool result =
                                                            await bluetoothPrint
                                                                .printLabel(
                                                                    config,
                                                                    lines);

                                                        setState(() {
                                                          tips = result
                                                              ? 'Impression réussie'
                                                              : 'Échec de l\'impression';
                                                        });
                                                      }
                                                    : null,
                                                child: const Text(
                                                  'Imprimer le reçu',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      10), // Espace entre la ListView.builder et le total à payer
                              Text(
                                'Total à payer :  ${Validation.formatPrice(sommeByProduct)} XOF',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildInvoiceDisplay(
          {required String nameProduct,
          required num quantityProduct,
          required String unity,
          required int priceProduct}) =>
      //Widget buildUserInfoDisplay({required IconData iconData, required String name,}) =>
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nameProduct,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        quantityProduct.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      unity.toString() != "null"
                          ? Text(
                              unity.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("X"),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${Format.formatSomme(priceProduct)} XOF',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              Divider(
                color: appPrincipalColor.withOpacity(0.2),
                thickness: 1,
              )
            ],
          ));
}
