import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PilihJadwal extends StatefulWidget {
  @override
  _PilihJadwalState createState() => _PilihJadwalState();
}

class _PilihJadwalState extends State<PilihJadwal> {
  final TextEditingController nikController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController desaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime? tanggal;

  String getText() {
    if (tanggal == null) {
      return "Pilih Tanggal";
    } else {
      return DateFormat('dd-MM-yyyy').format(tanggal!);
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<int> maxDoc() async {
    final _max = await firestore.collection(getText()).get();
    return _max.docs.length;
  }

  show() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pemberitahuan !!'),
            content: Text(
                'Kuota sudah melebihi batas, silahkan pilih tanggal lain !'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  show2() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pemberitahuan !!'),
            content: Text(
                'Mohon maaf Kantor Kecamatan libur pada tanggal tersebut, silahkan pilih tanggal lain !'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[800],
          centerTitle: true,
          title: Text(
            "E-KTP RUMPIN",
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colors.green[50],
        body: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              elevation: 5,
              shadowColor: Colors.black,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: Text(
                    "Pilih Jadwan Perekaman E-KTP",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              elevation: 5,
              shadowColor: Colors.black,
              child: SizedBox(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                "NIK",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Theme(
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: nikController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: "Masukan 6 angka tereakhir NIK",
                                      hintStyle: TextStyle(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),

                                    //validasi nik
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Silahkan masukan NIK sesuai KK");
                                      }
                                      if (value.length < 6) {
                                        return ("NIK anda kurang dari 6 karakter");
                                      }

                                      return null;
                                    },
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
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Nama",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Theme(
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    controller: namaController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: "Masukan Nama",
                                      hintStyle: TextStyle(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),

                                    //validasi nama
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Silahkan masukan nama lengkap anda");
                                      }

                                      return null;
                                    },
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
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 2),
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
                                  child: TextFormField(
                                    onTap: () {
                                      DateTime now = DateTime.now();
                                      showDatePicker(
                                        context: context,
                                        locale: const Locale("id", "ID"),
                                        initialDate: now,
                                        firstDate: now.add(
                                          const Duration(
                                            days: 0,
                                          ),
                                        ),
                                        lastDate: now.add(const Duration(
                                          days: 60,
                                        )),

                                        // selectableDayPredicate:
                                        //     (DateTime val) =>
                                        //         val.weekday == 6 ||
                                        //                 val.weekday == 7
                                        //             ? false
                                        //             : true,
                                      ).then((value) {
                                        setState(() {
                                          tanggal = value!;
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
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                " ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Text(
                                  ' Sabtu dan minggu (S & M) kantor kecamatan libur/tutup.',
                                  style: TextStyle(
                                      fontSize: 9, fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Desa",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Theme(
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controller: desaController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: "Masukan Nama Desa",
                                      hintStyle: TextStyle(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),

                                    //validasi nama
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Silahkan masukan nama desa anda");
                                      }

                                      return null;
                                    },
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
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 15),
                        child: Center(
                          child: ElevatedButton(
                            child: Text("Simpan"),
                            onPressed: () async {
                              int docMax = await maxDoc();
                              if (_formKey.currentState!.validate()) {
                                try {
                                  if (docMax < 15) {
                                    await firestore
                                        .collection(getText())
                                        .doc(namaController.text +
                                            nikController.text)
                                        .set(
                                      {
                                        'nik': nikController.text,
                                        'nama': namaController.text,
                                        'tanggal': getText(),
                                        'desa': desaController.text,
                                      },
                                    );
                                  } else if (docMax >= 17) {
                                    show2();
                                  } else {
                                    show();
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                              setState(() {
                                FocusScope.of(context).unfocus();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[800],
                              padding: EdgeInsets.all(5),
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            nikController.text.isEmpty ||
                    namaController.text.isEmpty ||
                    getText().isEmpty ||
                    desaController.text.isEmpty
                ? Container()
                : StreamBuilder<DocumentSnapshot>(
                    stream: firestore
                        .collection(getText())
                        .doc(namaController.text + nikController.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!.data();
                        return data == null
                            ? Container()
                            : Card(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                elevation: 5,
                                shadowColor: Colors.black,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Column(children: <Widget>[
                                      Text(
                                        "JADWAL PEREKAMAN E-KTP",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(),
                                      Table(
                                        columnWidths: {
                                          0: FlexColumnWidth(2),
                                          1: FlexColumnWidth(2),
                                          2: FlexColumnWidth(1),
                                          3: FlexColumnWidth(4),
                                        },
                                        children: [
                                          TableRow(children: [
                                            TableCell(child: Text(" ")),
                                            TableCell(child: Text("Nama")),
                                            TableCell(child: Text(":")),
                                            TableCell(
                                                child: Text(
                                                    "${(data as Map<String, dynamic>)['nama']}")),
                                            TableCell(child: Text(" ")),
                                          ]),
                                          TableRow(children: [
                                            TableCell(child: Text(" ")),
                                            TableCell(child: Text("NIK")),
                                            TableCell(child: Text(":")),
                                            TableCell(
                                              child: Text(
                                                "${data['nik']}",
                                                maxLines: 1,
                                              ),
                                            ),
                                            TableCell(child: Text(" ")),
                                          ]),
                                          TableRow(children: [
                                            TableCell(child: Text(" ")),
                                            TableCell(child: Text("Tanggal")),
                                            TableCell(child: Text(":")),
                                            TableCell(
                                                child: Text(
                                                    "${data['tanggal']}",
                                                    maxLines: 1)),
                                            TableCell(child: Text(" ")),
                                          ]),
                                          TableRow(children: [
                                            TableCell(child: Text(" ")),
                                            TableCell(child: Text("Desa")),
                                            TableCell(child: Text(":")),
                                            TableCell(
                                                child: Text("${data['desa']}")),
                                            TableCell(child: Text(" ")),
                                          ]),
                                        ],
                                      ),
                                      Divider(),
                                      Text(
                                        "Silahkan screenshot halaman ini sebagai bukti untuk ditunjukan ke petugas.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      Divider(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "PENTING !! ",
                                          ),
                                          Text(
                                            "Datang sebelum pukul 07.30 agar dapat cepat di proses,",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            "karena sewaktu-waktu server pusat (Kabupaten) bisa offline.",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            "Dan jangan lupa lengkapi persyaratan perekaman E-KTP.",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
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
      ),
    );
  }
}
