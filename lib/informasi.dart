import 'package:flutter/material.dart';

class Informasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: MediaQuery.of(context).size.height * 0.09,
              child: Center(
                child: Text(
                  "Persyaratan Pembuatan E-KTP\n Kecamatan Rumpin",
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
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Berusia 17 tahun",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                          "Usia pemohon tidak kurang dari 17 tahun ketika melakukan perekaman E-KTP.",
                          style: TextStyle(fontSize: 13)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Surat pengantar dari kantor Desa",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      subtitle: Text(
                          "Membawa surat pengantar dari kantor Desa setempat.",
                          style: TextStyle(fontSize: 13)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Fotocopy Kartu Keluarga (KK)",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      subtitle: Text(
                          "Setelah mendapatkan semua dokumen yang dibutuhkan, Anda harus menggandakannya. Pihak Kecamatan hanya membutuhkan selembar salinan untuk tiap dokumen, namun sebaiknya Anda memiliki dua atau tiga lembar Salinan untuk tiap dokumen.",
                          style: TextStyle(fontSize: 13)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Surat keterangan pindah dari kota asal",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      subtitle: Text(
                          "Surat ini diperlukan jika Pemohon bukan asli warga setempat.",
                          style: TextStyle(fontSize: 13)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Datang ke kantor Kecamatan",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      subtitle: Text(
                          "Pemohon harus datang sendiri ke Kantor Kecamatan, tidak dapat diwakilkan.",
                          style: TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
