// Import Stuf //
import 'dart:convert';
import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //imports http protocol

// Global Constants //
const GOVDATA_KEY = String.fromEnvironment(
    "GOVDATA_KEY"); //could be stored locally as system variable in launch.json
//in system variables: --dart-define=GOVDATE_KEY=

// Functions
void main() {
  runApp(const MyApp());
}

void APIfunction() {
//send API request to OpenGov
  var prompt; //created because otherwise problem
  http.post(
    //http in improt is the variable //YT Video 42:52
    Uri.parse("https://"),
    headers: {
      "Authorization":
          "Bearer GOVDATA_KEY", //here needs to go the variable from the launch.json file
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "prompt": prompt,
      "max_tokens": 100,
      "temperature": 0,
      "top_p": 1,
      "stop": "\n",
    }),
  );
}

class MyApp extends StatelessWidget {
  //everything in Flutter is organized in widgets
  const MyApp({Key? key}) : super(key: key);
  //MyApp is the name, StatelessWidget is one widget you can choose from
  @override //always need to override and then return what you want to show at the widget
  Widget build(BuildContext context) {
    return MaterialApp(
      //Widget from Flutter
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, //debug pannel gets away

      theme: ThemeData(
          //basic colors, themes,

          primaryColor: Colors.white,
          primarySwatch: Colors.pink, //updates every color of the app
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
        centerTitle: true, // Titel wird zentriert
        textTheme: Theme.of(context).textTheme.apply(
              //
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
      ),
      body: Placeholder(),
    );
  }
}

class Sorting_ extends StatefulWidget {
  const Sorting_({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("Hallo Welt"),
        Text("Hallo neue Welt"),
      ],
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
