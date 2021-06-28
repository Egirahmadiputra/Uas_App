import './add.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uas_app/login.dart';

class HomePage extends StatelessWidget {
  Future<List> getData() async {
    final response = await http.get("http://127.0.0.1/uas_app/proses_data.php");
    return json.decode(response.body);
  }

  HomePage({this.username, this.password});
  final String username;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Customer'),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AddPage(),
        )),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildDrawer() {
    return SizedBox(
      width: 300,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('$username'),
              accountEmail: Text("Admin"),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/admin1.png"),
              ),
            ),
            _buildListTile(Icons.person, "$username", null),
            _buildListTile(Icons.school_outlined, "183510396", null),
            _buildListTile(Icons.school, "6D", null),
            _buildListTile(Icons.book_online, "Mobile Platform", null),
            Divider(
              height: 2.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    IconData iconLeading,
    String title,
    IconData iconTrailing,
  ) {
    return ListTile(
      leading: Icon(iconLeading),
      title: Text(title),
      trailing: Icon(iconTrailing),
      onTap: () {},
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  void deleteData(String userDelete) {
    var url = "http://127.0.0.1/uas_app/proses_delete.php";

    print(userDelete + ' Deleted');

    http.post(url, body: {'username': userDelete});
  }

  void confirm(context, String userDelete) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              new Text(
                "Hapus Akun Customer $userDelete?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              SizedBox(
                height: 10,
              ),
              new ElevatedButton(
                child: new Text(
                  "HAPUS",
                  style: new TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  deleteData(userDelete);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new HomePage(
                                username: username,
                                password: password,
                              )));
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 10,
              ),
              new ElevatedButton(
                child: new Text("BATAL",
                    style: new TextStyle(color: Colors.black)),
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () {
              confirm(context, list[i]['username']);
            },
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['username']),
                leading: new Icon(Icons.people_alt_sharp),
                subtitle:
                    new Text("status : ${list[i]['status']} || Hapus Data"),
              ),
            ),
          ),
        );
      },
    );
  }
}
