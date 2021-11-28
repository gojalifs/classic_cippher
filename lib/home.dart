import 'package:flutter/material.dart';
import 'about.dart';
import 'screen.dart';

final ciphers = [
  'CAESAR CIPHER',
  'ROT13',
  // 'KUNCI ABJAD TIDAK TERATUR',
  // 'KUNCI ABJAD KALIMAT BERMAKNA',
  'AFFINE CIPHER',
  'OTP',
  // 'KUNCI BERULANG',
  'VIGENERE CIPHER',
  // 'HOMOFONIC',
  'PLAYFAIR CIPHER',
  // 'TRANSPOSISI',
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                })
          ],
          title:
              Text('CIPHERS ALGORYTHM', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: ciphers.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.015,
                  left: MediaQuery.of(context).size.height * 0.015,
                  right: MediaQuery.of(context).size.height * 0.015,
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Screen(title: ciphers[index])));
                  },
                  leading: Icon(Icons.lock, color: Colors.black),
                  title: Text(ciphers[index]),
                ),
              );
            }));
  }
}
