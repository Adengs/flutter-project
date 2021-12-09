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
  final TextEditingController nikController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController desaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime? tanggal;

  String? isi;
  String? tgl;

  String getText() {
    if (tanggal == null) {
      return "Pilih Tanggal";
    } else {
      return DateFormat('dd-MM-yyyy').format(tanggal!);
    }
  }

  Future<DocumentSnapshot> getData() async {
    DocumentReference docRef = firestore.collection(widget.tgl).doc(widget.isi);
    return docRef.get();
  }

  Future<void> editD() async {
    DocumentReference docData =
        firestore.collection(widget.tgl).doc(widget.isi);
    try {
      await docData.update({
        'nik': nikController.text,
        'nama': namaController.text,
        'desa': desaController.text,
      });
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FutureBuilder<DocumentSnapshot<Object?>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              namaController.text = data['nama'];
              nikController.text = data['nik'];
              desaController.text = data['desa'];
              return Container(
                height: MediaQuery.of(context).size.height * 0.73,
                padding: MediaQuery.of(context).viewInsets,
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
                            "Ubah data Pemohon E-KTP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Theme(
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: nikController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                          margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          child: Center(
                            child: ElevatedButton(
                              child: Text("Simpan"),
                              onPressed: () {
                                editD();

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
              );
            } else {}
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}