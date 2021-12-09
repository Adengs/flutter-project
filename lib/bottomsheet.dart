import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomSheet1 extends StatefulWidget {
  final String tgl;
  const BottomSheet1({Key? key, required this.tgl}) : super(key: key);

  @override
  _BottomSheet1State createState() => _BottomSheet1State();
}

class _BottomSheet1State extends State<BottomSheet1> {
  final TextEditingController nikController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
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

  Future<void> tambahBaru() async {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      try {
        await firestore
            .collection(widget.tgl)
            .doc(namaController.text + nikController.text)
            .set({
          'nik': nikController.text,
          'nama': namaController.text,
          'tanggal': widget.tgl,
          'desa': desaController.text,
        });
        Navigator.of(context).pop();

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Berhasil'),
                content: Text('Berhasil Menambahkan Data.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        height: MediaQuery.of(context).size.height * 0.73,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    "Tambah data Pemohon E-KTP",
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
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
                                hintText: "Masukan 6 angka terakhir NIK",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              textInputAction: TextInputAction.next,

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
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Theme(
                            child: TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: namaController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: "Masukan Nama",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              textInputAction: TextInputAction.next,

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
                              textCapitalization: TextCapitalization.words,
                              controller: desaController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: "Masukan Nama Desa",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              textInputAction: TextInputAction.done,

                              //validasi nama
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Silahkan masukan nama Desa");
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
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Center(
                    child: ElevatedButton(
                      child: Text("Simpan"),
                      onPressed: () {
                        tambahBaru();

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
    );
  }
}
