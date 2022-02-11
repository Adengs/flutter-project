import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ektp/bottomsheet2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ektp/bottomsheet.dart';

class KelolaData extends StatefulWidget {
  @override
  _KelolaDataState createState() => _KelolaDataState();
}

class _KelolaDataState extends State<KelolaData> {
  DateTime? tanggal;

  String getText() {
    if (tanggal == null) {
      return "Pilih Tanggal";
    } else {
      return DateFormat('dd-MM-yyyy').format(tanggal!);
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createPdf() async {
    final snapshot = await firestore.collection(getText()).get();
    List<List<dynamic>> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return [
        (documentSnapshot.data() as Map<String, dynamic>)['nama'].toString(),
        (documentSnapshot.data() as Map<String, dynamic>)['nik'].toString(),
        (documentSnapshot.data() as Map<String, dynamic>)['tanggal'].toString(),
        (documentSnapshot.data() as Map<String, dynamic>)['desa'].toString(),
      ];
    }).toList();

    //buat class pdf
    final pdf = pw.Document();

    final headers = ['Nama', 'NIK', 'Tanggal', 'Desa'];

    //buat pages
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            //judul
            pw.Container(
                width: double.infinity,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text("DATA PEREKAM E-KTP TANGGAL ${getText()}\n\n",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold)),
                  ],
                )),
            //table
            pw.Container(
                width: double.infinity,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Table.fromTextArray(
                        headers: headers,
                        data: newList,
                        cellAlignment: pw.Alignment.center,
                        headerDecoration:
                            pw.BoxDecoration(color: PdfColors.blue100),
                      ),
                    ])),
          ];

          // Center
        }));

    //simpan
    Uint8List bytes = await pdf.save();

    //buat file kosong di direktori
    final dir = await getApplicationDocumentsDirectory();
    final file =
        File('${dir.path}/Data Perekam E-KTP tanggal ${getText()}.pdf');

    //timpa file kosong
    await file.writeAsBytes(bytes);

    //open pdf
    await OpenFile.open(file.path);
  }

  String? isi;
  String? tgl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[800],
          centerTitle: true,
          title: Text(
            "Kelola Data",
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colors.green[50],
        body: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              elevation: 5,
              shadowColor: Colors.black,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: Text(
                    "Kelola Data Pemohon E-KTP",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
              elevation: 5,
              shadowColor: Colors.black,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Tanggal",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Theme(
                                child: TextField(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      locale: const Locale("id", "ID"),
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2100),
                                    ).then((value) {
                                      setState(() {
                                        tanggal = value;
                                      });
                                    });
                                  },
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.date_range_outlined,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: getText(),
                                    hintStyle: TextStyle(fontSize: 13),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                data: ThemeData().copyWith(
                                  colorScheme: ThemeData()
                                      .colorScheme
                                      .copyWith(primary: Colors.green[800]),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Note : ',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            'Silahkan pilih tanggal untuk menampilkan data pemohon',
                            style: TextStyle(
                                fontSize: 10, fontStyle: FontStyle.italic),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        createPdf();
                        setState(() {
                          FocusScope.of(context).unfocus();
                        });
                      },
                      child: Card(
                        margin: EdgeInsets.fromLTRB(15, 10, 15, 20),
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Colors.green[800],
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Center(
                            child: Icon(Icons.picture_as_pdf_outlined,
                                color: Colors.white, size: 30),
                          ),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            getText().isEmpty
                ? Container()
                : StreamBuilder<QuerySnapshot>(
                    stream: firestore.collection(getText()).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!.docs;
                        return SingleChildScrollView(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) => Card(
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                child: ListTile(
                                  onTap: () {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                        ),
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) => BottomSheet2(
                                            isi: data[index].id,
                                            tgl: (data[index].data() as Map<
                                                String, dynamic>)['tanggal']));
                                    print((data[index].data()
                                        as Map<String, dynamic>)['tanggal']);
                                  },
                                  title: Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        '${(data[index].data() as Map<String, dynamic>)['nama']}',
                                        style: TextStyle(fontSize: 14),
                                      )),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'NIK : ${(data[index].data() as Map<String, dynamic>)['nik']}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Tanggal : ${(data[index].data() as Map<String, dynamic>)['tanggal']}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Desa : ${(data[index].data() as Map<String, dynamic>)['desa']}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      DocumentReference docRef = firestore
                                          .collection((data[index].data()
                                                  as Map<String, dynamic>)[
                                              'tanggal'])
                                          .doc(data[index].id);
                                      try {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Hapus Data'),
                                                content: Text(
                                                    'Apakah anda yakin untuk menghapus data ini?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Tidak')),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await docRef.delete();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Ya')),
                                                ],
                                              );
                                            });
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Text('Loading . . .',
                            textAlign: TextAlign.center);
                      }
                    }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                isScrollControlled: true,
                context: context,
                builder: (context) => BottomSheet1(
                      tgl: getText(),
                    ));
            print(getText());
          },
          backgroundColor: Colors.green[800],
        ),
      ),
    );
  }
}
