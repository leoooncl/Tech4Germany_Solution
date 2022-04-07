// Import Stuf //
import 'dart:convert'; // to convert Json file
import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:http/http.dart' as http;
import 'package:t4gopengov/GovData.dart'; //imports http protocol
import 'home_screen.dart';

// Functions
void main() => runApp(MaterialApp(
      home: HomeScreen(), //we could imagine more sides/ screen
    ));

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
// Widget listSection = Container(
//     color: Colors.blue,
//     child: ListView.builder(
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       // physics: NeverScrollableScrollPhysics(),
//       // addAutomaticKeepAlives: false,
//       // cacheExtent: 100,
//       itemBuilder: (context, index) {
//         return Card(
//           child: Column(children: const <Widget>[
//             Text('_notes[index].department'),
//             Text('_notes[index].datasets'),
//           ]),
//         );
//       },
//       itemCount: 50,
//     ));
