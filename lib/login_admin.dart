import 'package:ektp/halaman_admin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAdmin extends StatefulWidget {
  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String? error;

  // login function
  Future<void> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUser', true);

    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((v) => {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HalamanAdmin())),
                });
      } catch (e) {
        print(e);
        setState(() {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Pemberitahuan !!'),
                  content: Text('Email/Password yang anda masukan salah.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            error = null;
                          });
                        },
                        child: Text('Ok'))
                  ],
                );
              });
        });
      }
    }
  }

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
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
          title: Text("E-KTP RUMPIN"),
        ),
        backgroundColor: Colors.green[50],
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            reverse: true,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    height: MediaQuery.of(context).size.height * 0.23,
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
                  Center(
                    child: SizedBox(
                      child: Card(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Text(
                                    "Login Admin",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Theme(
                                      child: TextFormField(
                                        autocorrect: true,
                                        controller: emailController,
                                        cursorColor: Colors.green[800],
                                        cursorHeight: 20,
                                        style: TextStyle(fontSize: 18),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.person,
                                          ),
                                          labelText: "Email",
                                          labelStyle: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        textInputAction: TextInputAction.next,

                                        //validasi email
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ("Silahkan Masukan Email");
                                          }

                                          return null;
                                        },
                                        onSaved: (value) {
                                          emailController.text = value!;
                                        },
                                      ),
                                      data: ThemeData().copyWith(
                                        colorScheme: ThemeData()
                                            .colorScheme
                                            .copyWith(
                                                primary: Colors.green[800]),
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Theme(
                                      child: TextFormField(
                                        controller: passwordController,
                                        cursorColor: Colors.green[800],
                                        cursorHeight: 20,
                                        style: TextStyle(fontSize: 18),
                                        obscureText: _secureText,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock,
                                          ),
                                          labelText: "Password",
                                          labelStyle: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 16),
                                          suffixIcon: IconButton(
                                            onPressed: showHide,
                                            icon: _secureText
                                                ? Icon(Icons.visibility_off)
                                                : Icon(Icons.visibility),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        textInputAction: TextInputAction.done,

                                        //validasi password
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ("Silahkan Masukan Password");
                                          }

                                          return null;
                                        },
                                        onSaved: (value) {
                                          passwordController.text = value!;
                                        },
                                      ),
                                      data: ThemeData().copyWith(
                                        colorScheme: ThemeData()
                                            .colorScheme
                                            .copyWith(
                                                primary: Colors.green[800]),
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: ElevatedButton(
                                    child: Text("Masuk"),
                                    onPressed: () {
                                      login(emailController.text,
                                          passwordController.text);
                                      setState(() {});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green[800],
                                      textStyle: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
