import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './homepage.dart';

String username = '';
String password = '';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController status = new TextEditingController();

  String msg = '';
  var _status = ['admin', 'customer'];
  var _currentItemSelected = 'admin';

  Future<List> _proseslogin() async {
    final response =
        await http.post("http://127.0.0.1/uas_app/proses_login.php", body: {
      "username": user.text,
      "password": pass.text,
      "status": status.text,
    });
    var dataadmin = json.decode(response.body);

    if (dataadmin.length == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(username: username)));
      setState(() {
        username = dataadmin[0]['username'];
      });
    } else {
      setState(() {
        msg = "Login Gagal";
      });
    }
    return dataadmin;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.lightBlue, Colors.white])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      new Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 75.0,
                          child: Image.asset('assets/images/pp.png'),
                        ),
                      ),
                      new Center(
                          child: new Text("UAS MOBILE PLATFORM",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                          controller: user..text = 'Egi Rahmadi Putra',
                          style: TextStyle(fontSize: 18),
                          obscureText: false,
                          decoration: InputDecoration(
                              icon: Icon(Icons.people),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              labelText: 'Username',
                              fillColor: Color(0xfff3f3f4),
                              filled: true))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                          controller: pass..text = '183510396',
                          style: TextStyle(fontSize: 18),
                          obscureText: false,
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock_open),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              labelText: 'Password',
                              fillColor: Color(0xfff3f3f4),
                              filled: true)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Status',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                        icon: Icon(
                          Icons.accessibility,
                          size: 16.0,
                        ),
                        isExpanded: true,
                        items: _status.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        },
                        value: _currentItemSelected,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.blue[500], Colors.blue[500]])),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    _proseslogin();
                  },
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
      status.text = _currentItemSelected;
    });
  }
}
