import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart'; //imports http protocol

const GOVDATA_KEY = String.fromEnvironment(
    "GOVDATA_KEY"); //could be stored locally as system variable in launch.json
//in system variables: --dart-define=GOVDATE_KEY=
void main() {
  runApp(const MyApp());
}

//void APIfunction(){

//send API request to OpenGov
// http.post(Url);
//}

class MyApp extends StatelessWidget {
  //everything in Flutter is organized in widgets
  const MyApp({Key? key})
      : super(
            key:
                key); //MyApp is the name, StatelessWidget is one widget you can choose from

  @override //always need to override and then return what you want to show at the widget
  Widget build(BuildContext context) {
    return MaterialApp(
      //Widget from Flutter
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, //debug pannel gets away
      theme: ThemeData(
          //basic colors, themes,

          primarySwatch: Colors.green, //updates every color of the app
          scaffoldBackgroundColor: Colors.grey.shade800),
      home: const MyHomePage(
          title: 'How to make the governmant transparent - fast'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //another widget (internal state, that is kept, internal date that can be kept)
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Placeholder(),
    );
  }
}
