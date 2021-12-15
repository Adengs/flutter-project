import 'package:ektp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ektp/kelola_data.dart';
import 'package:ektp/kelola_jadwal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> openUrl(String url,
    {bool forceWebView: false, bool enableJavaScript: false}) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceWebView: forceWebView, enableJavaScript: enableJavaScript);
  }
}

Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('isUser');

  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .pop(MaterialPageRoute(builder: (context) => HomePage()));
}

class HalamanAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            padding: EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                logout(context);
              },
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green[800],
          centerTitle: true,
          title: Text("Halaman Admin"),
        ),
        backgroundColor: Colors.green[50],
        body: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              elevation: 5,
              shadowColor: Colors.black,
              child: SizedBox(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green,
                              blurRadius: 80,
                            ),
                          ],
                          image: DecorationImage(
                              image: AssetImage(
                                  "images/Logo Kabupaten Bogor.png"))),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Halo Admin !",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    Container(
                      child: Text(
                          '"Silahkan tonton video dibawah ini untuk mengetahui \ncara menggunakan Aplikasi"',
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 12),
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: MediaQuery.of(context).size.height * 0.35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/yt.jpg"))),
                      child: GestureDetector(
                        onTap: () async {
                          await openUrl("https://youtu.be/ih-fD_6_bW8",
                              forceWebView: false, enableJavaScript: true);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10, 3, 10, 10),
              elevation: 5,
              shadowColor: Colors.black,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.11,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "     Kelola Data Pemohon E-KTP",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
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
                          return KelolaData();
                        }));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10, 3, 10, 10),
              elevation: 5,
              shadowColor: Colors.black,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.11,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "     Kelola Jadwal",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
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
                          return KelolaJadwal();
                        }));
                      },
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
