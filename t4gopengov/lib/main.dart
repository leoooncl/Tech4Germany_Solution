// Import Stuf //
import 'dart:convert'; // to convert Json file
import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //imports http protocol

// Global Constants //
const GOVDATA_KEY = String.fromEnvironment(
    "GOVDATA_KEY"); //could be stored locally as system variable in launch.json
//in system variables: --dart-define=GOVDATE_KEY=

// Functions
void main() => runApp(const MaterialApp(
      home: HomeScreen(), //we could imagine more sides/ screen
    ));

//API request
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
    //return json
  );
}

//Classes
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override //redefining the build function of Stateless Widget
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'How to make the government transparent - fast',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        // Zeilen in denen die verschiedenen Elemente aufgelistet sind
        children: [
          /*1* Sorting*/
          sortingSection,
          MyCheckboxDataset(), //wahrscheinlich unterstrichen, da Klassen und Widgets gemischt werden
          MyCheckboxAlphabet(),
          /*2* List*/
          Expanded(
              child:
                  listSection), //When use a Scrollable Widget inside a Column, expand it
          Container(
            child: const Text('This is the bottom'),
            color: Colors.green,
          )
        ],
      ),
      //floatingActionButton: const FloatingActionButton(
      //onPressed: null,
      //child: Text('cick'),
      //),
    );
  }
}

// Widget for the List sectioin
Widget listSection = Container(
    color: Colors.blue,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      // physics: NeverScrollableScrollPhysics(),
      // addAutomaticKeepAlives: false,
      // cacheExtent: 100,
      itemBuilder: (context, index) {
        return Card(
          child: Column(children: const <Widget>[
            Text('Department'),
            Text('Amount of Datasets'),
          ]),
        );
      },
      itemCount: 50,
    ));

// Widget for the selection of Dataset and Alphabet
Widget sortingSection = Container(
  padding: const EdgeInsets.all(32),
  decoration: BoxDecoration(color: Colors.green),
  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start, //don't know some kind of align
    children: [
      const Text(
        'Please sort by:',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      Container(
        color: Colors.blue,
        child: Row(
          children: const [
            //MyCheckboxAlphabet(),
            //MyCheckboxDataset(),
          ],
        ),
      )
    ],
  ),
);

// Widget for CheckboxListTile
class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Checkbox for Dataset
class MyCheckboxDataset extends StatefulWidget {
  const MyCheckboxDataset({Key? key}) : super(key: key);

  @override
  State<MyCheckboxDataset> createState() => _MyCheckboxDatasetState();
}

class _MyCheckboxDatasetState extends State<MyCheckboxDataset> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return LabeledCheckbox(
      label: 'Datasets',
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      },
    );
  }
}

// Checkbox for Alphabet
class MyCheckboxAlphabet extends StatefulWidget {
  const MyCheckboxAlphabet({Key? key}) : super(key: key);

  @override
  State<MyCheckboxAlphabet> createState() => _MyCheckboxAlphabetState();
}

class _MyCheckboxAlphabetState extends State<MyCheckboxAlphabet> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return LabeledCheckbox(
      label: 'Alphabet',
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      },
    );
  }
}
