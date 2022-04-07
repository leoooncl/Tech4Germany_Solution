import 'dart:html';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class GovData {
  String? department; //Klasse GovData besteht aus den Einträgen
  int? datasets; // musste noch late hinzufügen um Nulleintrag zu verhindern

  GovData(this.department, this.datasets); //constructor

  GovData.fromJson(Map<String, dynamic> json) {
    //Jason -> String Funktion
    department = json['department'];
    datasets = json['datasets'];
  }

  // factory GovData.fromJson(dynamic json) {
  //   return GovData(json['department'] as String, json['age'] as int);
  // }
  // @override
  // String toString() {
  //   return '{ ${this.department}, ${this.datasets}}';
  // }
}

// main() {
//   String objText = '{"name": "bezkoder", "age":30}';
//   GovData govdata = GovData.fromJson(jsonDecode(objText));
//   print(govdata);
// }
