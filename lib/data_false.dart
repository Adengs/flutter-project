import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

class DataFalse extends StatefulWidget {
  @override
  _DataFalseState createState() => _DataFalseState();
}

class _DataFalseState extends State<DataFalse> {
  DateTime? tanggal;

  String getText() {
    if (tanggal == null) {
      return "Pilih Tanggal";
    } else {
      return DateFormat('dd-MM-yyyy').format(tanggal!);
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    //terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.notification!.title);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DataFalse();
        }));
      }
    });

    //background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {});

    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification!.title}');
      }
    });

    super.initState();
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
            "Data Belum Disetujui",
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colors.green[50],
        body: ListView(
          children: [
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
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                    // InkWell(
                    //   onTap: () {
                    //     createPdf();
                    //     setState(() {
                    //       FocusScope.of(context).unfocus();
                    //     });
                    //   },
                    //   child: Card(
                    //     margin: EdgeInsets.fromLTRB(15, 10, 15, 20),
                    //     elevation: 5,
                    //     shadowColor: Colors.black,
                    //     color: Colors.green[800],
                    //     child: Container(
                    //       margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    //       child: Center(
                    //         child: Icon(Icons.picture_as_pdf_outlined,
                    //             color: Colors.white, size: 30),
                    //       ),
                    //       // ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            getText().isEmpty
                ? Container()
                : StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection(getText())
                        .where('approve', isEqualTo: false)
                        .snapshots(),
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
                                    // showModalBottomSheet(
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.only(
                                    //           topLeft: Radius.circular(20),
                                    //           topRight: Radius.circular(20)),
                                    //     ),
                                    //     isScrollControlled: true,
                                    //     context: context,
                                    //     builder: (context) => BottomSheet2(
                                    //         isi: data[index].id,
                                    //         tgl: (data[index].data() as Map<
                                    //             String, dynamic>)['tanggal']));
                                    // print((data[index].data()
                                    //     as Map<String, dynamic>)['tanggal']);
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
                                    icon: Icon(Icons.approval_outlined,
                                        color: Colors.grey),
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
                                                title: Text('Konfirmasi Data'),
                                                content: Text(
                                                    'Apakah anda yakin untuk menyetujui data ini?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Tidak')),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await docRef.update(
                                                            {'approve': true});
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
      ),
    );
  }
}
