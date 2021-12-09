import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class KelolaJadwal extends StatefulWidget {
  @override
  _KelolaJadwalState createState() => _KelolaJadwalState();
}

class _KelolaJadwalState extends State<KelolaJadwal> {
  DateTime? tanggal;

  String getText() {
    if (tanggal == null) {
      return "Pilih Tanggal";
    } else {
      return DateFormat('dd-MM-yyyy').format(tanggal!);
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? isi;
  String? tgl;

  Future<void> tambahBaru() async {
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Pemberitahuan !'),
              content: Text(
                  'Proses menyimpan akan memakan waktu beberapa detik, Apakah anda ingin melanjutkan?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Tidak')),
                TextButton(
                    onPressed: () async {
                      for (int i = 0; i <= 17; i++) {
                        print(i);
                        await firestore.collection(getText()).add({
                          'libur': i,
                        });
                      }
                      Navigator.of(context).pop();

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Berhasil'),
                              content: Text('Berhasil Menambahkan Libur.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ok'))
                              ],
                            );
                          });
                    },
                    child: Text('Ya')),
              ],
            );
          });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[800],
          centerTitle: true,
          title: Text("Kelola Jadwal"),
        ),
        backgroundColor: Colors.green[50],
        body: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              elevation: 5,
              shadowColor: Colors.black,
              child: SizedBox(
                // height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: Text(
                          "Pilih tanggal libur",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                        child: Text(
                          '"Silahkan pilih tanggal untuk menentukan libur pada hari tertentu (selain sabtu dan minggu)."',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
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
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                                      // selectableDayPredicate: (DateTime val) =>
                                      //     val.weekday == 6 || val.weekday == 7
                                      //         ? false
                                      //         : true,
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

                    // Container(
                    //   margin: EdgeInsets.fromLTRB(10, 5, 10, 15),
                    //   child: Center(
                    //     child: ElevatedButton(
                    //       child: Text("Simpan"),
                    //       onPressed: () {
                    //         setState(() {
                    //           FocusScope.of(context).unfocus();
                    //         });
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         primary: Colors.green[800],
                    //         padding: EdgeInsets.all(5),
                    //         textStyle: TextStyle(
                    //             fontSize: 15, fontWeight: FontWeight.w400),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          tambahBaru();
                          setState(() {
                            FocusScope.of(context).unfocus();
                          });
                        },
                        child: Card(
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          elevation: 5,
                          shadowColor: Colors.black,
                          color: Colors.green[800],
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            // child: SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.02,
                            child: Center(
                              child: Text(
                                'Simpan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
