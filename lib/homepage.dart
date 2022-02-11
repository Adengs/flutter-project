import 'package:ektp/informasi.dart';
import 'package:ektp/login_admin.dart';
import 'package:ektp/pilih_jadwal.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<void> openUrl(String url,
    {bool forceWebView: false, bool enableJavaScript: false}) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceWebView: forceWebView, enableJavaScript: enableJavaScript);
  }
}

class HomePage extends StatelessWidget {
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
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //icon login admin
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(right: 8),
                  child: IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginAdmin();
                      }));
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.green[50],
      body: ListView(
        children: <Widget>[
          //Card kata sambutan dan logo
          Card(
            margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
            elevation: 5,
            shadowColor: Colors.black,
            child: SizedBox(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 0),
                    height: MediaQuery.of(context).size.height * 0.27,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green,
                          blurRadius: 90,
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage("images/Logo Kabupaten Bogor.png"),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 20),
                    child: Text(
                      "Selamat Datang",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Text(
                      "Aplikasi ini diperuntukan untuk melakukan penjadwalan perekaman E-KTP di Kecamatan Rumpin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Card(
            //card menu pertama
            margin: EdgeInsets.fromLTRB(10, 3, 10, 10),
            elevation: 5,
            shadowColor: Colors.black,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "     Persyaratan Pembuatan E-KTP",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      maxLines: 1,
                    ),
                  ),
                  IconButton(
                    color: Colors.green[800],
                    icon: Icon(Icons.navigate_next_rounded),
                    iconSize: 60,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Informasi();
                      }));
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            //card menu kedua
            margin: EdgeInsets.fromLTRB(10, 3, 10, 10),
            elevation: 5,
            shadowColor: Colors.black,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "     Pilih Jadwal Perekaman",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      maxLines: 1,
                    ),
                  ),
                  IconButton(
                    color: Colors.green[800],
                    icon: Icon(Icons.navigate_next_rounded),
                    iconSize: 60,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PilihJadwal();
                      }));
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            //card menu ketiga
            margin: EdgeInsets.fromLTRB(10, 3, 10, 10),
            elevation: 5,
            shadowColor: Colors.black,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "     Cara Mengatur Jadwal",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.youtube, color: Colors.red),
                      iconSize: 35,
                      onPressed: () async {
                        await openUrl("https://youtu.be/OXlPi6j_Wf0",
                            forceWebView: false, enableJavaScript: true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
