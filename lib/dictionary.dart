import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Future<List<String>> loadQuestions() async {
//     List<String> questions = [];
//     await rootBundle.loadString('assets/kamus.txt').then((q) {
//       for (String i in LineSplitter().convert(q)) {
//         questions.add(i);
//       }
//     });
//     return questions;
//   }

//   setup() async {
//     // Retrieve the questions (Processed in the background)
//     List<String> questions = await loadQuestions();

//     // Notify the UI and display the questions

//       _questions = questions;

//   }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Questions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAppScreen(),
    );
  }
}

class MyAppScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppScreenState();
  }
}

class MyAppScreenState extends State<MyAppScreen> {
  List<String> _questions = [];

  Future<List<String>> _loadQuestions() async {
    List<String> questions = [];
    await rootBundle.loadString('assets/kamus.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        questions.add(i);
      }
    });
    return questions;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the questions (Processed in the background)
    List<String> questions = await _loadQuestions();

    // Notify the UI and display the questions
    setState(() {
      _questions = questions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Questions")),
      body: Center(
        child: Container(
          child: _questions.contains('text')
              ? ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return Text(_questions[index]);
                  },
                )
              : Text('Tidak Ditemukan'),
        ),
      ),
    );
  }
}
