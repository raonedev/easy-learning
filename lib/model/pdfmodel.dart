import 'package:flutter/material.dart';

class Pdfdata {
  String? title;
  String? url;
  Pdfdata({required this.title, required this.url});
  Pdfdata.jsondata(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
  }
}
