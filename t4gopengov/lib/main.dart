// Import Stuf //
import 'dart:convert'; // to convert Json file
import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:http/http.dart' as http;
import 'package:t4gopengov/GovData.dart'; //imports http protocol

// Functions
void main() => runApp(const MaterialApp(
      home: HomeScreen(), //we could imagine more sides/ screen
    ));

//Classes
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key})
      : super(key: key); //"const in front of HomeScreen"

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
              //When use a Scrollable Widget inside a Column, expand it
              child: FutureBuilder(
                  future: ReadJsonData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as List<GovData>;
                      return ListView.builder(
                          itemCount: items == null ? 0 : items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                    ),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Text(
                                              items[index]
                                                  .department
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Text(items[index]
                                                .datasets
                                                .toString()),
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
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

  Future<List<GovData>> ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('lib/assets/backend-response.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list
        .map((e) => GovData.fromJson(e))
        .toList(); //reads Data from Json and sends it to a map
  }
}

//Widget for the YouTubeList Video
/*
Widget YouTubeList = FutureBuilder(
    future: ReadJsonData(),
    builder: (context, data) {
      if (data.hasError) {
        return Center(child: Text("${data.error}"));
      } else if (data.hasData) {
        var items = data.data as List<GovData>;
        return ListView.builder(
            itemCount: items == null ? 0 : items.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                items[index].department.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Text(items[index].datasets.toString()),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
            });
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    

    });
*/

// Old Widget for the List section
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
            Text('_notes[index].department'),
            Text('_notes[index].datasets'),
          ]),
        );
      },
      itemCount: 50,
    ));

// Widget and Textfield for the selection of Dataset and Alphabet
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

// Checkbox Widged labeled
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
