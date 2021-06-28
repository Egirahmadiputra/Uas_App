import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas_app/homepage.dart';
import './login.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => new _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController conName = new TextEditingController();
  TextEditingController conNpm = new TextEditingController();
  TextEditingController conStatus = new TextEditingController();

  void addData() {
    var url = "http://127.0.0.1/uas_app/proses_add.php";

    http.post(url, body: {
      "username": conName.text,
      "password": conNpm.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tambah Data Customer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: conName,
                  decoration:
                      new InputDecoration(hintText: "Nama", labelText: "Nama"),
                ),
                new TextField(
                  controller: conNpm,
                  decoration:
                      new InputDecoration(hintText: "ID", labelText: "ID"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new ElevatedButton(
                  child: new Text("Tambah Customer"),
                  onPressed: () {
                    addData();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new HomePage(
                                  username: username,
                                  password: password,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
