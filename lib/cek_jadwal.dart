import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CekJadwal extends StatefulWidget {
  @override
  _CekJadwalState createState() => _CekJadwalState();
}

class _CekJadwalState extends State<CekJadwal> {
  final TextEditingController namnikController = TextEditingController();

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[800],
          centerTitle: true,
          title: Text(
            "Cek Jadwal Saya",
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colors.green[50],
        body: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                          "Pemberitahuan !!",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                        child: Text(
                          'Jika data anda tidak ada pada tanggal dipilih, berarti data belum disetujui atau dialihkan ke tanggal berikutnya. Silahkan cek secara berkala, terimakasih.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              elevation: 5,
              shadowColor: Colors.black,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
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
                            'Silahkan pilih tanggal untuk mengecek persetujuan data anda',
                            style: TextStyle(
                                fontSize: 10, fontStyle: FontStyle.italic),
                            // maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            getText().isEmpty
                ? Container()
                : StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection(getText())
                        .where('approve', isEqualTo: true)
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
                              margin: EdgeInsets.fromLTRB(10, 2.5, 10, 2.5),
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Container(
                                // margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                child: ListTile(
                                  onTap: () {},
                                  title: Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        '${(data[index].data() as Map<String, dynamic>)['nama']}',
                                        style: TextStyle(fontSize: 14),
                                      )),
                                  trailing: Text(
                                      '(${(data[index].data() as Map<String, dynamic>)['desa']})',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54)),
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
