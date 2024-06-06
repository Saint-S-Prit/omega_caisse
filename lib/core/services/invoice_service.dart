//
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:open_document/my_files/init.dart';
//
// import '../../feactures/products/data/cart_item_model.dart';
//
//
//
// class CustomRow {
//   final String description;
//   final String total;
//
//   CustomRow(this.description,this.total);
// }
//
// class PdfInvoiceService {
//   Future<Uint8List> createHelloWorld() {
//     final pdf = pw.Document();
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Center(
//             child: pw.Text("Hello World"),
//           );
//         },
//       ),
//     );
//
//     return pdf.save();
//   }
//
//   Future<Uint8List> createInvoice(List<CartItemModel> cartItemModel, sommeTotal) async {
//     final pdf = pw.Document();
//
//     final List<CustomRow> elements = [
//       CustomRow("Description",  "Total"),
//       for (var product in cartItemModel)
//         CustomRow(
//             "${product.quantity} x ${product.name}",
//             (product.quantity * product.price).toString()
//             //(product.vatInPercent * product.price).toStringAsFixed(2),
//         ),
//       CustomRow(
//         "Total",
//         "$sommeTotal XOF",
//       ),
//
//     ];
//     final image = (await rootBundle.load("assets/logo.png"))
//         .buffer
//         .asUint8List();
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Column(
//             children: [
//               pw.Image(pw.MemoryImage(image),
//                   width: 75, height: 75, fit: pw.BoxFit.cover),
//               // pw.Row(
//               //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     pw.Column(
//               //       children: [
//               //         pw.Text("Ouba pikine"),
//               //         pw.Text("Ouest Foire"),
//               //       ],
//               //     ),
//               //     pw.Column(
//               //       children: [
//               //         pw.Text("falloutall@gmail.com"),
//               //         pw.Text("781111111"),
//               //         pw.Text("COMMANDE_00050851")
//               //       ],
//               //     )
//               //   ],
//               // ),
//
//               pw.SizedBox(height: 25),
//               itemColumn(elements),
//               pw.SizedBox(height: 25),
//               pw.Text("Merci pour votre confiance, et à la prochaine fois"),
//             ],
//           );
//         },
//       ),
//     );
//     return pdf.save();
//   }
//
//
//   pw.Expanded itemColumn(products) {
//     return pw.Expanded(
//       child: pw.Column(
//         children: [
//           for (var element in products)
//             pw.Row(
//               children: [
//                 pw.Expanded(
//                     child: pw.Text(element.description,
//                         textAlign: pw.TextAlign.left)),
//                 // pw.Expanded(
//                 //     child: pw.Text(element.price,
//                 //         textAlign: pw.TextAlign.right)),
//                 // pw.Expanded(
//                 //     child:
//                 //     pw.Text(element.quantity, textAlign: pw.TextAlign.right)),
//                 pw.Expanded(
//                     child:
//                     pw.Text(element.total, textAlign: pw.TextAlign.right)),
//                 ],
//             )
//         ],
//       ),
//     );
//   }
//
//   Future<void> savePdfFile(String fileName, Uint8List byteList) async {
//     final output = await getTemporaryDirectory();
//     var filePath = "${output.path}/$fileName.pdf";
//     final file = File(filePath);
//     await file.writeAsBytes(byteList);
//     await OpenDocument.openDocument(filePath: filePath);
//   }
//
//   String getSumTotalForElement(price , quantity) {
//     // Calculer la somme des amounts des produits
//     int totalAmount = price * quantity;
//     return totalAmount.toString();
//   }
//
//
//
// }
//
//
//
//
//
//
// class Product {
//   final double quantity;
//   final String description;
//   late final int amount;
//
//   Product(this.quantity,this.description, this.amount);
// }