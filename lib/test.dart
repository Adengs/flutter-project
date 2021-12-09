// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/src/widgets/navigator.dart';

// Future<void> main() async {
//   runApp(const PdfFile('Printing Demo'));
// }

// class PdfFile extends StatelessWidget {
//   const PdfFile(this.title, {Key key}) : super(key: key);

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text(title)),
//         body: PdfPreview(
//           build: (format) => _generatePdf(format, title),
//         ),
//       ),
//     );
//   }

//   Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
//     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true, );
//     final font = await PdfGoogleFonts.nunitoExtraLight();

//     pdf.addPage(
//       pw.Page(
//         pageFormat: format,
//         build: (context) {
//           return pw.Column(
//             children: [
//               pw.SizedBox(
//                 width: double.infinity,
//                 child: pw.FittedBox(
//                   child: pw.Text(title, style: pw.TextStyle(font: font)),
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//               pw.Flexible(child: pw.FlutterLogo())
//             ],
//           );
//         },
//       ),
//     );

//     return pdf.save();
//   }
// }

// class User {
//   final String name;
//   final int age;

//   const User({@required this.name, @required this.age});
// }

// class PdfApi {
//   static Future<File> generateTable() async {
//     final pdf = Document();

//     final headers = ['Nama', 'Umur'];

//     final users = [
//       User(name: 'jaja', age: 20),
//     ];
//     final data = users.map((user) => [user.name, user.age]).toList();

//     pdf.addPage(Page(build : (context) => Table.fromTextArray(
//       headers: headers;
//       data : data;
//     ) ));

//     return saveDocument(name: 'data_pemohon.pdf', pdf: pdf);
//   }

//   static Future<File> saveDocument({
//     @required String name,
//     @required pdf,
//   }) async {
//     final bytes = await pdf.save();

//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/$name');

//     await file.writeAsBytes(bytes);

//     return file;
//   }

//   static Future openFile(File file) async {
//     final url = file.path;

//     await OpenFile.open(url);
//   }
// }
