import 'dart:convert'; // to convert Json file
import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:http/http.dart' as http;
import 'package:t4gopengov/GovData.dart'; //imports http protocol
import 'mycheckbox.dart';

//Classes
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDescending = false;

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
          Container(
            child: const Text('description'),
            color: Colors.white,
          ),
          sortingSection,
          const MyCheckbox(label: 'Datasets'),
          const MyCheckbox(label: 'asdf'),
          TextButton.icon(
            icon: RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.compare_arrows, size: 28),
            ),
            label: Text(
              isDescending ? 'Descending' : 'Ascending',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () => setState(() => isDescending = !isDescending),
          ),
          /*2* List*/
          Expanded(
              //When use a Scrollable Widget inside a Column, expand it
              child: FutureBuilder(
                  future: readJsonData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as List<GovData>;
                      return ListView.builder(
                          itemCount: items == null ? 0 : items.length,
                          itemBuilder: (context, index) {
                            final sortedItems = items
                              ..sort((item1, item2) => isDescending
                                  ? item2.department
                                      .toUpperCase()
                                      .compareTo(item1.department.toUpperCase())
                                  : item1.department.toUpperCase().compareTo(
                                      item2.department.toUpperCase()));
                            final item = sortedItems[index];

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
                                              item.department.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child:
                                                Text(item.datasets.toString()),
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
              //MyCheckbox(label: 'Datasets'),
              //MyCheckbox(label: 'asdf'),
            ],
          ),
        )
      ],
    ),
  );

  Future<List<GovData>> readJsonData() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('lib/assets/backend-response.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list
        .map((e) => GovData.fromJson(e))
        .toList(); //reads Data from Json and sends it to a map
  }
}

  // HomeScreen({Key? key}) : super(key: key); //"const in front of HomeScreen

  
