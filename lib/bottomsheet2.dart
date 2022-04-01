import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomSheet2 extends StatefulWidget {
  final String isi;
  final String tgl;
  const BottomSheet2({Key? key, required this.isi, required this.tgl})
      : super(key: key);

  @override
  _BottomSheet2State createState() => _BottomSheet2State();
}

class _BottomSheet2State extends State<BottomSheet2> {
  TextEditingController nikController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController desaController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime? tanggal;

  String? isi;
  String? tgl;

  String getText() {
    if (tanggal == null) {
      return widget.tgl;
    } else {
      return DateFormat('dd-MM-yyyy').format(tanggal!);
    }
  }

  Future<void> getData() async {
    final DocumentReference docRef =
        firestore.collection(widget.tgl).doc(widget.isi);

    var data = await docRef.get();

    namaController.text = (data.data() as Map<String, dynamic>)['nama'];
    nikController.text = (data.data() as Map<String, dynamic>)['nik'];
    tanggalController.text = (data.data() as Map<String, dynamic>)['tanggal'];
    desaController.text = (data.data() as Map<String, dynamic>)['desa'];
  }

  Future<void> editD() async {
    DocumentReference docData = firestore
        .collection(getText())
        .doc(namaController.text + nikController.text);
    DocumentReference docRef2 =
        firestore.collection(widget.tgl).doc(widget.isi);
    try {
      await docData.set({
        'nik': nikController.text,
        'nama': namaController.text,
        'tanggal': getText(),
        'desa': desaController.text,
        'approve': true,
      });
      docRef2.delete();
      Navigator.of(context).pop();

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Berhasil'),
              content: Text('Berhasil Mengubah Data.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            );
          });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.73,
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 5),
                  child: IconButton(
                      icon: Icon(Icons.close_rounded, size: 22),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Ubah data Pemohon E-KTP",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "NIK",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Theme(
                        child: TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.visiblePassword,
                          controller: nikController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
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
              margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Nama",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Theme(
                        child: TextFormField(
                          readOnly: true,
                          textCapitalization: TextCapitalization.characters,
                          controller: namaController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
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
              margin: EdgeInsets.fromLTRB(20, 5, 20, 2),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Tanggal",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Theme(
                        child: TextFormField(
                          // controller: tanggalController,
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
              margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Desa",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Theme(
                        child: TextFormField(
                          readOnly: true,
                          textCapitalization: TextCapitalization.words,
                          controller: desaController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
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
              margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
              child: Center(
                child: ElevatedButton(
                  child: Text("Simpan"),
                  onPressed: () {
                    editD();

                    setState(() {
                      // FocusScope.of(context).unfocus();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[800],
                    padding: EdgeInsets.all(5),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
